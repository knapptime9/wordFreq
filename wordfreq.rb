class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    @document = File.read(filename)
    @document = @document.downcase.gsub(/[^a-z ]/, ' ').split(" ")
    @docHash = Hash.new
    @document.each {|word|
    if STOP_WORDS.include?(word)
    else
      @docHash[word].nil? ? @docHash[word] = 1 : @docHash[word] += 1
    end
  }
    @docHash.sort
  end

  def frequency(word)
    if @docHash[word].nil?
      0
    else
       @docHash[word]
    end
  end

  def frequencies
    @docHash
  end

  def top_words(number)
    @docHash.sort_by{|k,v| [-v]}.take(number).map{|k,v| [k,v]}
  end

  def print_report
    list = top_words(10)
    maxLength = list.sort_by{ |k,v| -k.length}.map{|k,v| k}.take(1)[0].length
    list.each {|k,v|
      puts "#{" "*(maxLength-k.length)}#{k}  | #{v} #{"*"*v}"}
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
