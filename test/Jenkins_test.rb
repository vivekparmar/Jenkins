require_relative "test_helper.rb"
require "test/unit"
require_relative "../src/Jenkins.rb"

class TestRubySDKJenkinsApp < Test::Unit::TestCase

    def test_jenkinsapp
        Jenkins.new(ARGV)
    end

end
