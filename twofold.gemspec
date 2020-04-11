require_relative 'lib/twofold/version'

Gem::Specification.new do |spec|
  spec.name          = "twofold"
  spec.version       = Twofold::VERSION
  spec.authors       = ["Andreas Reischuck"]
  spec.email         = ["andreas.reischuck@hicknhack-software.com"]

  spec.summary       = %q{Twofold template engine to generate any indented source code.}
  #spec.description   = %q{Work in progress}
  spec.homepage      = "https://github.com/hicknhack-software/twofold-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hicknhack-software/twofold-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/hicknhack-software/twofold-ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency('temple')
  spec.add_runtime_dependency('tilt')
end
