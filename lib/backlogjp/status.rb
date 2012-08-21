module Backlogjp
  # Represents a backlog.jp issue status
  class Status < Container
    # @!attribute [r] id
    #   @return [Integer] Status ID
    # @!attribute [r] name
    #   @return [String] Status name
    attributes :id, :name

    # Returns an array of all defined statuses
    # @return [Array<Status>] The list of all statuses defined in the space
    # @example
    #   Backlogjp::Status.all
    #   # >> [ Status, Status, ... ]
    def self.all
      statuses = Backlogjp.base._command("getStatuses") || []
      statuses.map {|hash| Status.new(hash)}
    end
  end
end

