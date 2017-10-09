class CleanVisitsEventsJob < ApplicationJob
  queue_as :default

  def perform
    DatabaseCleaner.clean_with :truncation,{:only => %w[visits ahoy_events], :reset_ids => true}
  end

  # def self.disable!
  #   # set a flag in Redis, it will expire after 10 minutes
  #   Sidekiq.redis {|c| c.set("disable_periodic_jobs", 1, ex: 60) }
  # end
end
