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
    input.each_char do |char|
      @paper.text.concat(char)
      if char.match('[A-Z]')
        @point_durability -=2
      elsif char.match('\S')
        @point_durability -=1
      end
    end
  end
end
