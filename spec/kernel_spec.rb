require 'spec_helper'

describe Codesake::Kernel do
  before(:all) do
    @engine = Codesake::Kernel.instance
  end

  it "has a choose_engine method" do
    @engine.should  respond_to(:choose_engine)
  end

  it "has a detect method" do
    @engine.should  respond_to(:detect)
  end

  it "detects a text file from its extension" do
    @engine.detect("Gemfile").should == Codesake::Kernel::TEXT
    @engine.detect("foo.txt").should == Codesake::Kernel::TEXT
  end

  it "detects a jsp file from its extension" do
    @engine.detect("test.jsp").should == Codesake::Kernel::JSP
  end

end
