IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:LOAD_MODULES] = [] unless IRB.conf.key?(:LOAD_MODULES)
IRB.conf[:LOAD_MODULES] << 'irb/completion' unless IRB.conf[:LOAD_MODULES].include?('irb/completion')
