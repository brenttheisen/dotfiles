Pry.config.editor = 'vim'

if Pry.commands['continue']
  Pry.commands.alias_command 'cont', 'continue'
  Pry.commands.alias_command 'c', 'continue'
end
Pry.commands.alias_command 's', 'step' if Pry.commands['step']
Pry.commands.alias_command 'n', 'next' if Pry.commands['next']
Pry.commands.alias_command 'f', 'finish' if Pry.commands['finish']

app_name = defined?(Rails) ? "#{Rails.application.class.to_s.split("::").first.downcase}[#{Rails.env}]" : "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
Pry.prompt = [
  proc { |obj, nest_level, pry|
    object_nest_level = " #{obj}[#{nest_level}]" if nest_level > 0
    "#{app_name}#{object_nest_level}: #{'%03d' % pry.input_array.size}> "
  },
  proc { |obj, nest_level, _|
    object_nest_level = " #{obj}[#{nest_level}]" if nest_level > 0
    "#{app_name}#{object_nest_level}:    | "
  }
]

