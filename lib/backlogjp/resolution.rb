module Backlogjp
  # Represents a backlog.jp resolution
  class Resolution < Container
    # @!attribute [r] id
    #   @return [Integer] Resolution ID
    # @!attribute [r] name
    #   @return [String] Resolution name
    attributes :id, :name

    # Returns an array of all resolutions
    # @return [Array<Resolution>] The list of resolutions defined in the space
    # @example
    #   resolutions = Backlogjp::Resolution.all
    #   # >> [ Resolution, Resolution, ... ]
    def self.all
      resolutions = Backlogjp.base._command("getResolutions") || []
      resolutions.map {|hash| Resolution.new(hash)}
    end
  end
end

