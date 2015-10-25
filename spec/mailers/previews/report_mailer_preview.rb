# Preview all emails at http://localhost:3000/rails/mailers/report
class ReportMailerPreview < ActionMailer::Preview
  def preview
    r = ReportInfo.new

    r.emails = "wschenk@gmail.com"
    r.subject = "Daily report for \#{Time.now.strftime( \"%Y-%m-%d\" )}" 
    r.models = "Crush, Identity, InstagramUser, InstagramPost.updated_at, InstagramLike"

    current_subject = eval "\"#{r.subject}\""
    data = r.load_data

    ReportMailer.daily_report( "wschenk@gmail.com", current_subject, r.models.split( /,/ ), data )
  end
end
