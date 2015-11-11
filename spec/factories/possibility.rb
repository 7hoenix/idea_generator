FactoryGirl.define do
  factory :possibility do
    title { Faker::Company.buzzword }
    source { Faker::Internet.url }
  end
end
