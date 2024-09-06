FactoryBot.define do
    factory :room do
        name { Faker::Lorem.sentence }
        is_private { false }
    end
end