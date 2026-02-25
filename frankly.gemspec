# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "frankly/version"
require "frankly/banner"

Gem::Specification.new do |spec|
  spec.name = "frankly"
  spec.version = Frankly::VERSION
  spec.authors = ["Ken Rettberg"]
  spec.email = ["kenrettberg@gmail.com"]

  spec.summary = "Opinionated Sinatra app skeleton generator"
  spec.description = "Generate a modern Sinatra + ActiveRecord starter app with sensible defaults."
  spec.homepage = "https://github.com/kenrett/frankly"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"
  spec.post_install_message = Frankly::Banner::ASCII_ART

  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.start_with?("spec/") }
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 1.3"

  spec.add_development_dependency "bundler", ">= 2.4"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "pry-byebug", "~> 3.10"
end
