class ReportInfo < ActiveRecord::Base
  validate :emails_are_comma_seperated

  def emails_are_comma_seperated
    if self.emails.blank?
      errors.add( :emails, "can't be blank" )
    else
      email_array = self.emails.split( /\s*,\s*/ )
      email_array.each do |e|
        unless e =~ /@/
          errors.add( :emails, "#{e} doesn't look like a valid email address" )
        end
      end

      self.emails = email_array.join( ", " )
    end
  end

  validate :models_really_exist

  def models_really_exist
    if self.models.blank?
      errors.add( :models, "can't be blank" )
    else
      model_array = self.models.split( /\s*,\s*/ )
      model_array.each do |m|
        model, key = m.split /\./
        begin
          eval model
        rescue
          errors.add( :models, "#{m} doesn't look like a valid model" )
        end
      end

      self.models = model_array.join( ", " )
    end
  end

  validate :default_subject

  def default_subject
    if self.subject.blank?
      self.subject = 'Daily report for #{Time.now.strftime( "%Y-%m-%d" )}'
    end
  end

  def model_list
    self.models.split( /\s*,\s*/ ) #.collect { |x| eval x }
  end

  def load_data
    data = {}
    model_list.collect do |model_info|
      model_name, key = model_info.split /\./
      key ||= "created_at"

      model = eval model_name

      r = {}
      model.group_by_day( key ).each do |k,v|
        new_k = k.gsub( /\s.*/, "" )
        r[new_k] = v
      end

      r
    end
  end

  def send_report
    current_subject = eval "\"#{self.subject}\""
    data = load_data

    self.emails.split( /\s*,\s*/ ).each do |e|
      ReportMailer.daily_report(e, current_subject, model_list.split( /,/ ), data).deliver_now
    end
  end
end