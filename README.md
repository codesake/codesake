# codesake

codesake is a security source code scanning engine. It's used as core engine in
[codesake.com](http://codesake.cokm) application security portal with a closed
knowledge base inside the web application itself.

codesake gem can be used in a security source code review to scan sources with
regular expressions in order to detect insecure software patterns.

## Installation

Add this line to your application's Gemfile:

    gem 'codesake'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install codesake

## Usage

To run codesake over a single file or a directory you simply specify the target
name as parameter on command line.

If you want to review a ruby source file named file1.rb, your command line will
be:

  $ codesake file1.rb


## Known limitations

Known limitation for version 0.1x are:

* Only JSP, Plain text files are analysed
* If target is a directory or a glob file expression codesake will understand
  it but it doesn't expand the file list
* codesake will use only stdout, stderr for output purposes


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
