# encoding: UTF-8

require 'rake/testtask'
Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc 'Run tests'
task :default => :test

require 'bundler/gem_tasks'
require 'yaml'
require 'unicode_utils'
require 'colorize'
require 'male_or_female/version'

COMPILED_DIR = './lib/male_or_female/data_compiled'
