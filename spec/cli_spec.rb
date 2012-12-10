require 'spec_helper'

describe "codesake command line interface" do
  before(:all) do
    @cli = Codesake::Cli.new
  end
  it "has a parse method" do
    @cli.should respond_to(:parse)
  end

  it "returns an empty has if no command line is given" do
    @cli.parse(nil).should    be_empty
    @cli.parse("").should     be_empty
    @cli.parse(" ").should    be_empty
    @cli.parse("  ").should   be_empty
  end

  it "understands --help flag" do
    @cli.parse("-h").should ==  {:help=>true, :target=>[]}
    @cli.parse("--help").should ==  {:help=>true, :target=>[]}
  end 
  it "undestands malformed flag" do 
    @cli.parse("-help").should == {:error=>true, :message=>"invalid option: -elp"}
  end

  it "understands --version flag" do
    @cli.parse("--version").should == {:version=>true, :target=>[]}
  end
  it "understands --output flag" do
    @cli.parse("-o file").should  ==  {:output=>:file, :target=>[]}
    @cli.parse("-o json").should  ==  {:output=>:json, :target=>[]}
    @cli.parse("-o db").should    ==  {:output=>:db, :target=>[]}

  end
  it "understands --verbose flag" do
    @cli.parse("--verbose").should  == {:verbose=>true, :target=>[]}
    @cli.parse("-V").should         == {:verbose=>true, :target=>[]}
  end

  it "saves targets" do
    @cli.parse("file1").should        == {:target=>[{:target=>"file1", :valid=>false}]}
    @cli.parse("file1 file2").should  == {:target=>[{:target=>"file1", :valid=>false}, {:target=>"file2", :valid=>false}]}
    @cli.parse("Gemfile").should      == {:target=>[{:target=>"Gemfile", :valid=>true}]}
  end

  it "the target should be either a file or a directory" do
    @cli.is_good_target?("Gemfile").should  be_true
    @cli.is_good_target?("file1").should    be_false
  end
  it "must produce a non nil option Hash" do
    @cli.parse("").should_not           be_nil
    @cli.parse("-nonsense").should_not  be_nil
    @cli.parse("-v -h").should_not      be_nil
    @cli.parse("-j drift").should_not   be_nil
  end


end
