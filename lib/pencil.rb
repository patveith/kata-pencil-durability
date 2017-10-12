##
# A class that represents the Pencil object.
#
# @attr_reader [Integer] point_durability The amount of pencil pointer
#   durability remaining.
# @attr_reader [Integer] length The length of the pencil which determines how
#   many times it can be sharpened.
# @attr_reader [Integer] eraser_durability The amount of eraser durability
#   remaining.
# @attr_reader [Paper] paper The paper object the pencil is writing to.
class Pencil
  attr_accessor :point_durability, :length, :eraser_durability, :paper

  ##
  # Initialize method for the Pencil class.
  #
  # @param [Integer] point_durability The amount of pencil pointer
  #   durability remaining.
  # @param [Integer] length The length of the pencil which determines how
  #   many times it can be sharpened.
  # @param [Integer] eraser_durability The amount of eraser durability
  #   remaining.
  # @param [Paper] paper The paper object the pencil is writing to.
  def initialize(paper = Paper.new, point_durability = 100, length = 10, eraser_durability = 100)
    @paper = paper
    @point_durability = point_durability
    @saved_pointer_durability = point_durability
    @length = length
    @eraser_durability = eraser_durability
  end

  ##
  # Writes a given string to the paper, writes spaces if pencil no
  # longer has any pointer durability.  It loses one durability for
  # lowercase characters, two for uppercase, and none for whitespace.
  #
  # @param [String] to_write A string to write to the paper
  def write(to_write)
    to_write.each_char do |char|
      if @point_durability > 0
        @paper.text.concat(char)
        decrement_point_durability(char)
      else
        @paper.text.concat(' ')
      end
    end
  end

  ##
  # Erases a given string from the paper while eraser durability
  # remains, each non-whitespace character reduces the eraser durability
  # by one.  Strings are erased from the paper right to left and are only
  # removed if they exist on the page.  When the eraser runs out of durability
  # no more characters can be erased.
  #
  # @param [String] to_erase A string to erase from the paper
  def erase(to_erase)
    leftIndex = paper.text.rindex(paper.text.match(to_erase).to_s)
    rightIndex = to_erase.length + leftIndex - 1

    @paper.text[leftIndex..rightIndex].chars.reverse_each.with_index(0) do |char, i|
      if eraser_durability > 0 && char != " "
        @paper.text[rightIndex-i] = " "
        @eraser_durability -= 1
      else
        @paper.text[rightIndex-i] = char
      end
    end
  end

  ##
  # When a string has been erased from a paper new words can be written into
  # the blank space, words of the same length or shorter can be added without
  # problem.  Longer words will not shift existing text and will instead create
  # collisions represented by '@'.
  #
  # @param [String] to_edit A string to edit into a blank space on the paper
  def edit(to_edit)
    spaceStartIndex = paper.text.index(paper.text.match(" {2,}").to_s) + 1
    wordLengthIndex = to_edit.length + spaceStartIndex -1

    @paper.text[spaceStartIndex..wordLengthIndex].each_char.with_index(0) do |char, i|
      if @point_durability > 0
        char_to_write = "@"
        char_to_write = to_edit[i] if char == " "
        @paper.text[spaceStartIndex+i] = char_to_write
        decrement_point_durability(char_to_write)
      end
    end
  end

  ##
  # Restores the original pointer durability of a pencil and reduces the pencil
  # length by one.  A pencil of length zero cannot be sharpened to restore
  # durability.
  def sharpen
    if length > 0
      @point_durability = @saved_pointer_durability
      @length -= 1
    end
  end

  ##
  # Decrements the pencils point_durability by the correct amount based on the
  # character passed in.  Minus two for an uppercase, minus one for a lowercase
  # and does nothing for whitespace.
  #
  # @param [Char] char A character about to be written
  def decrement_point_durability(char)
    if char.match('[A-Z]')
      @point_durability -= 2
    elsif char.match('\S')
      @point_durability -= 1
    end
  end
end
