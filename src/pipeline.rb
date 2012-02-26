require File.dirname(__FILE__) + '/job'

class Pipeline
  def pipeline_duration job_url
    job = Job.new(job_url)
    duration = job.last_duration
    if downstream_url = job.downstream_job
      duration + pipeline_duration(downstream_url)
    else
      duration
    end
  end
end
