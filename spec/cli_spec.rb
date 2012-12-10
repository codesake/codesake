require 'spec_helper'

describe "codesake command line interface" do
  before(:all) do
    @cli = Codesake::Cli.new
  end
  it "has a parse method" 
  # do
  #   @cli.should respond_to(:scan)
  # end

  it "understands --help flag" 
  it "understands --version flag"
  it "understands --output flag"
  it "understands --verbose flag"

  it "must have at least an argument"
  it "the argument should be either a file or a directory"
  it "must produce a non nil option Hash"


end
