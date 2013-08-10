Gem::Specification.new do |s|
  s.name = 'link2epub'
  s.version = '0.0.2'
  s.summary = "give me an links list, I make a epub for you"
  s.description = "link2epub is a tool to turn a list of url links to a epub book."
  s.licenses = ["MIT"]
  s.date = '2013-08-10'
  s.email = 'lyuehh@gmail.com'
  s.homepage = 'http://github.com/lyuehh/link2epub'
  s.has_rdoc = false
  s.authors = ["lyuehh"]

  s.add_dependency "erubis"
  s.add_dependency "gepub"
  s.add_dependency "nokogiri"

  # = MANIFEST =
  s.files = %w[
    README.md
    Rakefile
    Gemfile
    MIT-LICENSE.txt
    bin/link2epub
    lib/link2epub.rb
    tpl/article.tpl
    tpl/index.tpl
    tpl/nav.tpl
    examples/conf.yaml
  ]
  # = MANIFEST =
  s.test_files = []
  s.extra_rdoc_files = []
  s.extensions = []
  s.executables = ["link2epub"]
  s.require_paths = ["lib"]
  s.rubyforge_project = ''
end
