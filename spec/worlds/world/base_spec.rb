require 'spec_helper'

include World

describe Base do
  describe "#new" do
    subject { Base.new(options) }

    context "when created without options" do
      let(:options) { {} }
      its(:size)    { should eql(DEFAULT_SIZE) }
      its(:name)    { should eql(DEFAULT_NAME) }
    end

    context "when created with options" do
      let(:options) do
        opts = {name: name, size: size}
        opts[:file] = file if defined? file
        opts
      end
      let(:name)    { 'Utopia' }
      let(:size)    { :small }

      its(:name) { should eql(name) }
    end
  end

  #context "#generate" do
  #  subject { world.generate! }
  #
  #  describe "when not given instructions" do
  #    let(:world)  { Base.new }
  #    it { should be_awesome }
  #  end
  #
  #  # describe "when making a tiny world"
  #end
end