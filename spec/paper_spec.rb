require 'spec_helper'

describe Paper do
  describe "#initialize" do
    context "when a new class is initialized" do
      it "should not be nil" do
        paper = Paper.new
        expect(paper).to be_truthy
      end

      it "should be a paper object" do
        paper = Paper.new
				expect(paper).to be_instance_of(Paper)
			end
    end

    context "when a paper is written on by a pencil" do
      it "should contain the written text" do
        pencil = Pencil.new
        pencil.write("hello")
        expect(pencil.instance_variable_get("@paper").text).to eq("hello")
      end
    end
  end
end
