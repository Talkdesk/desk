module Desk
  class Client
    # Defines methods related to articles
    module Article
      # Returns a list of articles
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return a list of articles with optional params
      #     Desk.articles
      #     Desk.articles(per_page: 5)
      #     Desk.articles(per_page: 5, page: 3)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/API/articles/#list
      def articles(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("articles",options)
      end

      # Returns extended information on a single article
      #
      #   @param id [Integer] a article ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Desk.article(12345)
      #     Desk.article(12345, :by => "external_id")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/API/articles/#show
      def article(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("articles/#{id}",options)
      end

      # Creates a new article
      #
      #   @option options [Hash]
      #   @example Creates a new article
      #     Desk.create_article(:subject => "API Tips", :body => "Tips on using our API")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/API/articles/#create
      def create_article(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = post("articles",options)
      end

      # Updates a single article
      #
      #   @param id [Integer] a article ID
      #   @option options [Hash]
      #   @example Updates information for article 12345
      #     Desk.update_article(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/API/articles/#update
      def update_article(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = put("articles/#{id}", options)
      end

      # Deletes a single article
      #
      #   @param id [Integer] a article ID
      #   @example Deletes article 12345
      #     Desk.delete_article(12345)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/API/articles/#delete
      def delete_article(id)
        response = delete("articles/#{id}")
      end
    end
  end
end
