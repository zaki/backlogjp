module Backlogjp
  # Represents a backlog.jp issue type
  #
  # @todo
  #   * addIssueType
  #   * updateIssueType
  #   * deleteIssueType
  class IssueType < Container
    # @!attribute [r] id
    #   @return [Fixnum] Issue type ID
    # @!attribute [r] name
    #   @return [String] Issue type name
    # @!attribute [r] color
    #   @return [String] Issue type color in HTML rgb format, such as `#ffffff`
    attributes :id, :name, :color
  end
end

