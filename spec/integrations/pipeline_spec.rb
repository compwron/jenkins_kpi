require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../src/pipeline')

describe Pipeline do
  before do
    stub_request(:get, "http://localhost:8080/job/job1.in.pipeline/api/json/").to_return(:status => 200, :body => '{"lastBuild":{"url":"http://localhost:8080/job/job1.in.pipeline/1/"},"downstreamProjects":[{"url":"http://localhost:8080/job/job2.in.pipeline/"}]}')
    stub_request(:get, "http://localhost:8080/job/job1.in.pipeline/1/api/json/").to_return(:status => 200, :body => '{ "duration":1407}')
    
    stub_request(:get, "http://localhost:8080/job/job2.in.pipeline/api/json/").to_return(:status => 200, :body => '{"lastBuild":{"url":"http://localhost:8080/job/job2.in.pipeline/1/"},"downstreamProjects":[{"url":"http://localhost:8080/job/job3.in.pipeline/"}]}')
    stub_request(:get, "http://localhost:8080/job/job2.in.pipeline/1/api/json/").to_return(:status => 200, :body => '{"duration":253}')
   
    stub_request(:get, "http://localhost:8080/job/job3.in.pipeline/api/json/").to_return(:status => 200, :body => '{"lastBuild":{"url":"http://localhost:8080/job/job3.in.pipeline/1/"},"downstreamProjects":[]}')
    stub_request(:get, "http://localhost:8080/job/job3.in.pipeline/1/api/json/").to_return(:status => 200, :body => '{"duration":73}')
  end

  it "calculates the total duration of the last build of the pipeline" do
    first_job_in_pipeline = 'http://localhost:8080/job/job1.in.pipeline/'
    subject.pipeline_duration(first_job_in_pipeline).should == 0.028
  end
end
