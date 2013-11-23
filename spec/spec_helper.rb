ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rspec/autorun'
require 'rack/test'
require '../analyze.rb'
require '../clean.rb'
