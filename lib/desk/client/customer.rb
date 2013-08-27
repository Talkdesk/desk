module Desk
  class Client
    # Defines methods related to customers
    module Customer
      # Returns a list of customers
      #
      #   @option options [Hash]
      #   @example Return extended information for customers with optional params
      #     Desk.customers
      #     Desk.customers(:page => 1, :per_page => 3)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/API/customers/#list
      def customers(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get("customers", options)
      end

      # Returns extended information on a single customer
      #
      #   @example Return extended information for customer 12345
      #     Desk.customer(12345)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/API/customers/#show
      def customer(id)
        get("customers/#{id}")
      end

      # Create a new customer
      #
      #   @option options [Hash]
      #   @example Create a new customer
      #     Desk.create_customer(:first_name => "Chris", :last_name => "Warren")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/API/customers/#create
      def create_customer(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        post("customers", options)
      end

      # Update a customer
      #
      #   @option options [Hash]
      #   @example Update a customer's first and last names
      #     Desk.update_customer(1, :first_name => "Johnny", :last_name => "Doe")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/API/customers/#update
      def update_customer(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        put("customers/#{id}", options)
      end

      # Returns extended information of customers using search parameters
      #
      #   @option options [Hash]
      #   @example Return extended information for customers
      #     Desk.search_customers
      #     Desk.search_customers(:first_name => "John", :last_name => "Doe")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/API/customers/#search
      def search_customers(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get("customers/search", options)
      end
    end
  end
end
