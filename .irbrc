require 'irb/completion'
require 'pp'
require 'dalli'

IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:AUTO_INDENT] = true

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

