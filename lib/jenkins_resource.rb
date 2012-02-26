class JenkinsResource
  attr_accessor :url
  require 'open-uri'
  require 'json'

  def initialize url
    self.url = url
  end

  protected
  def resource_hash
    @resource_hash ||= open(get_api_url(url)) {|f| JSON.parse f.first }
  end

  def get_api_url url
    url = url_must_end_with_slash(url)
    url =~ /json/ ? url : url + 'api/json/'
  end

  def url_must_end_with_slash url
    url =~ /\/$/ ? url : url + '/'
  end
end
