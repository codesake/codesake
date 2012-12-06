require 'spec_helper'


dummy_text = <<EOT
This is a text 
This is a text 
This is a text 
This is a text 
EOT

class Test
  include Codesake::Utils::Secrets
end


shared_examples_for Codesake::Utils::Secrets do
  before(:all) do
    @mock = Test.new
  end

  context "has a list of reserved words containing" do
    it "password" do
      @mock.sensitive_words.include?("password").should be_true
    end
    it "username"
    it "login"
    it "fixme"
    it "xxx"
    it "fix"
  end

  context "has a find_secrets method" do
    it "and this method is public"
    it "returns true if 'Donec' is a reserved word in the example source"
    it "returns true if 'donec' is a reserved word in the example source" 
    it "returns true if 'eRaT' is a reserved word in the example source" 
    it "returns false if 'password' is a reserved word in the example source"
    it "returns false if 'ccv' is a reserved word in the example source"
    it "returns false if 'login' is a reserved word in the example source"
  end

end
