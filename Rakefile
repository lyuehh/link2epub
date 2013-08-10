desc "help"
task :help do
    puts "commands:"
    puts "rake help"
    puts "rake build"
    puts "rake push"
end

task :default => :help

desc "build"
task :build do
    sh 'gem build link2epub.gemspec'
end

desc "push gem to http://rubygems.org"
task :push do
    sh 'gem push *.gem'
end

desc "examples"
task :example do
    sh 'cd examples; link2epub conf.yaml'
end