require File.expand_path(File.dirname(__FILE__) + '/pipeline_duration')

class PrintPipelineDuration
  first_job_in_pipeline = ARGV[0]

  puts PipelineDuration.new.pipeline_duration(first_job_in_pipeline)
  puts "	This only adds the total duration of the most recent build in each job in the pipeline. 
  	It doesn't actually know which build to trace through."
end
