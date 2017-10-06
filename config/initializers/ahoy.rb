class Ahoy::Store < Ahoy::Stores::ActiveRecordTokenStore
  # customize here
  Ahoy.visit_duration = 1.minute
  Ahoy.track_visits_immediately = true
  Ahoy.geocode = false

end
