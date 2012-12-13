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
  include Codesake::Engine::Core
end

shared_examples_for Codesake::Engine::Core do
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

  it "provide an analyse method" do
    @mock.should    respond_to(:analyse)
  end

  context "has an analyse method returning an empty array if the input is" do
    it "null" do
      @mock.analyse.class.should  == Array
      @mock.analyse.should  be_empty
    end
  end
end
