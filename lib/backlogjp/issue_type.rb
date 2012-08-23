module Backlogjp
  # Represents a backlog.jp issue type
  class IssueType < Container
    COLORS = {
      :red      => "#e30000",
      :dark_red => "#990000",
      :magenta  => "#934981",
      :indigo   => "#814fbc",
      :blue     => "#2779ca",
      :teal     => "#007e9a",
      :green    => "#7ea800",
      :orange   => "#ff9200",
      :crimson  => "#ff3265",
      :black    => "#666665"
    }

    # @!attribute [r] id
    #   @return [Fixnum] Issue type ID
    # @!attribute [r] name
    #   @return [String] Issue type name
    # @!attribute [r] color
    #   @return [String] Issue type color in HTML rgb format, such as `#ffffff`
    attributes :id, :name, :color

    class << self
      # Creates a new issue type on a given project
      # @param [Project|Fixnum] Project or integer project id
      # @param [String] Issue type name
      # @param [String | Symbol] Issue type color
      # @return [IssueType] The created issue type or nil if it could not be created
      # @example
      #   project = Backlogjp::Project.all.first
      #   Backlogjp::IssueType.create(project, "Critical Bug", "#e30000"
      def create(project, name, color)
        hash = Backlogjp.base._command "addIssueType",
                                       :project_id=>Container.get_id(project),
                                       :name=>name,
                                       :color=>backlog_color(color)

        IssueType.new(hash) if hash
      end

      # Updates an existing IssueType
      # @param [String] Issue type name
      # @param [String] Issue type color
      # @return [IssueType] The updated issue type
      # @example
      #   # assuming issue_type is a valid IssueType
      #   Backlogjp::IssueType.update(issue_type, "Critical Bug", "#e30000"
      def update(issue_type, name, color)
        hash = Backlogjp.base._command "updateIssueType",
                                       :id=>Container.get_id(issue_type),
                                       :name=>name,
                                       :color=>backlog_color(color)

        IssueType.new(hash) if hash
      end

      # Deletes an existing IssueType
      # @param [IssueType|Integer] Issue type id
      # @param [IssueType|Integer] optional Substitute issue type
      # @example
      #   # assuming issue_type is a valid IssueType
      #   Backlogjp::IssueType.delete(issue_type)
      #   # assuming issue_type1 and issue_type2 are valid IssueTypes
      #   # delete issue_type1 and use issue_type2 for issues that used to belong to issue_type1
      #   Backlogjp::IssueType.delete(issue_type1, issue_type2)
      def delete(issue_type, substitute_issue_type=nil)
        params = {:id=>Container.get_id(issue_type)}
        params[:substitute_id] = Container.get_id(substitute_id) if substitute_issue_type

        Backlogjp.base._command "deleteIssueType", params
      end

      # Checks whether a color is allowed as a backlog issue type color
      # @param [String|Symbol] Color
      # @return [String] Valid issue type color
      def backlog_color(color)
        backlog_color = case color
                        when Symbol
                          COLORS[color]
                        when String
                          COLORS.values.include?(color) ? color : nil
                        else
                          nil
                        end
        raise ArgumentError.new("Issue type color is not allowed") unless backlog_color

        backlog_color
      end
    end

    # Updates the IssueType
    # @param [String] Issue type name
    # @param [String] Issue type color
    # @return [IssueType] The updated issue type
    # @example
    #   # assuming issue_type is a valid IssueType
    #   issue_type.update("Critical Bug", "#e30000"
    def update(name, color)
      Backlogjp::IssueType.update(self, name, color)

      @name  = name
      @color = color

      self
    end

    # Deletes the IssueType
    # @param [IssueType|Integer] optional Substitute issue type
    # @example
    #   # assuming issue_type is a valid IssueType
    #   issue_type.delete
    #   # assuming issue_type1 and issue_type2 are valid IssueTypes
    #   # deletes issue_type1 and assigns issues that used to belong to issue_type1 to issue_type2
    #   issue_type1.delete(issue_type2)
    def delete(substitute_issue_type = nil)
      Backlogjp::IssueType.delete(self, substitute_issue_type)
    end
  end
end

