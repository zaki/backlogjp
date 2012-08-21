module Backlogjp
  # Represents a backlog.jp Issue
  # @example
  #   Backlogjp.new("space", "username", "password")
  #   issue = Backlogjp::Issue.find_by_id(123456)
  #   # >> Issue
  #   issue.due_date
  #   # >> 2012-08-31
  #   issue.components
  #   # >> [ Component, Component, ... ]
  #
  # @todo
  #   * countIssue
  #   * findIssue
  #   * createIssue
  #   * updateIssue
  #   * switchStatus
  #   * getComments
  #   * addComment
  class Issue < Container
    # @!attribute [r] id
    #   @return [Fixnum] Issue ID
    # @!attribute [r] key
    #   @return [String] Issue Key
    # @!attribute [r] summary
    #   @return [String] Summary
    # @!attribute [r] description
    #   @return [String] Description
    # @!attribute [r] url
    #   @return [String] Issue URL
    # @!attribute [r] due_date
    #   @return [DateTime] Due date
    # @!attribute [r] start_date
    #   @return [DateTime] Start date
    # @!attribute [r] estimated_hours
    #   @return [Fixnum] Estimated hours spent working on issue
    # @!attribute [r] actual_hours
    #   @return [Fixnum] Actual hours spent working on issue
    # @!attribute [r] issue_type
    #   @return [IssueType] Issue type
    # @!attribute [r] priority
    #   @return [Priority] Issue priority
    # @!attribute [r] resolution
    #   @return [Resolution] Issue resolution
    # @!attribute [r] status
    #   @return [Status] Issue status
    # @!attribute [r] components
    #   @return [Array<Component>] List of components the issue belongs to
    # @!attribute [r] versions
    #   @return [Array<Version>] Versions the issue belongs to
    # @!attribute [r] milestones
    #   @return [Array<Version>] Milestones the issue belongs to
    # @!attribute [r] created_user
    #   @return [User] The user who created the issue
    # @!attribute [r] assigner
    #   @deprecated Use {#assignee} instead
    # @!attribute [r] created_on
    #   @return [DateTime] The time the issue was created at
    # @!attribute [r] updated_on
    #   @return [DateTime] The last time the issue was updated at
    # @!attribute [r] custom_fields
    #   Not implemented yet

    attributes :id, :key, :summary, :description, :url,
               :due_date, :start_date, :estimated_hours, :actual_hours,
               :priority,
               :resolution,
               :status,
               :components,
               :versions,
               :milestones,
               :created_user,
               :assigner,
               :created_on, :updated_on,
               :custom_fields

    def initialize(hash)
      super(hash)

      @due_date     = DateTime.parse(@due_date)   if @due_date
      @start_date   = DateTime.parse(@start_date) if @start_date
      @issue_type   = IssueType.new hash['issueType'] if hash['issueType']

      @components   = (@components || []).map {|component| Component.new component}
      @versions     = (@versions   || []).map {|version|   Version.new version}
      @milestones   = (@milestones || []).map {|milestone| Version.new milestone}
      @assigner     = User.new(@assigner) if @assigner
      @created_user = User.new(@created_user) if @created_user

      @created_on   = DateTime.parse(@created_on) if @created_on
      @updated_on   = DateTime.parse(@updated_on) if @updated_on
    end

    # Assignee is an alias to the incorrectly named `assigner` API attribute
    def assignee
      @assigner
    end

    # Retrieve an issue by id
    # @param [Integer] Issue id
    # @return [Issue] The issue that corresponds to the id or nil if none found
    # @example
    #   Backlogjp::Issue.find_by_id(123456)
    #   # >> Issue
    def self.find_by_id(id)
      hash = Backlogjp.base._command "getIssue", id

      Issue.new(hash) unless hash.empty?
    end

    # Retrieve an issue by its key
    # @param [String] Issue key
    # @return [Issue] The issue that corresponds to the key or nil if none found
    # @example
    #   Backlogjp::Issue.find_by_key("ISSUE-1")
    #   # >> Issue
    def self.find_by_key(key)
      raise ArgumentError.new("Invalid issue key format: #{key}") unless key.is_a?(String) && key.include?("-")
      find_by_id(key) # backlog API method looks the same except for the parameter type
    end
  end
end

