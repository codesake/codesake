Given /^the file "([^"]*)" doesn't exist$/ do |file|
  FileUtils.rm(file) if File.exists?(file)
end

Given /^the text file "([^"]*)" does exist$/ do |file|
  FileUtils.rm(file) if File.exists?(file)
lorem_ipsum = <<EOS
Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim
ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl
ut aliquip ex ea commodo consequat. Duis splople autem vel eum iriure dolor in
hendrerit in vulputate velit esse password molestie consequat, vel illum dolore eu
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
lobortis. Donec secret dignissim tellus at arcu. Quisque molestie pulvinar sem.

Nulla magna neque, ullamcorper tempus, luctus eget, malesuada ut, velit. Morbi
felis. Praesent in purus at ipsum cursus posuere. Morbi bibendum facilisis
eros. Phasellus aliquam password sapien in erat. Praesent venenatis diam dignissim dui.
Praesent risus erat, iaculis ac, dapibus sed, imperdiet ac, erat. Nullam sed
ipsum. Phasellus non dolor. Donec ut elit.
EOS

  File.open(file, "w") do |f|
    f.write(lorem_ipsum)
  end
end
