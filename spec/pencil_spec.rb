require 'spec_helper'

describe Pencil do
	before :each do
		@pencil = Pencil.new(Paper.new, 200)
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
				pencil = Pencil.new(Paper.new, 5)
				expect(pencil.point_durability).to eq(5)
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

		context "when a pencil writes a space" do
			it "should not lose any durability" do
				@pencil.write(" ")
				expect(@pencil.point_durability).to eq(200)
			end
		end
	end
end
