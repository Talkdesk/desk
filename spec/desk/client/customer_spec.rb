require 'helper'

describe Desk::Client do
  Desk::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Desk::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      end

      describe ".customers" do

        context "lookup" do

          before do
            stub_get("customers.#{format}").
              to_return(:body => fixture("customers.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.customers
            a_get("customers.#{format}").
              should have_been_made
          end

          it "should return a list of customers" do
            customers = @client.customers

            customers.entries.should be_a Array
            customers.entries.first._links.self[:class].should == "customer"
          end

        end
      end

      describe ".customer" do

        context "lookup" do

          before do
            stub_get("customers/1.#{format}").
              to_return(:body => fixture("customer.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.customer(1)
            a_get("customers/1.#{format}").
              should have_been_made
          end

          it "should return a customer entry" do
            customer = @client.customer(1)

            customer._links.self[:class].should == "customer"
          end

        end
      end

      describe ".create_customer" do

        context "create" do

          before do
            stub_post("customers.#{format}").
              to_return(:body => fixture("customer_create.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.create_customer(:name => "John Doe")
            a_post("customers.#{format}").
              should have_been_made
          end

          it "should return the information about this user" do
            customer = @client.create_customer(:first_name => "John", :last_name => "Doe")

            customer._links.self[:class].should == "customer"
            customer.first_name.should == "John"
          end

        end
      end

      describe ".update_customer" do

        context "update" do

          before do
            stub_put("customers/1.#{format}").
              to_return(:body => fixture("customer_update.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.update_customer(1, :first_name => "Johnny", :last_name => "Doe")
            a_put("customers/1.#{format}").
              should have_been_made
          end

          it "should return the updated customer entry" do
            customer = @client.update_customer(1, :first_name => "Johnny", :last_name => "Doe")

            customer._links.self[:class].should == "customer"
            customer.first_name.should == "Johnny"
          end

        end
      end

      describe ".search_customers" do

        context "search" do
          let(:first_name_param) { "John" }
          let(:last_name_param) { "Doe" }

          before do
            stub_get("customers/search.#{format}?first_name=#{first_name_param}&last_name=#{last_name_param}").
              to_return(:body => fixture("customer_search.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.search_customers(:first_name => first_name_param, :last_name => last_name_param)
            a_get("customers/search.#{format}?first_name=#{first_name_param}&last_name=#{last_name_param}").
              should have_been_made
          end

          it "should return a list of customers with matching criteria" do
            search_results = @client.search_customers(:first_name => first_name_param, :last_name => last_name_param)

            customer = search_results.entries.first
            customer._links.self[:class].should == "customer"
            customer.first_name.should == first_name_param
            customer.last_name.should == last_name_param
          end

        end
      end
    end
  end
end
