require File.dirname(__FILE__) + '/jenkins_resource'
require File.dirname(__FILE__) + '/build'

class Job < JenkinsResource
  def last_duration
    build_url = resource_hash["lastBuild"]["url"]
    Build.new(build_url).duration
  end

  def downstream_job
    downstream_project = resource_hash["downstreamProjects"].first
    downstream_project ? downstream_project["url"] : nil
  end
end
