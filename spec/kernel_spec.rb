require 'spec_helper'

describe Codesake::Kernel do
  before(:all) do
    @kernel = Codesake::Kernel.instance
  end

  it "has a choose_engine method" do
    @kernel.should  respond_to(:choose_engine)
  end

  it "has a detect method" do
    @kernel.should  respond_to(:detect)
  end

  it "detects a text file from its extension" do
    @kernel.detect("Gemfile").should == Codesake::Kernel::TEXT
    @kernel.detect("foo.txt").should == Codesake::Kernel::TEXT
  end

  it "detects a jsp file from its extension" do
    @kernel.detect("test.jsp").should == Codesake::Kernel::JSP
  end

  
  #
  # TODO: I plan to add specialized engines for those languages before
  # reaching 1.0 - 20121211
  #
  it "detects a java file from its extension" 
  it "detects a c file from its extension" 
  it "detects a shell script from its extension" 
  it "detects an html file from its extension" 
  it "detects an haml file from its extension" 
  it "detects a markdown file from its extension" 
  it "detects a ruby file from its extension" 
  it "detects a php file from its extension" 
  it "detects a js file from its extension" 
  it "detects a perl file from its extension" 

  # Engine choosing tests

  it "chooses Codesake::Engine::Text for a text file" do
    @kernel.choose_engine("a_text_file").class.should   == Codesake::Engine::Text
  end

  it "chooses Codesake::Engine::Java for a java file"
  it "chooses Codesake::Engine::Text for a c file"
  it "chooses Codesake::Engine::Text for a shell script"
  it "chooses Codesake::Engine::Text for a html file"
  it "chooses Codesake::Engine::Text for a haml file"
  it "chooses Codesake::Engine::Text for a markdown file"
  it "chooses Codesake::Engine::Text for a ruby file"
  it "chooses Codesake::Engine::Text for a php file"
  it "chooses Codesake::Engine::Text for a js file"
  it "chooses Codesake::Engine::Text for a perl file"

end
