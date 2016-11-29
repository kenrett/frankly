lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'frankly/version'

Gem::Specification.new do |spec|
  spec.name             = "frankly"
  spec.version          = Frankly::VERSION
  spec.authors          = ["Ken Rettberg"]
  spec.email            = %q{kenrettberg@gmail.com}
  spec.description      = %q{Setup a sinatra skeleton like a boss!}
  spec.summary          = %q{An opinionated sinatra skeleton with Rake tasks, rspec, postgres, and more!}
  spec.files            = `git ls-files`.split($/)
  spec.homepage         = %q{https://github.com/kenrett/frankly}
  spec.rubygems_version = %q{1.6.2}
  spec.license          = "MIT"
  spec.executables      = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths    = ["lib"]

  spec.post_install_message = <<-PIC

              .
  .---------.'---.
  '.       :    .'
    '.  .:::  .' The Chairman
      '.'::'.'    of the Board
        '||'       has arrived.
         ||
         ||
         ||
     ---====---
       PIC

   spec.add_development_dependency "bundler", "~> 1.3"
   spec.add_development_dependency "rake", "~> 10.0"

   spec.add_runtime_dependency 'thor', '~> 0.19.1'
end
