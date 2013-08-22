module Desk
  class Client
    # Defines methods related to macros
    module Macro
      # Returns extended information of macros
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Desk.macros
      #     Desk.macros(:count => 5)
      #     Desk.macros(:count => 5, :page => 3)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros
      def macros(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get("macros",options)
      end

      # Returns extended information on a single macro
      #
      #   @param id [Integer] a macro ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Desk.macro(12345)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/show
      def macro(id)
        response = get("macros/#{id}")
        response.macro
      end

      # Creates a new macro
      #
      #   @param name [String] A macro name
      #   @option options [Hash]
      #   @example Creates a new macro
      #     Desk.create_macro("name")
      #     Desk.create_macro("name")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/create
      def create_macro(name, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = post("macros",options)
        if response['success']
          return response['results']['macro']
        else
          return response
        end
      end

      # Updates a single macro
      #
      #   @param id [Integer] a macro ID
      #   @option options [String]
      #   @example Updates information for macro 12345
      #     Desk.update_macro(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/update
      def update_macro(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = put("macros/#{id}",options)
        if response['success']
          return response['results']['macro']
        else
          return response
        end
      end

      # Deletes a single macro
      #
      #   @param id [Integer] a macro ID
      #   @example Deletes macro 12345
      #     Desk.update_macro(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/update
      def delete_macro(id)
        response = delete("macros/#{id}")
        response
      end

      ##########
      # Macro Actions
      ##########

      # Returns extended information of macros
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Desk.macro_actions(1)
      #     Desk.macro_actions(1, :count => 5)
      #     Desk.macro_actions(1, :count => 5, :page => 3)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/actions
      def macro_actions(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("macros/#{id}/actions",options)
        response['results']
      end

      # Returns extended information on a single macro
      #
      #   @param id [Integer] a macro ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Desk.macro_action(12345, "set-case-description")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/actions/show
      def macro_action(id, slug)
        response = get("macros/#{id}/actions/#{slug}")
        response['action']
      end

      # Updates a single macro action
      #
      #   @param id [Integer] a macro ID
      #   @option options [String]
      #   @example Updates information for macro 12345
      #     Desk.update_macro_action(12345, "set-case-description", :value => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/actions/update
      def update_macro_action(id, slug, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = put("macros/#{id}/actions/#{slug}",options)
        if response['success']
          return response['results']['action']
        else
          return response
        end
      end

    end
  end
end
