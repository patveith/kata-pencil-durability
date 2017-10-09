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
			it "should write the string" do
				expect {@pencil.write("hello")}.to output("hello").to_stdout
			end
		end
	end

end
