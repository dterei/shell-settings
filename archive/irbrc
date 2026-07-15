require 'irb/completion'
require 'irb/ext/save-history'

ARGV.concat [ "--readline",
              "--prompt-mode",
              "simple" ]

IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"

begin
  require 'pp'
  require 'dalli'

  def mem(host,user,pass)
    return Dalli::Client.new(host, :username => user, :password => pass)
  end

  def pp_stats(stats)
    stats.sort.map do |k,v|
      puts "## #{k}"
      v.sort.map do |k2, v2|
        puts "#{k2} => #{v2}"
      end
    end

    return nil
  end

  def pp_items(stats)
    stats.sort.map do |k,v|
      # extract slab numbers
      slabs = []
      v.map do |k2,v2|
        slabs << k2[/\d+/].to_i
      end
      slabs = slabs.uniq.sort

      puts "## #{k}"
      puts "Slab, Chuck Size, Number, Evicted, Evicted-NZ, OOM"
      slabs.each do |i|
        s  = v["items:#{i}:chunk_size"]
        n  = v["items:#{i}:number"]
        e  = v["items:#{i}:evicted"]
        ez = v["items:#{i}:evicted_nonzero"]
        o  = v["items:#{i}:outofmemory"]
        puts "#{i}, #{s}, #{n}, #{e}, #{ez}, #{o}"
      end
    end
  end

  def pp_key(stats, key)
    stats.sort.map do |k,v|
      puts "#{k} => #{v[key]}"
    end
  end
rescue
  print "Dalli not installed... no memcache shortcuts"
end
