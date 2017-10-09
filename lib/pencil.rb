##
# A class that represents the Pencil object
#
class Pencil
  attr_accessor :point_durability

  def initialize(paper = Paper.new, point_durability = 100)
    @paper = paper
    @point_durability = point_durability
  end

  def write(input)
    @paper.text.concat(input)
  end
end
