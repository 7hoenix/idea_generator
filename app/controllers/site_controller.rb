class SiteController < ApplicationController
  def landing
  end

  def dashboard
  end

  def create
    binding.pry
  end

  def profile
    @ideas = [["water chestnuts"], ["Christmas present"], ["inner city water"]]
  end
end
