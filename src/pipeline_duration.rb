class PipelineDuration
  require 'open-uri'
  require 'json'

  def get_hash url 
    open(get_api_url(url)) {|f| JSON.parse f.first } 
  end

  def get_api_url url
    url = url_must_end_with_slash(url)
    url =~ /json/ ? url : url + 'api/json/'
  end

  def url_must_end_with_slash url
    url =~ /\/$/ ? url : url + '/'
  end

  def build_duration build_hash
    build_hash["duration"]/60/1000.0
  end

  def get_pipeline_duration job, duration=0
    duration += get_duration(job)
    if has_downstream_job(job) 
      get_pipeline_duration(downstream_job(job), duration)
    else
      return duration
    end
  end

  def get_duration job 
    build_duration(get_hash(get_hash(job)["lastBuild"]["url"]))
  end

  def has_downstream_job job
    !(get_hash(job)["downstreamProjects"] == [])
  end

  def downstream_job job
    downstream_project = get_hash(job)["downstreamProjects"].first
    downstream_project ? downstream_project["url"] : "There is no downstream build"
  end
end