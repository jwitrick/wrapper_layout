require 'chefspec'
require 'simplecov'
require 'simplecov-console'
require 'coveralls'
require 'chefspec/berkshelf'

RSpec.configure do |c|
  c.color = true

  c.before(:suite) do
    RUNNER_OPTS = {
      platform: 'redhat', version: '6.6'
    }.freeze
  end
  c.before(:each) do
    allow_any_instance_of(Kernel).to receive(:open)
      .with('http://169.254.169.254/latest/meta-data/mac/', &:gets)
      .and_return('test_value')
    allow_any_instance_of(Kernel).to receive(:open)
      .with('http://169.254.169.254/latest/meta-data/network/interfaces/macs/test_value/vpc-id/', &:gets)
      .and_return('vpc-85a560e0')
    allow_any_instance_of(Kernel).to receive(:open)
      .with('http://169.254.169.254/latest/meta-data/network/interfaces/macs/test_value/subnet-id/', &:gets)
      .and_return('subnet-1c6a4634')
    allow_any_instance_of(Kernel).to receive(:open)
      .with('http://169.254.169.254/latest/meta-data/placement/availability-zone/', &:gets)
      .and_return('us-east-1b')

    # Don't worry about external cookbook dependencies
    allow_any_instance_of(Chef::Cookbook::Metadata).to receive(:depends)

    # Prep lookup() for the stubs below
    allow_any_instance_of(Chef::ResourceCollection).to receive(:lookup)
      .and_call_original

    # Test each recipe in isolation, regardless of includes
    @included_recipes = []
    allow_any_instance_of(Chef::RunContext).to receive(:loaded_recipe?)
      .and_return(false)
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe) do |_, i|
      allow_any_instance_of(Chef::RunContext).to receive(:loaded_recipe?)
        .with(i)
        .and_return(true)
      @included_recipes << i
    end
    allow_any_instance_of(Chef::RunContext).to receive(:loaded_recipes)
      .and_return(@included_recipes)
  end
end

SimpleCov.formatters = [
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Console
]
SimpleCov.minimum_coverage 90

SimpleCov.start do
  add_filter 'libraries/'
end

at_exit { ChefSpec::Coverage.report! }

# vim: ai et ts=2 sts=2 sw=2 ft=ruby
