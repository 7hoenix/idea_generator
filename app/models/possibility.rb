class Possibility < ActiveRecord::Base
  has_many :ideas
  has_many :lists

  has_many :users, through: :ideas
  has_many :users, through: :lists
end
