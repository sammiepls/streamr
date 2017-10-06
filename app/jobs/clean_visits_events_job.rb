class CleanVisitsEventsJob < ApplicationJob
  queue_as :default

  def perform
    # Visit.destroy_all
    # Ahoy::Event.destroy_all
    DatabaseCleaner.clean_with :truncation,{:only => %w[visits ahoy_events], :reset_ids => true}
    # DatabaseCleaner.strategy = :truncation, {:only => %w[visits ahoy_events], :reset_ids => true}
    # DatabaseCleaner.start
    # DatabaseCleaner.clean
  end
end
