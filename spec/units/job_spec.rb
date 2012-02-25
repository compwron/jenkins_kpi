require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../src/job')

describe Job do
  let(:job_url) { 'http://localhost:8080/job/job1.in.pipeline/' }

  subject { Job.new job_url }

  before do
    stub_request(:get, job_url + 'api/json/').to_return(:status => 200, :body => job_json)
  end

  context "with downstream jobs" do
    let(:job_json) { '{"actions":[],"description":"","displayName":"job1.in.pipeline","displayNameOrNull":null,"name":"job1.in.pipeline","url":"http://localhost:8080/job/job1.in.pipeline/","buildable":true,"builds":[{"number":1,"url":"http://localhost:8080/job/job1.in.pipeline/1/"}],"color":"blue","firstBuild":{"number":1,"url":"http://localhost:8080/job/job1.in.pipeline/1/"},"healthReport":[{"description":"Build stability: No recent builds failed.","iconUrl":"health-80plus.png","score":100}],"inQueue":false,"keepDependencies":false,"lastBuild":{"number":1,"url":"http://localhost:8080/job/job1.in.pipeline/1/"},"lastCompletedBuild":{"number":1,"url":"http://localhost:8080/job/job1.in.pipeline/1/"},"lastFailedBuild":null,"lastStableBuild":{"number":1,"url":"http://localhost:8080/job/job1.in.pipeline/1/"},"lastSuccessfulBuild":{"number":1,"url":"http://localhost:8080/job/job1.in.pipeline/1/"},"lastUnstableBuild":null,"lastUnsuccessfulBuild":null,"nextBuildNumber":2,"property":[],"queueItem":null,"concurrentBuild":false,"downstreamProjects":[{"name":"job2.in.pipeline","url":"http://localhost:8080/job/job2.in.pipeline/","color":"blue"}],"scm":{},"upstreamProjects":[]}' }

    it "returns the url of the first downstream job" do
      subject.downstream_job.should == "http://localhost:8080/job/job2.in.pipeline/"
    end
  end

  context "without downstream jobs" do
    let(:job_json) { '{"actions":[],"description":"","displayName":"job3.in.pipeline","displayNameOrNull":null,"name":"job3.in.pipeline","url":"http://localhost:8080/job/job3.in.pipeline/","buildable":true,"builds":[{"number":1,"url":"http://localhost:8080/job/job3.in.pipeline/1/"}],"color":"blue","firstBuild":{"number":1,"url":"http://localhost:8080/job/job3.in.pipeline/1/"},"healthReport":[{"description":"Build stability: No recent builds failed.","iconUrl":"health-80plus.png","score":100}],"inQueue":false,"keepDependencies":false,"lastBuild":{"number":1,"url":"http://localhost:8080/job/job3.in.pipeline/1/"},"lastCompletedBuild":{"number":1,"url":"http://localhost:8080/job/job3.in.pipeline/1/"},"lastFailedBuild":null,"lastStableBuild":{"number":1,"url":"http://localhost:8080/job/job3.in.pipeline/1/"},"lastSuccessfulBuild":{"number":1,"url":"http://localhost:8080/job/job3.in.pipeline/1/"},"lastUnstableBuild":null,"lastUnsuccessfulBuild":null,"nextBuildNumber":2,"property":[],"queueItem":null,"concurrentBuild":false,"downstreamProjects":[],"scm":{},"upstreamProjects":[{"name":"job2.in.pipeline","url":"http://localhost:8080/job/job2.in.pipeline/","color":"blue"}]}' }

    it "returns nil as its downstream job" do
      subject.downstream_job.should be_nil
    end
  end
end
