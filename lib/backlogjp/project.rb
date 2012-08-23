# encoding: utf-8

module Backlogjp
  # Represents a backlog.jp project
  # @example
  #   Backlogjp.new("space", "username", "password")
  #   projects = Backlogjp::Project.all
  #   # >> [ Project, Project, ... ]
  #   projects.first.versions
  #   # >> [ Version, Version, ... ]
  #   Backlogjp::Project.find_by_key("TEST-PROJECT").users
  #   # >> [ User, User, ... ]
  #
  # @todo
  #   * getProjectSummary
  #   * getProjectSummaries
  class Project < Container
    # @!attribute [r] id
    #   @return [Fixnum] Project ID
    # @!attribute [r] key
    #   @return [String] Project key
    # @!attribute [r] name
    #   @return [String] Project name
    # @!attribute [r] url
    #   @return [String] Project URL
    # @!attribute [r] archived
    #   @deprecated Use {#archived?} instead for better ruby compatibility
    attributes :id, :key, :name, :url, :archived

    class << self
      # Retreives all projects
      # @return [Array<Project>] All projects in the space
      # @example
      #   Backlog::Project.all
      #   # >> [ Project, Project, ... ]
      #
      # @see http://www.backlog.jp/api/method1_1.html
      def all
        projects = Backlogjp.base._command("getProjects") || []
        projects.map {|hash| Project.new(hash)}
      end

      # Find project by id
      # @param [Integer] Project id
      # @return [Project] The project that corresponds to the id
      #   or `nil` if no project exists with the given id
      # @example
      #   Backlogjp::Project.find_by_id(123456)
      #
      # @see http://www.backlog.jp/api/method1_3.html
      def find_by_id(id)
        hash = Backlogjp.base._command "getProject", id

        Project.new(hash) unless hash.empty?
      end

      # Find project by key
      # @param [String] Project key
      # @return [Project] The project that corresponds to the key
      #   or `nil` if no project exists with the given key
      # @example
      #   Backlogjp::Project.find_by_key("TEST")
      #
      # @see http://www.backlog.jp/api/method1_2.html
      def find_by_key(key)
        find_by_id(key) # backlog method looks exactly the same except for the parameter type
      end
    end

    # @!attribute [r] archived?
    # @return [Boolean] Whether the project has been archived
    def archived?
      @archived
    end

    # Returns an array components set in the project
    # @return [Array<Component>] The components set in the project
    # @example
    #   project = Backlogjp::Project.find_by_id(123456)
    #   project.components
    #   # >> [ Component, Component, ... ]
    #
    # @see http://www.backlog.jp/api/method1_4.html
    def components
      components = Backlogjp.base._command "getComponents", self.id
      components.map {|hash| Component.new(hash)}
    end

    # Creates a new component for the project
    # @param [String] Component name
    # @return [Component] The created component or nil if it could not be created
    # @example
    #   # assuming `project` is a valid backlog.jp Project
    #   project.create_component("TEST-COMPONENT")
    #   # >> Component
    def create_component(name)
      Backlogjp::Component.create(self, name)
    end

    # Returns an array of versions set in the project
    # @return [Array<Version>] The versions set in the project
    # @example
    #   project = Backlogjp::Project.find_by_id(123456)
    #   project.versions
    #   # >> [ Version, Version, ... ]
    #
    # @see http://www.backlog.jp/api/method2_1.html
    def versions
      versions = Backlogjp.base._command "getVersions", self.id
      versions.map {|hash| Version.new(hash)}
    end

    # Creates a new version for the project
    # @param [String] Version name
    # @param [Time|String] optional Start date
    # @param [Time|String] optional Due date
    # @return [Version] The created version or nil if it could not be created
    # @example
    #   # assuming `project` is a valid backlog.jp Project
    #   project.create_version("VERSION-1", Time.parse('2012-01-01'), '20121231')
    #   # >> Version
    def create_version(name, start_date=nil, due_date=nil)
      Backlogjp::Version.create(self, name, start_date, due_date)
    end

    # Returns an array of users assigned to the project
    # @return [Array<User>] The users assigned to the project
    # @example
    #   project = Backlogjp::Project.find_by_id(123456)
    #   project.users
    #   # >> [ User, User, ... ]
    #
    # @see http://www.backlog.jp/api/method2_2.html
    def users
      users = Backlogjp.base._command "getUsers", self.id
      users.map {|hash| User.new(hash)}
    end

    # Returns an array of issue type defined for the project
    # @return [Array<IssueType>] The issue types defined for the project
    # @example
    #   project = Backlogjp::Project.find_by_id(123456)
    #   project.issue_types
    #   # >> [ IssueType, IssueType, ... ]
    #
    # @see http://www.backlog.jp/api/method2_3.html
    def issue_types
      issue_types = Backlogjp.base._command "getIssueTypes", self.id
      issue_types.map {|hash| IssueType.new(hash)}
    end

    # Creates a new issue type for the project
    # @param [String] Issue type name
    # @param [String] Issue type color
    # @return [IssueType] The created issue type or nil if it could not be created
    # @example
    #   # assuming `project` is a valid backlog.jp Project
    #   project.create_issue_type("Critical Bug", "#e30000")
    #   # >> IssueType
    def create_issue_type(name, color)
      Backlogjp::IssueType.create(self, name, color)
    end
  end
end

