FactoryBot.define do
    factory :reservation do
      association :room
      association :user
      start_time { 1.hour.from_now }
      end_time { 2.hours.from_now }
    end
end
