# frozen_string_literal: true
# typed: true

require 'json'

module WorkOS
  # The Connection class provides a lightweight wrapper around
  # a WorkOS Connection resource. This class is not meant to be instantiated
  # in user space, and is instantiated internally but exposed.
  class Connection
    extend T::Sig

    attr_accessor :id, :name, :connection_type, :domains

    sig { params(json: String).void }
    def initialize(json)
      raw = parse_json(json)

      @id = T.let(raw.id, String)
      @name = T.let(raw.name, String)
      @connection_type = T.let(raw.connection_type, String)
      @domains = T.let(raw.domains, Array)
    end

    def to_json(*)
      {
        id: id,
        name: name,
        connection_type: connection_type,
        domains: domains,
      }
    end

    private

    sig { params(json_string: String).returns(WorkOS::Types::ConnectionStruct) }
    def parse_json(json_string)
      hash = JSON.parse(json_string, symbolize_names: true)

      WorkOS::Types::ConnectionStruct.new(
        id: hash[:id],
        name: hash[:name],
        connection_type: hash[:connection_type],
        domains: hash[:domains],
      )
    end
  end
end
