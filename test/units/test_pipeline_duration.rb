require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class TestKpiTracker < Test::Unit::TestCase

  def setup
    stub_request(:get, "http://localhost:8080/job/job1.in.pipeline/1/api/json/").to_return(:status => 200, :body => '{"actions":[{"causes":[{"shortDescription":"Started by user anonymous","userId":null,"userName":"anonymous"}]}],"artifacts":[],"building":false,"description":null,"duration":1407,"fullDisplayName":"job1.in.pipeline #1","id":"2012-02-23_22-49-32","keepLog":false,"number":1,"result":"SUCCESS","timestamp":1330066172459,"url":"http://localhost:8080/job/job1.in.pipeline/1/","builtOn":"","changeSet":{"items":[],"kind":null},"culprits":[]}')
    stub_request(:get, "http://localhost:8080/job/job1.in.pipeline/api/json/").to_return(:status => 200, :body => '{"actions":[],"description":"","displayName":"job1.in.pipeline","displayNameOrNull":null,"name":"job1.in.pipeline","url":"http://localhost:8080/job/job1.in.pipeline/","buildable":true,"builds":[{"number":1,"url":"http://localhost:8080/job/job1.in.pipeline/1/"}],"color":"blue","firstBuild":{"number":1,"url":"http://localhost:8080/job/job1.in.pipeline/1/"},"healthReport":[{"description":"Build stability: No recent builds failed.","iconUrl":"health-80plus.png","score":100}],"inQueue":false,"keepDependencies":false,"lastBuild":{"number":1,"url":"http://localhost:8080/job/job1.in.pipeline/1/"},"lastCompletedBuild":{"number":1,"url":"http://localhost:8080/job/job1.in.pipeline/1/"},"lastFailedBuild":null,"lastStableBuild":{"number":1,"url":"http://localhost:8080/job/job1.in.pipeline/1/"},"lastSuccessfulBuild":{"number":1,"url":"http://localhost:8080/job/job1.in.pipeline/1/"},"lastUnstableBuild":null,"lastUnsuccessfulBuild":null,"nextBuildNumber":2,"property":[],"queueItem":null,"concurrentBuild":false,"downstreamProjects":[{"name":"job2.in.pipeline","url":"http://localhost:8080/job/job2.in.pipeline/","color":"blue"}],"scm":{},"upstreamProjects":[]}')
    stub_request(:get, "http://localhost:8080/job/job3.in.pipeline/api/json/").to_return(:status => 200, :body => '{"actions":[],"description":"","displayName":"job3.in.pipeline","displayNameOrNull":null,"name":"job3.in.pipeline","url":"http://localhost:8080/job/job3.in.pipeline/","buildable":true,"builds":[{"number":1,"url":"http://localhost:8080/job/job3.in.pipeline/1/"}],"color":"blue","firstBuild":{"number":1,"url":"http://localhost:8080/job/job3.in.pipeline/1/"},"healthReport":[{"description":"Build stability: No recent builds failed.","iconUrl":"health-80plus.png","score":100}],"inQueue":false,"keepDependencies":false,"lastBuild":{"number":1,"url":"http://localhost:8080/job/job3.in.pipeline/1/"},"lastCompletedBuild":{"number":1,"url":"http://localhost:8080/job/job3.in.pipeline/1/"},"lastFailedBuild":null,"lastStableBuild":{"number":1,"url":"http://localhost:8080/job/job3.in.pipeline/1/"},"lastSuccessfulBuild":{"number":1,"url":"http://localhost:8080/job/job3.in.pipeline/1/"},"lastUnstableBuild":null,"lastUnsuccessfulBuild":null,"nextBuildNumber":2,"property":[],"queueItem":null,"concurrentBuild":false,"downstreamProjects":[],"scm":{},"upstreamProjects":[{"name":"job2.in.pipeline","url":"http://localhost:8080/job/job2.in.pipeline/","color":"blue"}]}')
    stub_request(:get, "http://localhost:8080/job/job2.in.pipeline/api/json/").to_return(:status => 200, :body => '{"actions":[],"description":"","displayName":"job2.in.pipeline","displayNameOrNull":null,"name":"job2.in.pipeline","url":"http://localhost:8080/job/job2.in.pipeline/","buildable":true,"builds":[{"number":1,"url":"http://localhost:8080/job/job2.in.pipeline/1/"}],"color":"blue","firstBuild":{"number":1,"url":"http://localhost:8080/job/job2.in.pipeline/1/"},"healthReport":[{"description":"Build stability: No recent builds failed.","iconUrl":"health-80plus.png","score":100}],"inQueue":false,"keepDependencies":false,"lastBuild":{"number":1,"url":"http://localhost:8080/job/job2.in.pipeline/1/"},"lastCompletedBuild":{"number":1,"url":"http://localhost:8080/job/job2.in.pipeline/1/"},"lastFailedBuild":null,"lastStableBuild":{"number":1,"url":"http://localhost:8080/job/job2.in.pipeline/1/"},"lastSuccessfulBuild":{"number":1,"url":"http://localhost:8080/job/job2.in.pipeline/1/"},"lastUnstableBuild":null,"lastUnsuccessfulBuild":null,"nextBuildNumber":2,"property":[],"queueItem":null,"concurrentBuild":false,"downstreamProjects":[{"name":"job3.in.pipeline","url":"http://localhost:8080/job/job3.in.pipeline/","color":"blue"}],"scm":{},"upstreamProjects":[{"name":"job1.in.pipeline","url":"http://localhost:8080/job/job1.in.pipeline/","color":"blue"}]}')
    stub_request(:get, "http://localhost:8080/job/job2.in.pipeline/1/api/json/").to_return(:status => 200, :body => '{"actions":[{"causes":[{"shortDescription":"Started by upstream project \"job1.in.pipeline\" build number 1","upstreamBuild":1,"upstreamProject":"job1.in.pipeline","upstreamUrl":"job/job1.in.pipeline/"}]}],"artifacts":[],"building":false,"description":null,"duration":253,"fullDisplayName":"job2.in.pipeline #1","id":"2012-02-23_22-49-38","keepLog":false,"number":1,"result":"SUCCESS","timestamp":1330066178956,"url":"http://localhost:8080/job/job2.in.pipeline/1/","builtOn":"","changeSet":{"items":[],"kind":null},"culprits":[]}')
    stub_request(:get, "http://localhost:8080/job/job3.in.pipeline/1/api/json/").to_return(:status => 200, :body => '{"actions":[{"causes":[{"shortDescription":"Started by upstream project \"job2.in.pipeline\" build number 1","upstreamBuild":1,"upstreamProject":"job2.in.pipeline","upstreamUrl":"job/job2.in.pipeline/"}]}],"artifacts":[],"building":false,"description":null,"duration":73,"fullDisplayName":"job3.in.pipeline #1","id":"2012-02-23_22-49-44","keepLog":false,"number":1,"result":"SUCCESS","timestamp":1330066184244,"url":"http://localhost:8080/job/job3.in.pipeline/1/","builtOn":"","changeSet":{"items":[],"kind":null},"culprits":[]}')
  end

  def test_has_downstream_job
    has_downstream_projects = 'http://localhost:8080/job/job1.in.pipeline'
    lacks_downstream_projects = 'http://localhost:8080/job/job3.in.pipeline'
    assert_equal true, KpiTracker.new.has_downstream_job(has_downstream_projects)
    assert_equal false, KpiTracker.new.has_downstream_job(lacks_downstream_projects)
  end

  def test_get_duration
    job1 = 'http://localhost:8080/job/job1.in.pipeline'
    assert_equal 0.023, KpiTracker.new.get_duration(job1)
  end

  def test_downstream_job
    job1 = 'http://localhost:8080/job/job1.in.pipeline/'
    job2 = 'http://localhost:8080/job/job2.in.pipeline/'
    job3 = 'http://localhost:8080/job/job3.in.pipeline/'
    assert_equal job2, KpiTracker.new.downstream_job(job1)
    assert_equal job3, KpiTracker.new.downstream_job(job2)
    assert_equal "There is no downstream build", KpiTracker.new.downstream_job(job3)
  end

  def test_get_pipeline_duration
    first_job_in_pipeline = 'http://localhost:8080/job/job1.in.pipeline/'
    assert_equal 0.028, KpiTracker.new.get_pipeline_duration(first_job_in_pipeline)
  end
end