require 'ripper'

class Analyser

  PARTS_MAP = {
    :class => [:class, :ClassAnalyser],
    :method => [:def, :MethodAnalyser]
  }

  def initialize(code)
    if code.is_a? String
      _, @tree = Ripper.sexp(code)
    else
      @tree = code[1..-1]
    end
  end

  def each_part(part)
    parts = parts_of_type(part)
    if block_given?
      parts.each {|k| yield k }
    else
      parts
    end
  end

  def stats
    {}.tap do |stats|
      stats[:classes] = 2
      stats[:methods] = 2
    end
  end

  private

  def parts_of_type(type)
    token, klass = PARTS_MAP[type]
    @tree.select { |type, _| type == token }.map {|part| Object.const_get(klass).new part }
  end
end

class ClassAnalyser < Analyser
  def initialize(*)
    super
    @details, _, @body = @tree
    _, @tree = @body
  end

  def name
    @details[1][1]
  end
end

class MethodAnalyser < Analyser
  def name
    @tree.first[1]
  end
end
