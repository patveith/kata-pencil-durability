require 'spec_helper'

describe Pencil do
	before :each do
		@pencil = Pencil.new(Paper.new, 200, 5)
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
				expect(@pencil.instance_variable_get("@paper")).to be_instance_of(Paper)
			end
		end

		context "when a new class is initialized with a paper object" do
			it "should have that paper object" do
				paper = Paper.new
				@pencil = Pencil.new(paper)
				expect(@pencil.instance_variable_get("@paper")).to eq(paper)
			end
		end

		context "when a new class is initialized with a durability" do
			it "should have that durability" do
				@pencil = Pencil.new(Paper.new, 5)
				expect(@pencil.point_durability).to eq(5)
			end
		end

		context "when a new class is initialized with a length" do
			it "should have that length" do
				@pencil = Pencil.new(Paper.new, 5, 10)
				expect(@pencil.length).to eq(10)
			end
		end
	end

	describe "#erase" do
		wood_chuck = "How much wood would a woodchuck chuck if a woodchuck could chuck wood?"
		chuck = "chuck"

		context "when a pencil is told to erase a string on the paper" do
			it "should replace the last instance of that string with spaces" do
				@pencil.write(wood_chuck)
				@pencil.erase(chuck)
				expect(@pencil.instance_variable_get("@paper").text).to eq("How much wood would a woodchuck chuck if a woodchuck could       wood?")
			end
		end

		context "when a pencil is told to erase a string not on the paper" do
			it "should not erase the string if it isn't on the paper" do
				@pencil.write(wood_chuck)
				@pencil.erase("bear")
				expect(@pencil.instance_variable_get("@paper").text).to eq(wood_chuck)
			end
		end

		context "when a pencil is told to erase a string twice" do
			it "should repace the last and second to last instace of that string with spaces" do
				@pencil.write(wood_chuck)
				@pencil.erase(chuck)
				@pencil.erase(chuck)
				expect(@pencil.instance_variable_get("@paper").text).to eq("How much wood would a woodchuck chuck if a wood      could       wood?")
			end
		end
	end

	describe "#sharpen" do
		context "when a pencil with a nonzero length is sharpened" do
			it "should restore it's original durability" do
				@pencil.write("hello world")
				expect(@pencil.point_durability).to eq(190)
				@pencil.sharpen
				expect(@pencil.point_durability).to eq(200)
			end

			it "should reduce it's length by one" do
				@pencil.sharpen
				expect(@pencil.length).to eq(4)
			end
		end

		context "when a pencil with a length of zero is sharpened" do
			it "should not restore it's original durabiltiy" do
				@pencil.length = 0
				@pencil.write("hello world")
				@pencil.sharpen
				expect(@pencil.point_durability).to eq(190)
				expect(@pencil.length).to eq(0)
			end
		end
	end

	describe "#write" do
		context "when a pencil is told to write a string" do
			it "should write the string to a paper" do
				@pencil.write("hello")
				expect(@pencil.instance_variable_get("@paper").text).to eq("hello")
			end
		end

		context "when a pencil is told to write two strings" do
			it "should write both strings to a paper" do
				@pencil.write("hello ")
				@pencil.write("world")
				expect(@pencil.instance_variable_get("@paper").text).to eq("hello world")
			end
		end

		context "when a pencil writes five lowercase characters" do
			it "should lose five points of durability" do
				@pencil.write("hello")
				expect(@pencil.point_durability).to eq(195)
			end
		end

		context "when a pencil writes an uppercase character" do
			it "should lose two points of durability" do
				@pencil.write("A")
				expect(@pencil.point_durability).to eq(198)
			end
		end

		context "when a pencil writes a space" do
			it "should not lose any durability" do
				@pencil.write(" ")
				expect(@pencil.point_durability).to eq(200)
			end
		end

		context "when a pencil writes a newline" do
			it "should not lose any durability" do
				@pencil.write("\n")
				expect(@pencil.point_durability).to eq(200)
			end
		end

		context "when a pencil writes both an uppercase and lowercase character" do
			it "should lose three points of durability" do
				@pencil.write("Aa")
				expect(@pencil.point_durability).to eq(197)
			end
		end

		context "when a pencil writes 'Hello World\\n'" do
			it "should lose twelve points of durability" do
				@pencil.write("Hello World\n")
				expect(@pencil.point_durability).to eq(188)
			end

			it "should write a newline and space to the papers text" do
				@pencil.write("Hello World\n")
				expect(@pencil.instance_variable_get("@paper").text).to eq("Hello World\n")
			end
		end

		context "when a pencil has no durability left" do
			it "should only write spaces" do
				@pencil = Pencil.new(Paper.new, 0)
				@pencil.write("hello world")
				expect(@pencil.instance_variable_get("@paper").text).to eq("           ")
			end
		end

		context "when a pencil runs out of durability during writing" do
			it "should write characters while it has durability remaining" do
				@pencil = Pencil.new(Paper.new, 7)
				@pencil.write("hello world")
				expect(@pencil.instance_variable_get("@paper").text).to eq("hello wo   ")
			end
		end

	end
end
