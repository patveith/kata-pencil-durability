require 'spec_helper'

describe Pencil do
	point_durability = 200
	length = 5
	eraser_durability = 100

	before :each do
		@pencil = Pencil.new(Paper.new, point_durability, length, eraser_durability)
	end

	describe "#initialize" do
		context "when a new class is initialized" do
			it "should not be nil" do
				expect(@pencil).to be_truthy
			end

			it "should be a pencil object" do
				expect(@pencil).to be_instance_of(Pencil)
			end

			it "should have a paper object" do
				expect(@pencil.paper).to be_instance_of(Paper)
			end
		end

		context "when a new class is initialized with a paper object" do
			it "should have that paper object" do
				paper = Paper.new
				@pencil = Pencil.new(paper)
				expect(@pencil.paper).to eq(paper)
			end
		end

		context "when a new class is initialized with a pointer durability" do
			it "should have that pointer durability" do
				expect(@pencil.point_durability).to eq(point_durability)
			end
		end

		context "when a new class is initialized with a length" do
			it "should have that length" do
				expect(@pencil.length).to eq(length)
			end
		end

		context "when a new class is initialized with an eraser durability" do
			it "should have that eraser durability" do
				expect(@pencil.eraser_durability).to eq(eraser_durability)
			end
		end
	end

	describe "#edit" do
	  before :each do
	    @pencil.write("An apple a day keeps the doctor away")
	    @pencil.erase("apple")
	  end

	  context "when a word has been erased" do
	    it "should be able to write another shorter string" do
	      @pencil.edit("pear")
	      expect(@pencil.paper.text).to eq("An pear  a day keeps the doctor away")
	    end

	    it "should be able to write another same sized string" do
	      @pencil.edit("olive")
	      expect(@pencil.paper.text).to eq("An olive a day keeps the doctor away")
	    end

	    it "should be able to write another longer string where collisions become '@'" do
	      @pencil.edit("cantaloupe")
	      expect(@pencil.paper.text).to eq("An cantal@u@@y keeps the doctor away")
	    end
	  end

	  context "when two words have been erased" do
	    it "should be able to write a string into the first space" do
	      @pencil.erase("keeps")
	      @pencil.edit("olive")
	      expect(@pencil.paper.text).to eq("An olive a day       the doctor away")
	    end

	    it "should be able to write two strings into both spaces" do
	      @pencil.erase("keeps")
	      @pencil.edit("olive")
	      @pencil.edit("prevents")
	      expect(@pencil.paper.text).to eq("An olive a day preven@@e doctor away")
	    end
	  end
	end

	describe "#erase" do
		wood_chuck = "How much wood would a woodchuck chuck if a woodchuck could chuck wood?"
		chuck = "chuck"
		before :each do
			@pencil.write(wood_chuck)
		end

		context "when a pencil is told to erase a string on the paper" do
			it "should replace the last instance of that string with spaces" do
				@pencil.erase(chuck)
				expect(@pencil.paper.text).to eq("How much wood would a woodchuck chuck if a woodchuck could       wood?")
			end
		end

		context "when a pencil is told to erase a string not on the paper" do
			it "should not erase the string if it isn't on the paper" do
				@pencil.erase("bear")
				expect(@pencil.paper.text).to eq(wood_chuck)
			end
		end

		context "when a pencil is told to erase a string twice" do
			it "should erase the last and second to last instance of that string" do
				@pencil.erase(chuck)
				@pencil.erase(chuck)
				expect(@pencil.paper.text).to eq("How much wood would a woodchuck chuck if a wood      could       wood?")
			end
		end

		context "when a pencil is told to erase a string with five non-whitespace chracters" do
			it "should decrease the eraser durability by five" do
				@pencil.erase(chuck)
				expect(@pencil.eraser_durability).to eq(eraser_durability-5)
			end
		end

		context "when a pencil is told to erase a string with spaces" do
			it "should only lose eraser durability for the non-whitespace characters" do
				@pencil.erase("much wood")
				expect(@pencil.eraser_durability).to eq(eraser_durability-8)
			end
		end

		context "when a pencil's eraser has no durability" do
			it "should not erase any characters" do
				@pencil.eraser_durability = 0
				@pencil.erase(chuck)
				expect(@pencil.paper.text).to eq(wood_chuck)
			end
		end

		context "when a pencil's eraser runs out of durability while erasing" do
			it "should erase characters while it has durability remaining" do
				@pencil.eraser_durability = 3
				@pencil.erase(chuck)
				expect(@pencil.paper.text).to eq("How much wood would a woodchuck chuck if a woodchuck could ch    wood?")
			end
		end
	end

	describe "#sharpen" do
		context "when a pencil with a nonzero length is sharpened after having written" do
			it "should restore it's original durability" do
				@pencil.write("hello world")
				expect(@pencil.point_durability).to eq(point_durability-10)
				@pencil.sharpen
				expect(@pencil.point_durability).to eq(point_durability)
			end

			it "should reduce it's length by one" do
				@pencil.sharpen
				expect(@pencil.length).to eq(length-1)
			end
		end

		context "when a pencil of length one is sharpened" do
			it "should not be able to be sharpened again" do
				@pencil.length = 1
				@pencil.sharpen
				expect(@pencil.length).to eq(0)
				@pencil.sharpen
				expect(@pencil.length).to eq(0)
			end
		end

		context "when a pencil with a length of zero is sharpened after having written" do
			it "should not restore it's original durabiltiy" do
				@pencil.length = 0
				@pencil.write("hello world")
				@pencil.sharpen
				expect(@pencil.point_durability).to eq(point_durability-10)
			end
		end
	end

	describe "#write" do
		context "when a pencil is told to write a string" do
			it "should write the string to a paper" do
				@pencil.write("hello")
				expect(@pencil.paper.text).to eq("hello")
			end
		end

		context "when a pencil is told to write two strings" do
			it "should write both strings to a paper" do
				@pencil.write("hello ")
				@pencil.write("world")
				expect(@pencil.paper.text).to eq("hello world")
			end
		end

		context "when a pencil writes five lowercase characters" do
			it "should lose five points of durability" do
				@pencil.write("hello")
				expect(@pencil.point_durability).to eq(point_durability-5)
			end
		end

		context "when a pencil writes an uppercase character" do
			it "should lose two points of durability" do
				@pencil.write("A")
				expect(@pencil.point_durability).to eq(point_durability-2)
			end
		end

		context "when a pencil writes a space" do
			it "should not lose any durability" do
				@pencil.write(" ")
				expect(@pencil.point_durability).to eq(point_durability)
			end
		end

		context "when a pencil writes a newline" do
			it "should not lose any durability" do
				@pencil.write("\n")
				expect(@pencil.point_durability).to eq(point_durability)
			end
		end

		context "when a pencil writes both an uppercase and lowercase character" do
			it "should lose three points of durability" do
				@pencil.write("Aa")
				expect(@pencil.point_durability).to eq(point_durability-3)
			end
		end

		context "when a pencil writes 'Hello World\\n'" do
			it "should lose twelve points of durability" do
				@pencil.write("Hello World\n")
				expect(@pencil.point_durability).to eq(point_durability-12)
			end

			it "should write a newline and space to the papers text" do
				@pencil.write("Hello World\n")
				expect(@pencil.paper.text).to eq("Hello World\n")
			end
		end

		context "when a pencil has no durability left" do
			it "should only write spaces" do
				@pencil.point_durability = 0
				@pencil.write("hello world")
				expect(@pencil.paper.text).to eq("           ")
			end
		end

		context "when a pencil runs out of durability during writing" do
			it "should write characters while it has durability remaining" do
				@pencil.point_durability = 7
				@pencil.write("hello world")
				expect(@pencil.paper.text).to eq("hello wo   ")
			end
		end

	end
end
