Pry.config.editor = 'vim'

Pry.commands.alias_command 'cont', 'continue'
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'

app_name = defined?(Rails) ? Rails.application.class.to_s.split("::").first.downcase : "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
Pry.prompt = [
  proc { |obj, nest_level, pry| "#{app_name} #{obj}[#{nest_level}]: #{'%03d' % pry.input_array.size}> " },
  proc { |obj, nest_level, _| "#{app_name} #{obj}[#{nest_level}]:    | " }
]

