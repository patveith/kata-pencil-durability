##
# A class that represents the Pencil object
#
class Pencil
  attr_accessor :point_durability, :length, :eraser_durability

  def initialize(paper = Paper.new, point_durability = 100, length = 10, eraser_durability = 100)
    @paper = paper
    @point_durability = point_durability
    @saved_pointer_durability = point_durability
    @length = length
    @eraser_durability = eraser_durability
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
    erasedString = ""
    return if paper_arr.find_index(to_erase)==nil
    
    paper_arr[paper_arr.find_index(to_erase)].reverse.each_char do |char|
      if eraser_durability > 0 && char != " "
        erasedString.concat(" ")
        @eraser_durability -= 1
      else
        erasedString.concat(char)
      end
    end

    paper_arr[paper_arr.find_index(to_erase)] = erasedString.reverse
    @paper.text = paper_arr.join
  end

  def sharpen
    if length > 1
      @point_durability = @saved_pointer_durability
      @length -= 1
    end
  end
end
