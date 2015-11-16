class ServicesFinder
  attr_reader :idea_type

  def initialize(idea_type)
    @idea_type = idea_type
  end

  def services
    [Services::BusinessUSAService.new, Services::ProductHuntService.new]
  end
end
