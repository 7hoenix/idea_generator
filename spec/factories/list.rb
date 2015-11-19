FactoryGirl.define do
  factory :list do
    list_type ""
    user
    possibility
  end

  factory :black_list, class: List do
    list_type "black"
    user
    possibility
  end

  factory :white_list, class: List do
    list_type "white"
    user
    possibility
  end
end
