require 'spec_helper'

describe Pencil do
	before :each do
		@pencil = Pencil.new
	end

	describe "#initialize" do
		context "when a new class is initialized" do
			it "should not be nil" do
				expect(@pencil).to be_truthy
			end

			it "should be a pencil object" do
				expect(@pencil).to be_instance_of(Pencil)
			end
		end
	end

	describe "#write" do
		context "when a pencil is given a string" do
			it "should write the string to a paper" do
				@pencil.write("hello")
				expect(@pencil.instance_variable_get("@paper").text).to eq("hello")
			end
		end

		context "when a pencil is given two strings" do
			it "should write both strings to a paper" do
				@pencil.write("hello ")
				@pencil.write("world")
				expect(@pencil.instance_variable_get("@paper").text).to eq("hello world")
			end
		end
	end
end
