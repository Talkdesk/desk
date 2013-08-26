require 'helper'

describe Faraday::Response do
  before do
    @client = Desk::Client.new
  end

  {
    400 => Desk::BadRequest,
    401 => Desk::Unauthorized,
    403 => Desk::Forbidden,
    404 => Desk::NotFound,
    406 => Desk::NotAcceptable,
    409 => Desk::Conflict,
    420 => Desk::EnhanceYourCalm,
    422 => Desk::Unprocessable,
    500 => Desk::InternalServerError,
    502 => Desk::BadGateway,
    503 => Desk::ServiceUnavailable,
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        stub_get('users/1.json').
          with(:headers => {'Accept'=>'application/json', 'User-Agent'=>Desk::Configuration::DEFAULT_USER_AGENT}).
          to_return(:status => status)
      end

      it "should raise #{exception.name} error" do
        lambda do
          @client.user(1)
        end.should raise_error(exception)
      end
    end
  end
end
