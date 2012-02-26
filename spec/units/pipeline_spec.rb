require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/pipeline')

describe Pipeline do
  let(:job_url) { 'some_damn_url' }
  before do
    Job.should_receive(:new).with(job_url).and_return(job)
  end

  context "for a job with no downstream jobs" do
    let(:job) { stub(:downstream_job => nil, :last_duration => 0.1337) }

    it "returns the duration of the job" do
      subject.duration(job_url).should == 0.1337
    end
  end

  context "for a job with a downstream job" do
    let(:job) { stub(:downstream_job => :downstream_url, :last_duration => 0.1337) }
    let(:downstream_job) { stub(:downstream_job => nil, :last_duration => 0.24) }

    before do
      Job.should_receive(:new).with(:downstream_url).and_return(downstream_job)
    end

    it "returns the sum of duration of the job and its downstream jobs" do
      subject.duration(job_url).should == (job.last_duration + downstream_job.last_duration)
    end
  end
end
