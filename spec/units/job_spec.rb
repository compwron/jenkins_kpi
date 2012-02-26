require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../src/job')

describe Job do
  let(:job_url) { 'http://localhost:8080/job/job1.in.pipeline/' }

  subject { Job.new job_url }

  before do
    stub_request(:get, job_url + 'api/json/').to_return(:status => 200, :body => job_json)
  end

  context "with downstream jobs" do
    let(:job_json) { '{ "downstreamProjects":[{"url":"http://localhost:8080/job/job2.in.pipeline/"}] }' }

    it "returns the url of the first downstream job" do
      subject.downstream_job.should == "http://localhost:8080/job/job2.in.pipeline/"
    end
  end

  context "without downstream jobs" do
    let(:job_json) { '{"downstreamProjects":[]}' }

    it "returns nil as its downstream job" do
      subject.downstream_job.should be_nil
    end
  end
end
