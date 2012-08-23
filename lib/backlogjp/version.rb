module Backlogjp
  # Represents a backlog.jp Version
  class Version < Container
    # @!attribute [r] id
    #   @return [Integer] Version ID
    # @!attribute [r] name
    #   @return [String] Version name
    # @!attribute [r] start_date
    #   @return [DateTime] Start date
    # @!attribute [r] due_date
    #   @return [DateTime] Due date for the version
    # @!attribute [r] date
    #   @return [DateTime] Due date for the version
    attributes :id, :name, :start_date, :due_date, :date

    def initialize(hash)
      super(hash)
      @start_date = DateTime.parse(@start_date) if @start_date && !@start_date.empty?

      @date       = DateTime.parse(@date)       if @date && !@date.empty?
      @due_date   = DateTime.parse(@due_date)   if @due_date && !@due_date.empty?
      @due_date ||= @date
    end

    class << self
      # Creates a new version on the given project
      # @param [Project|Fixnum] Project or integer project id
      # @param [String] Version name
      # @param [Time|String] optional Start date
      # @param [Time|String] optional Due date
      # @return [Version] The created version or nil if it could not be created
      # @example
      #   project = Backlogjp::Project.all.first
      #   Backlogjp::Version.create(project, "VERSION", Time.now, "20121231")
      def create(project, name, start_date=nil, due_date=nil)
        params = {
          :project_id=>Container.get_id(project),
          :name=>name
        }
        params[:start_date] = Container.date_to_string(start_date) if start_date
        params[:due_date] = Container.date_to_string(due_date) if due_date
        hash = Backlogjp.base._command "addVersion", params

        Version.new(hash) if hash
      end

      # Updates an existing Version
      # @param [String] Version name
      # @param [Time|String] Start date
      # @param [Time|String] Due date
      # @param [Boolean] Whether to show the version on the project page
      # @return [Version] The updated version
      # @example
      #   # assuming version is a valid Version
      #   version.update("VERSION", Time.now, Time.parse('2012-12-01'))
      def update(version, name, start_date=nil, due_date=nil)
        params = {
          :id=>Container.get_id(version),
          :name=>name
        }
        params[:start_date] = Container.date_to_string(start_date) if start_date
        params[:due_date] = Container.date_to_string(due_date) if due_date

        hash = Backlogjp.base._command "updateVersion", params

        Version.new(hash) if hash
      end

      # Deletes an existing Version
      # @param [Version|Integer] Version or id
      # @example
      #   # assuming version is a valid Version
      #   Backlogjp::Version.delete(version)
      def delete(version)
        Backlogjp.base._command "deleteVersion", Container.get_id(version)
      end
    end

    # Updates the Version
    # @param [String] Version name
    # @return [Version] The updated version
    # @example
    #   # assuming version is a valid Version
    #   version.update("TEST-VERSION", Time.now, Time.parse('2012-06-01'))
    def update(name, start_date=nil, due_date=nil)
      Backlogjp::Version.update(self, name, start_date, due_date)

      @name       = name
      @start_date = start_date if start_date
      @due_date   = due_date if due_date

      self
    end

    # Deletes the Version
    # @example
    #   # assuming version is a valid Version
    #   version.delete
    def delete
      Backlogjp::Version.delete(self)
    end
  end
end

