Pry.config.prompt = proc { |target_self, nest_level, pry|
    nested = (nest_level.zero?) ? '' : ":#{nest_level}"
    "[#{pry.input_array.size}]\e[0;31m#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}\e[0m(#{Pry.view_clip(target_self)})> "
    }
Pry.config.editor = "vim"
