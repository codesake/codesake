
0.15.0 / 2012-12-20 
==================

  * Improved -h output
  * Jsp engine is now able to detect cookies in Jsp files...
  * Adding -A, -C flag and the reflected xss scanning support
  * Jsp files are scanned for secrets, import packages and attack entrypoints
  * Added coverage e tmp
  * Added cucumber for Jsp Engine
  * First Codesake::Engine::Jsp scanning for imported packages
  * Text processing output is green
  * Working on analyse
  * Added a Codesake::Engine::Core for all engine facilities
  * Typo in test text
  * Scenario from text file processing
  * Improving scenario for text processing output
  * Codesake::Engine::Text.is_txt? is now a class method
  * Added a Codesake::Engine::Generic scanning engine Added some routine in Codesake::Kernel to detect a text file and choose the correct engine Add integration test for text file processing
  * Adding Codesake::Kernel
  * First cucumber scenario green. codesake now it's tested for missing target
  * Adding cucumber and aruba
  * Add a loop in the binary script...
  * Changed Codesake::Cli for target building... now in a separate Hash
  * v0.10
  * All CLI checks are green now
  * CLI parser improvements
  * Changed scan to parse method name
  * Fixed typo in test
  * Now there is a Codesake::Utils::Secrets
  * Working on secrests
  * Text generic engine includes Secrets module
  * refactoring and TDD utils, secrets and text generic engine
  * Working defining TDD tests
