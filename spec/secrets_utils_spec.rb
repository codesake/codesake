require 'spec_helper'


dummy_text = <<EOT
This is a text 
This is a text 
This is a text 
This is a text 
secret
This is a text 
This is a text 
This is a text 
EOT

class Test
  include Codesake::Utils::Files
  include Codesake::Utils::Secrets
end


shared_examples_for Codesake::Utils::Secrets do
  before(:all) do
    @mock = Test.new
    File.open("test_secrets.txt", "w") do |f|
        f.puts(dummy_text)
      end

    @mock.filename="test_secrets.txt"
    @mock.read_file
  end
  after(:all) do
    File.delete("test_secrets.txt")
  end

  context "has a list of reserved words containing" do
    it "password" do
      @mock.reserved?("password").should be_true
    end
    it "username" do
      @mock.reserved?("username").should be_true
    end
    it "login" do
      @mock.reserved?("login").should be_true
    end
    it "fixme" do
      @mock.reserved?("fixme").should be_true
    end
    it "xxx" do
      @mock.reserved?("xxx").should be_true
    end
    it "fix" do
      @mock.reserved?("fix").should be_true
    end
  end

  it "let user add a reserver word" do
    @mock.reserved?("foo").should be_false
    @mock.add("foo")
    @mock.reserved?("foo").should be_true

  end
  context "has a find method" do
    it "that is public" do
      @mock.should  respond_to(:find_reserved_keywords)
    end
    it "returns an empty array if 'secret' is not a reserved word in the example source" do
      @mock.secrets=["noodle", "compain", "foo"]
      @mock.find_reserved_keywords.should be_empty
    end
    it "returns true if 'secret' is a reserved word in the example source" do
      @mock.secrets=["secret"]
      @mock.find_reserved_keywords.should == [{:line=>5, :matcher=>"secret"}]
    end


  end

  
end
