class Possibility < ActiveRecord::Base
  has_many :ideas
  has_many :lists

  has_many :users, through: :ideas
  has_many :users, through: :lists

  def self.for_an_idea(idea_id)
    idea = Idea.find(idea_id)
    idea.possibilities
  end
end
