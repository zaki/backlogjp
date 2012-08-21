module Backlogjp
  # Represents a backlog.jp priority
  class Priority < Container
    # @!attribute [r] id
    #   @return [Fixnum] Priority ID
    # @!attribute [r] name
    #   @return [String] Priority name
    attributes :id, :name

    # Returns an array of all priorities
    # @return [Array<Priority>] The list of defined priorities
    # @example
    #   Backlogjp::Priority.all
    #   # >> [ Priority, Priority, ... ]
    def self.all
      priorities = Backlogjp.base._command("getPriorities") || []
      priorities.map {|hash| Priority.new(hash)}
    end
  end
end

