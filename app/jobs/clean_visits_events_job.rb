class CleanVisitsEventsJob < ApplicationJob
  queue_as :default

  def perform
    DatabaseCleaner.clean_with :truncation,{:only => %w[visits ahoy_events], :reset_ids => true}
  end
end
