FactoryGirl.define do
  factory :list do
    type ""
    user
    possibility
  end

  factory :black_list, class: List do
    type "black"
    user
    possibility
  end

  factory :white_list, class: List do
    type "white"
    user
    possibility
  end
end
