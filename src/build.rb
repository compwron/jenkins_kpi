require File.dirname(__FILE__) + '/jenkins_resource'

class Build < JenkinsResource
  def duration
    resource_hash["duration"]/60/1000.0
  end
end
