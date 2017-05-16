require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-strings/tasks'
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.ignore_paths = ['spec/**/*.pp', 'pkg/**/*.pp']

namespace :doc do
  desc 'Generate README.md from puppet:strings jsondoc'
  task :readme do
    `puppet strings generate --emit-json-stdout |\
    ruby puppetjson2markdown.rb > README.md`
  end
end

desc 'Generate all docucmentation'
task :doc do
  Rake::Task['strings:generate'].execute
  Rake::Task['doc:readme'].execute
end
