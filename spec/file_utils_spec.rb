require 'spec_helper'

@dummy_text = <<EOT
This is a text 
This is a text 
This is a text 
This is a text 
EOT

class Test
  include Codesake::FileUtils
end

shared_examples_for Codesake::FileUtils do
    before(:all) do
      @mock = Test.new
      File.open("test_utils.txt", "w") do |f|
        f.write(@dummy_text)
      end

    end
    after(:all) do
      File.delete("test_utils.txt")
    end

    ## Reading the file

    it "has a read_file method" do
      @mock.should respond_to(:read_file)
    end

    it "complains if we request to read a non existing file"
    it "read an existing file"


    it "has a loc method" do
      @mock.should respond_to(:loc)
    end
    it "has a lines method" do
      @mock.should respond_to(:lines)
    end

    it "has a lines_of_comment method" do
      @mock.should respond_to(:lines_of_comment)
    end

        

  end

