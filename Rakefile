#!/usr/bin/env rake

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)

require 'thor'
require 'bundler/setup'
require 'rspec/core/rake_task'

load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec)

task :default => :spec
