require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../src/build')

describe Build do
  let(:build_url) { 'http://localhost:8080/job/job1.in.pipeline/1' }
  let(:build_id) { '1' }
  let(:build_json) { '{"actions":[{"causes":[{"shortDescription":"Started by user anonymous","userId":null,"userName":"anonymous"}]}],"artifacts":[],"building":false,"description":null,"duration":1407,"fullDisplayName":"job1.in.pipeline #1","id":"2012-02-23_22-49-32","keepLog":false,"number":1,"result":"SUCCESS","timestamp":1330066172459,"url":"http://localhost:8080/job/job1.in.pipeline/1/","builtOn":"","changeSet":{"items":[],"kind":null},"culprits":[]}' }
  subject { Build.new build_url }

  before do
    stub_request(:get, build_url + '/api/json/').to_return(:status => 200, :body => build_json)
  end

  it "uses the duration from the json to calculate a runtime in seconds" do
    subject.duration.should == 0.023
  end
end
