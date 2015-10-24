class Crush < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: :slugged

  belongs_to :user
  belongs_to :instagram_user
  belongs_to :crush_user, class_name: InstagramUser

  def self.find_for_user( user )
    likers = InstagramLike.top_likers_ids user.instagram_user
    comments = InstagramComment.top_commentors_ids user.instagram_user

    results = {}
    comment_total = {}
    liked_total = {}

    likers.select do |v|
      v['instagram_user_id'].to_i != user.instagram_user.id
    end.each do |v|
      results[v['instagram_user_id']] ||= 0
      results[v['instagram_user_id']] += v['cnt'].to_i
      liked_total[v['instagram_user_id']] = v['cnt'].to_i
    end

    comments.select do |v|
      v['instagram_user_id'].to_i != user.instagram_user.id
    end.each do |v|
      results[v['instagram_user_id']] ||= 0
      results[v['instagram_user_id']] += v['cnt'].to_i
      comment_total[v['instagram_user_id']] = v['cnt'].to_i

    end

    c = results.sort_by { |id,cnt| -cnt }.first

    crush_user_id = (c && c[0]) || user.instagram_user.id

    crush = Crush.where( instagram_user_id: user.instagram_user.id, crush_user_id: crush_user_id ).first_or_create do |crush|
      crush_user = InstagramUser.find crush_user_id
      slug = "#{user.instagram_user.username} #{crush_user.username}".hash.abs.to_s(36)

      crush.user = user
      crush.main_username = user.instagram_user.username
      crush.crush_username = crush_user.username
      crush.slug = slug

      crush.make_image
    end

    crush.comment_count = comment_total[crush_user_id]
    crush.liked_count = liked_total[crush_user_id]
    crush.save


    crush
  end

  def make_image
    logger.debug "Loading #{crush_user.profile_picture}"
    response = Faraday.get crush_user.profile_picture
    crush_file = Tempfile.new ["crush", ".jpg"]
    # crush_file = File.new( "crush.jpg", "wb" )
    crush_file.binmode
    crush_file.write response.body
    crush_file.close

    logger.debug "Loading #{instagram_user.profile_picture}"
    response = Faraday.get instagram_user.profile_picture
    self_file = Tempfile.new ["self", ".jpg"]
    # self_file = File.new "self.jpg", "wb"
    self_file.binmode
    self_file.write response.body
    self_file.close

    outfile = Tempfile.new ["self", ".jpg"]
    outfile_name = outfile.path.to_s

    if ENV['BOO']
      draw_boo_image self_file, crush_file, outfile_name
    else
      draw_regular_image self_file, crush_file, outfile_name
    end

    # system( "open #{outfile_name}")

    save_to_s3 outfile_name

    outfile.close
  end

  def draw_regular_image self_file, crush_file, outfile_name
    circle = Magick::Image.new 150, 150
    gc = Magick::Draw.new
    gc.fill 'black'
    gc.circle 75, 75, 0, 75
    gc.draw circle

    mask = circle.blur_image(0,1).negate
    mask.matte = false

    self_image = Magick::Image.read( self_file.path ).first
    self_image.matte = true
    self_image.composite!(mask, Magick::CenterGravity, Magick::CopyOpacityCompositeOp)

    crush_image = Magick::Image.read( crush_file.path ).first
    crush_image.matte = true
    crush_image.composite!(mask, Magick::CenterGravity, Magick::CopyOpacityCompositeOp)

    heart_image = Magick::Image.read( File.join( Rails.root, "app/assets/images/heart.png" ).to_s ).first

    logger.debug "Generated crush image"
    out_image = Magick::Image.new( 300, 150 )
    
    out_image.composite! self_image, 150, 0, Magick::OverCompositeOp
    out_image.composite! crush_image, 0, 0, Magick::OverCompositeOp
    out_image.composite! heart_image, 112, 50, Magick::OverCompositeOp

    out_image.write outfile_name
  end

  def draw_boo_image self_file, crush_file, outfile_name
    circle = Magick::Image.new 155, 155
    gc = Magick::Draw.new
    gc.fill 'black'
    gc.circle 75, 75, 3, 75
    gc.draw circle

    # mask = circle.blur_image(0,1).negate
    mask = circle.negate
    mask.matte = false

    white_circle = Magick::Image.new 180, 180 do |c|
      c.background_color= "Transparent"
    end

    gc = Magick::Draw.new
    gc.stroke 'white'
    gc.stroke_width 10
    # gc.circle 75, 75, 6, 75
    gc.circle 80, 80, 8, 80
    gc.draw white_circle

    self_image = Magick::Image.read( self_file.path ).first
    self_image.matte = true
    self_image.composite!(mask, Magick::CenterGravity, Magick::CopyOpacityCompositeOp)

    crush_image = Magick::Image.read( crush_file.path ).first
    crush_image.matte = true
    crush_image.composite!(mask, Magick::CenterGravity, Magick::CopyOpacityCompositeOp)

    logger.debug "Generated crush image"

    heart_image = Magick::Image.read( File.join( Rails.root, "app/assets/images/fb_boo_badge1x.png" ).to_s ).first

    out_image = Magick::Image.read( File.join( Rails.root, "app/assets/images/fb_bkg1x.png" ).to_s ).first

    
    out_image.composite! white_circle, 390, 60, Magick::OverCompositeOp
    out_image.composite! self_image, 397, 67, Magick::OverCompositeOp

    out_image.composite! white_circle, 256, 60, Magick::OverCompositeOp
    out_image.composite! crush_image, 263, 67, Magick::OverCompositeOp

    out_image.composite! heart_image, 377, 160, Magick::OverCompositeOp

    out_image.write outfile_name
  end

  def save_to_s3 filename
    service = Aws::S3::Resource.new

    logger.debug "Uploading #{filename} to S3"
    bucket = service.bucket ENV['IMAGE_BUCKET_NAME']
    object = bucket.object "crushes/#{slug}.jpg"
    object.upload_file filename, {acl: 'public-read'}

    url = object.public_url.to_s
    logger.debug "File is now at #{url}"

    update_attribute :image_path, url
  end

  def show_image?
    !ENV['BOO'] && !image_path.blank?
  end
end