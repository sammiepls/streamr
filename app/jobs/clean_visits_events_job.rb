class CleanVisitsEventsJob < ApplicationJob
  queue_as :default

  def perform
    Visit.destroy_all
    Ahoy::Event.destroy_all
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :truncation, {:only => %w[visit ahoy_event]}
  end
end
