Given /^the file "([^"]*)" doesn't exist$/ do |file|
  FileUtiles.rm(file) if File.exists?(file)
end

