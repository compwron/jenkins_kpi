require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/build')

describe Build do
  let(:build_url) { 'http://localhost:8080/job/job1.in.pipeline/1' }
  let(:build_id) { '1' }
  let(:build_json) { '{ "duration":1407 }' }
  subject { Build.new build_url }

  before do
    stub_request(:get, build_url + '/api/json/').to_return(:status => 200, :body => build_json)
  end

  it "uses the duration from the json to calculate a runtime in seconds" do
    subject.duration.should == 0.023
  end
end
