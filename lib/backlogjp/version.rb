module Backlogjp
  # Represents a backlog.jp Version
  #
  # @todo
  #   * addVersion
  #   * updateVersion
  #   * deleteVersion
  class Version < Container
    # @!attribute [r] id
    #   @return [Integer] Version ID
    # @!attribute [r] name
    #   @return [String] Version name
    # @!attribute [r] date
    #   @return [DateTime] Due date for the version
    attributes :id, :name, :date

    def initialize(hash)
      super(hash)
      @date = DateTime.parse(@date) if @date
    end
  end
end

