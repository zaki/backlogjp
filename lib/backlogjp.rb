# encoding: utf-8

require 'uri'
require 'xmlrpc/client'

require 'backlogjp/_version'

require 'backlogjp/base'
require 'backlogjp/user'
require 'backlogjp/version'
require 'backlogjp/component'
require 'backlogjp/issue_type'
require 'backlogjp/activity_type'
require 'backlogjp/status'
require 'backlogjp/resolution'
require 'backlogjp/priority'
require 'backlogjp/issue'
require 'backlogjp/project'

# API Wrapper for http://www.backlog.jp
# Usage:
# # First, log in to backlogjp
# Backlogjp.new("space-name", "username", "password")
#
# # Retrieve all projects
# Backlogjp::Project.all
# # >> [ Project, Project ]
#
module Backlogjp
  class << self
    attr_reader :base

    # Creates a client for the backlog.jp XML-RPC API
    # @param [String] The name of the space (http://space.backlog.jp)
    # @param [String] Login username
    # @param [String] Login password
    def new(space, username, password)
      @base = Backlogjp::Base.new(space, username, password)
    end
  end
end

