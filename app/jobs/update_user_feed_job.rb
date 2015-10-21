class UpdateUserFeedJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    user = User.find args[0]

    user.update_attribute :state, 'working'

    user.sync!
  end
end
