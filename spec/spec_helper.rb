require 'rubygems'
require 'bundler/setup'
require 'yaml'

require 'backlogjp'

RSpec.configure do |config|
  if File.exist?("spec/config/backlogjp.yml")
    @credentials = YAML.load_file 'spec/config/backlogjp.yml'

    Backlogjp.new(@credentials["space"], @credentials["username"], @credentials["password"])
  else
    puts "Please provide credentials for backlogjp in config/backlogjp.yml"
    exit
  end
end

