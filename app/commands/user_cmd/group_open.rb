require 'ext/hash'
require 'user_balance'

module UserCmd
  class GroupOpen < ApplicationCommand

    attr_reader :args

    def initialize(xargs)
      @args = xargs.stringify_keys
      args["uuid"] = args["uuid"] || SecureRandom.uuid
      add_event :group, Event::UserGroupOpened.new(group_opts(args))
    end

    private

    def group_opts(args)
      cmd_opts(args).merge(args)
    end
  end
end
