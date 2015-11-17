FactoryGirl.define do
  factory :idea do
    user
    possibility_alpha_id possibility.id
    possibility_beta_id possibility.id
  end
end
