require 'dm-core'
require 'dm-migrations'

def setup_datamapper
  dbfile = File.expand_path("../test.sqlite3", __FILE__)
  #DataMapper::Logger.new($stdout, :debug)
  DataMapper.setup(:default, "sqlite://#{dbfile}")
end

def db_reset
  DataMapper.auto_migrate!
end

def db_migrate
  DataMapper.auto_upgrade!
end

class Metric
  include DataMapper::Resource

  property :id, Serial
  property :source, String
  property :timestamp, DateTime
end

class Criteria
  include DataMapper::Resource

  property :id, Serial
  belongs_to :metric, :child_key => [:metric_id]
  property :name, String
  property :value, String
end


def record_metric(source, data)
  m = Metric.new
  m.timestamp = Time.now
  m.source = source
  m.save

  data.each do |name, value|
    c = Criteria.new
    c.metric = m
    c.name = name
    c.value = value
    c.save
  end
end


def each_book
  folder  = File.expand_path("../books/*", __FILE__)
  Dir[folder].each do |f|
    author = File.basename(f)
    Dir["#{f}/*"].each do |n|
      name = File.basename(n).gsub(".txt", "")
      yield author, name, n
    end
  end
end

def paragraphs(file)
  File.read(file).split(/(\r\n){2,}/).map {|s| s.strip }.compact
end

def sentences(paragraph)
  paragraph.split(/[.!:][\s$]/).map {|s| s.strip }.compact
end

def words(str)
  str.gsub(/[\r\n]+/, ' ').scan(/\w+/).map {|w| w.downcase }
end

setup_datamapper
db_reset
#db_migrate


each_book do |author, name, path|
  puts ""
  puts "Author: #{author}, Name: #{name}, Path:#{path}"
  paras = paragraphs(path)
  paras.each do |para|
    sents = sentences(para)
    sents.each_with_index do |sent, sno|
      words(sent).each_with_index do |word, wno|
        putc"."
        #p "S#{sno}, W#{wno}: #{word}"
        record_metric("books", :author => author,
                      :title => name,
                      :sentence_number => sno,
                      :word_number => wno,
                      :word => word)
      end
    end
  end
end
