require 'spec_helper'

describe Pencil do

	describe "#initialize" do
		context "when a new class is initialized" do
			it "should not be nil" do
				pencil = Pencil.new
				expect(pencil).to be_truthy
			end

			it "should be a pencil object" do
				pencil = Pencil.new
				expect(pencil).to be_instance_of(Pencil)
			end
		end
	end

end
