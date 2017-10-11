##
# A class that represents the Paper object
#
# @attr_reader [String] text The text written to the paper.
class Paper
  attr_accessor :text

  ##
  # Initialize method for the Paper class.
  def initialize
    @text = ""
  end
end
