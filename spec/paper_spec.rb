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
        paper = Paper.new
        pencil = Pencil.new(paper)
        pencil.write("hello")
        expect(paper.text).to eq("hello")
      end
    end
  end
end
