Pry.config.editor = 'vim'

app_name = defined?(Rails) ? Rails.application.class.to_s.split("::").first.downcase : "ruby-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
Pry.prompt = [
  proc { |obj, nest_level, pry| "\e[1;31m\u25C8  \e[36m#{app_name} \e[34m(\e[31m#{obj}\e[34m:\e[31m#{nest_level}\e[34m) \e[34m[\e[31m#{pry.input_array.size}\e[34m] \e[31;1m> \e[1;37m" },
  proc { |obj, nest_level, _| "\e[1;31m\u25C8  \e[36m#{app_name} \e[34m(\e[31m#{obj}\e[34m:\e[31m#{nest_level}\e[34m) \e[34m[\e[31m?\e[34m] \e[31;1m| \e[1;37m" }
]
