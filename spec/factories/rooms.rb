FactoryBot.define do
    factory :room do
      name { "Room #{SecureRandom.hex(2)}" }
      capacity { 5 }
    end
end
