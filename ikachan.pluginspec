Jenkins::Plugin::Specification.new do |plugin|
  plugin.name = "ikachan"
  plugin.display_name = "Ikachan Plugin"
  plugin.version = '0.0.1'
  plugin.description = 'Publisher for an IRC bot named Ikachan.'
  plugin.url = 'https://wiki.jenkins-ci.org/display/JENKINS/Ikachan+Plugin'
  plugin.developed_by "kentaro", "Kentaro Kuribayashi <kentarok@gmail.com>"
  plugin.uses_repository :github => "kentaro/jenkins-ikachan-plugin"
  plugin.depends_on 'ruby-runtime', '0.10'
  plugin.depends_on 'git', '1.1.11'
end
