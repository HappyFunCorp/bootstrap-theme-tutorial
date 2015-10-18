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

    likers.each do |v|
      results[v['instagram_user_id']] ||= 0
      results[v['instagram_user_id']] += v['cnt'].to_i
      liked_total[v['instagram_user_id']] = v['cnt'].to_i
    end

    comments.each do |v|
      results[v['instagram_user_id']] ||= 0
      results[v['instagram_user_id']] += v['cnt'].to_i
      comment_total[v['instagram_user_id']] = v['cnt'].to_i

    end

    c = results.sort_by { |id,cnt| -cnt }.first


    crush_user = InstagramUser.find c[0]
    slug = "#{user.instagram_user.username} #{crush_user.username}".hash.abs.to_s(36)

    create  user: user, 
            instagram_user_id: user.instagram_user.id,
            main_username: user.instagram_user.username,
            crush_user_id: c[0],
            crush_username: crush_user.username,
            comment_count: comment_total[c[0]], 
            liked_count: liked_total[c[0]],
            slug: slug
  end

  def make_image
    response = Faraday.get crush_user.profile_picture
    crush_file = Tempfile.new ["crush", ".jpg"]
    # crush_file = File.new( "crush.jpg", "wb" )
    crush_file.binmode
    crush_file.write response.body
    crush_file.close

    response = Faraday.get instagram_user.profile_picture
    self_file = Tempfile.new ["self", ".jpg"]
    # self_file = File.new "self.jpg", "wb"
    self_file.binmode
    self_file.write response.body
    self_file.close

    outfile = Tempfile.new ["self", ".jpg"]
    outfile_name = outfile.path.to_s
    p outfile_name


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

    # self_image.composite! 
    crush_image = Magick::Image.read( crush_file.path ).first
    crush_image.matte = true
    crush_image.composite!(mask, Magick::CenterGravity, Magick::CopyOpacityCompositeOp)

    heart_image = Magick::Image.read( File.join( Rails.root, "app/assets/images/heart.png" ).to_s ).first

    out_image = Magick::Image.new( 300, 150 )
    
    out_image.composite! self_image, 0, 0, Magick::OverCompositeOp
    out_image.composite! crush_image, 150, 0, Magick::OverCompositeOp
    out_image.composite! heart_image, 112, 50, Magick::OverCompositeOp

    out_image.write outfile_name

    system "open #{outfile_name}"

    # outfile.close

  end
end
