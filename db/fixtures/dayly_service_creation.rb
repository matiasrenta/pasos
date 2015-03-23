DaylyServiceCreation.seed_once(:id) do |d|
  d.id = 1
  d.last_creation = Date.yesterday
  d.until_date = Date.today
end