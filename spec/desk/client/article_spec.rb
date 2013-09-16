require 'helper'

describe Desk::Client do
  Desk::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Desk::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      end

      describe ".articles" do

        context "lookup" do

          before do
            stub_get("articles.#{format}").
              to_return(:body => fixture("articles.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should post to the correct resource" do
            @client.articles
            a_get("articles.#{format}").
              should have_been_made
          end

          it "should return the articles" do
            articles = @client.articles

            articles.entries.should be_a Array
            articles.entries.first._links.self[:class].should == 'article'
          end

        end
      end

      describe ".article" do

        context "lookup" do

          before do
            stub_get("articles/1.#{format}").
              to_return(:body => fixture("article.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.article(1)
            a_get("articles/1.#{format}").
              should have_been_made
          end

          it "should return an article entry" do
            article = @client.article(1)

            article._links.self[:class].should == "article"
            article.subject.should == "Awesome Subject"
          end

        end
      end

      describe ".create_article" do

        context "create" do
          let(:subject) { "How to make your customers happy" }

          before do
            stub_post("articles.#{format}").
              to_return(:body => fixture("article_create.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should post to the correct resource" do
            @client.create_article(:subject => "API Tips", :main_content => "Tips on using our API")
            a_post("articles.#{format}").
              should have_been_made
          end

          it "should return the new article" do
            article = @client.create_article(:subject => subject, :body => "<strong>Use Desk.com</strong>")

            article._links.self[:class].should == 'article'
            article.subject.should == subject
          end

        end
      end

      describe ".update_article" do

        context "update" do
          let(:subject) {  "How to make your customers happy" }
          let(:body) { "<strong>Use Desk.com</strong>" }

          before do
            stub_put("articles/1.#{format}").
              to_return(:body => fixture("article_update.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should post to the correct resource" do
            @client.update_article(1, :subject => subject, :body => body)
            a_put("articles/1.#{format}").
              should have_been_made
          end

          it "should return the updated article" do
            article = @client.update_article(1, :subject => subject, :body => body)

            article._links.self[:class].should == 'article'
            article.body.should == body
          end

        end
      end

      describe ".delete_article" do

        context "delete" do

          before do
            stub_delete("articles/1.#{format}").
              to_return({})
          end

          it "should post to the correct resource" do
            @client.delete_article(1)
            a_delete("articles/1.#{format}").
              should have_been_made
          end
        end
      end

    end
  end
end
