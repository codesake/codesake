require 'spec_helper'

lorem_ipsum = <<EOS
Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim
ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl
ut aliquip ex ea commodo consequat. Duis splople autem vel eum iriure dolor in
hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu
feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui
blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla
facilisi.

Pellentesque at dolor non lectus sagittis semper. Donec quis mi. Duis eget
pede. Phasellus arcu tellus, ultricies id, consequat id, lobortis nec, diam.
Suspendisse sed nunc. Pellentesque id magna. Morbi interdum quam at est.
Maecenas eleifend mi in urna. Praesent et lectus ac nibh luctus viverra. In vel
dolor sed nibh sollicitudin tincidunt. Ut consequat nisi sit amet nibh. Nunc mi
tortor, tristique sit amet, rhoncus porta, malesuada elementum, nisi. Integer
vitae enim quis risus aliquet gravida. Curabitur vel lorem vel erat dapibus
lobortis. Donec dignissim tellus at arcu. Quisque molestie pulvinar sem.

Nulla magna neque, ullamcorper tempus, luctus eget, malesuada ut, velit. Morbi
felis. Praesent in purus at ipsum cursus posuere. Morbi bibendum facilisis
eros. Phasellus aliquam sapien in erat. Praesent venenatis diam dignissim dui.
Praesent risus erat, iaculis ac, dapibus sed, imperdiet ac, erat. Nullam sed
ipsum. Phasellus non dolor. Donec ut elit.
EOS

describe Codesake::Engine::Text do
  before(:all) do
    File.open("lorem.txt", "w") do |f|
      f.write(lorem_ipsum)
    end
    @text = Codesake::Engine::Text.new("lorem.txt")
  end
  after(:all) do
    File.delete("lorem.txt") if File.exists?("lorem.txt")
  end

  it_behaves_like Codesake::Utils::Files
  it_behaves_like Codesake::Utils::Secrets

  it "takes a filename as input" do
    @text.filename.should_not be_nil
    @text.filename.should_not be_empty
  end

  context "has a is_txt? method" do
    it "and this method is public" do
      Codesake::Engine::Text.should respond_to(:is_txt?)
    end
    it "returns false if file extension is not .txt" do
      Codesake::Engine::Text.is_txt?("text.jsp").should   be_false
    end
    it "returns true if file extension is .txt" do
      Codesake::Engine::Text.is_txt?("text.txt").should   be_true
    end
  end

  

  # XXX: The following three matchers must be present to all engines in order to
  # check if the class include the statistics module.
  
end
