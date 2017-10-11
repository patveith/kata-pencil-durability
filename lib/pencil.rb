##
# A class that represents the Pencil object
#
class Pencil
  attr_accessor :point_durability, :length

  def initialize(paper = Paper.new, point_durability = 100, length = 10)
    @paper = paper
    @point_durability = point_durability
    @saved_pointer_durability = point_durability
    @length = length
  end

  def write(input)
    input.each_char do |char|
      if @point_durability > 0
        @paper.text.concat(char)
      else
        @paper.text.concat(' ')
      end

      if char.match('[A-Z]')
        @point_durability -= 2
      elsif char.match('\S')
        @point_durability -= 1
      end
    end
  end

  def erase(to_erase)
    paper_arr = @paper.text.rpartition to_erase
    if paper_arr.find_index(to_erase)!=nil
      paper_arr[paper_arr.find_index to_erase] = " " * to_erase.length
    end
    @paper.text = paper_arr.join
  end

  def sharpen
    if length > 1
      @point_durability = @saved_pointer_durability
      @length -= 1
    end
  end
end
