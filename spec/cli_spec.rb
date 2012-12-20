require 'spec_helper'

describe "codesake command line interface" do
  before(:all) do
    @cli = Codesake::Cli.new
  end
  it "has a parse method" do
    @cli.should respond_to(:parse)
  end

  it "returns an empty has if no command line is given" do
    @cli.parse(nil).should    == {:vulnerabilities=>:all}
    @cli.parse("").should     == {:vulnerabilities=>:all}
  end

  
  it "understands --version flag" do
    @cli.parse("--version").should == {:version=>true, :vulnerabilities=>:all}
  end
  it "understands --output flag" do
    @cli.parse("-o file").should  ==  {:output=>:file, :vulnerabilities=>:all}
    @cli.parse("-o json").should  ==  {:output=>:json, :vulnerabilities=>:all}
    @cli.parse("-o db").should    ==  {:output=>:db, :vulnerabilities=>:all}

  end
  it "understands --verbose flag" do
    @cli.parse("--verbose").should  == {:verbose=>true, :vulnerabilities=>:all}
    @cli.parse("-V").should         == {:verbose=>true, :vulnerabilities=>:all}
  end

  it "saves targets" do
    @cli.parse("file1")
    @cli.targets.should        == [{:target=>"file1", :valid=>false}]
    @cli.parse("file1 file2")
    @cli.targets.should  == [{:target=>"file1", :valid=>false}, {:target=>"file2", :valid=>false}]
    @cli.parse("Gemfile")
    @cli.targets.should      == [{:target=>"Gemfile", :valid=>true}]
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

  it "understand --keys flag" do
    ret = {:keywords => ["a","b","c"], :vulnerabilities=>:all}
    @cli.parse("-k a,b,c").should == ret
  end

  it "understand --all-vulnerabilities" do
    ret = {:vulnerabilities=>:all}
    @cli.parse("-A").should == ret
  end
  it "understand --confirmed-vulnerabilities" do
    ret = {:vulnerabilities=>:confirmed}
    @cli.parse("-C").should == ret
  end

end
