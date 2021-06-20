# frozen_string_literal: true

require_relative 'lib/activerecord/bitemporal/tablize/version'

Gem::Specification.new do |spec|
  spec.name          = 'activerecord-bitemporal-tablize'
  spec.version       = Activerecord::Bitemporal::Tablize::VERSION
  spec.authors       = ['lighty']
  spec.email         = ['hikalin8686@gmail.com']

  spec.summary       = 'Displaying the history of records managed by ActiveRecord::Bitemporal in a tabular format.'
  spec.description   = 'Displaying the history of records managed by ActiveRecord::Bitemporal in a tabular format.'
  spec.homepage      = 'https://github.com/lighty/activerecord-bitemporal-tablize'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['allowed_push_host'] = "https://github.com/lighty/activerecord-bitemporal-tablize"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = "https://github.com/lighty/activerecord-bitemporal-tablize"
  spec.metadata['changelog_uri'] = "https://github.com/lighty/activerecord-bitemporal-tablize"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
