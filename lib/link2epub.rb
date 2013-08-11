# encoding: utf-8

require 'rubygems'
require 'open-uri'
require 'erubis'
require 'gepub'
require 'nokogiri'
require 'yaml'

class Links
    def initialize(file)
        @file = file
    end

    def to_a
        File.readlines(@file)
    end
end

class Article
    attr_accessor :title, :link, :content, :author, :date, :tpl, :file

    def initialize(link)
        @link = link
    end

    def to_file
        tpl = File.read(@tpl)
        eruby = Erubis::Eruby.new(tpl)

        File.open(@file, 'w') do |f|
            f.puts eruby.evaluate(self)
        end
    end

    def to_s
        puts "link: #{@link}"
        puts "title: #{@title}"
        puts "author: #{@author}"
        # puts "content: #{@content}"
    end
end

class Epub
    attr_accessor :articles, :conf_file, :conf, :links, :titles

    def initialize(conf_file)
        @conf_file = conf_file
        @conf = YAML::load(File.read(@conf_file))
        @links = Links.new(@conf['links_file']).to_a
        @articles = []
        @titles = []
    end

    def getArticles
        @links.each_with_index do |l, i|
            art = Article.new(l)
            art.tpl = "../tpl/article.tpl"
            art.file = "./file#{i+1}.html"
            art.content = Nokogiri::HTML(open(art.link)).css(@conf['rule']['content']).to_html
            art.title = Nokogiri::HTML(open(art.link)).css(@conf['rule']['title']).text
            art.author = Nokogiri::HTML(open(art.link)).css(@conf['rule']['author']).text
            art.date = Nokogiri::HTML(open(art.link)).css(@conf['rule']['date']).text
            art.to_file
            @articles.push(art)
        end
    end

    def getTitles
        @articles.each do |a|
            @titles.push(a.title)
        end
        @titles
    end

    def createFile(tpl, file)
        eruby = Erubis::Eruby.new(File.read(tpl))

        File.open(file, 'w') do |f|
            f.puts eruby.evaluate(self)
        end
    end

    def to_s
        @articles.each do |a|
            puts a.title
        end
    end

    def to_epub
        getArticles
        getTitles
        createFile('../tpl/nav.tpl', './nav.html')
        createFile('../tpl/index.tpl', './index.html')
        conf = @conf
        articles = @articles

        builder = GEPUB::Builder.new {
            language 'zh-cn'
            unique_identifier conf['link'], 'BookID', 'URL'
            title conf['title']
            subtitle conf['subtitle']
            creator conf['author']
            date Time.new
            # contributors '123', '456'

            resources(:workdir => '.') {
                nav 'nav.html'

                # cover_image 'img/image1.jpg' => 'image1.jpg'
                ordered {
                    file 'index.html'
                    file 'nav.html'

                    articles.each do |a|
                        file a.file
                        heading a.title
                    end
                }
            }
        }
        builder.generate_epub(@conf['file_name'])
        clean
    end

    def clean
        FileUtils.rm('./nav.html')
        FileUtils.rm('./index.html')
        @articles.each do |a|
            FileUtils.rm(a.file)
        end
    end
end

class Link2Epub
    attr_accessor :conf
    def initialize(conf)
        @conf = conf
    end

    def run
        epub = Epub.new(@conf)
        epub.to_epub
    end
end
#Link2Epub.new('./conf.yaml').run