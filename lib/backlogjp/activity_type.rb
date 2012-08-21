module Backlogjp
  # Represents a backlog.jp activity type
  class ActivityType < Container
    # @!attribute [r] id
    #   @return [Integer] Activity type ID
    # @!attribute [r] name
    #   @return [String] Activity type name
    attributes :id, :name

    # Returns an array of all activity types
    # @return [Array<ActivityType>] The list of activity types defined in the space
    # @example
    #   activity_types = Backlogjp::ActivityType.all
    #   # >> [ ActivityType, ActivityType, ... ]
    def self.all
      activity_types = Backlogjp.base._command("getActivityTypes") || []
      activity_types.map {|hash| ActivityType.new(hash)}
    end
  end
end

