require 'irb/completion'
require 'pp'
require 'dalli'

IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:AUTO_INDENT] = true

def mem(host,user,pass)
  return Dalli::Client.new(host, :username => user, :password => pass)
end

