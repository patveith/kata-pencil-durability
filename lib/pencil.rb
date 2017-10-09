##
# A class that represents the Pencil object
#
class Pencil

  def initialize(paper = Paper.new)
    @paper = paper
  end

  def write(input)
    @paper.text.concat(input)
  end
end
