Rails.application.config.active_job.queue_adapter = :delayed_job

Delayed::Worker.logger = Rails.logger