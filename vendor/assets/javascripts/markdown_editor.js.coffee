//= require pagedown/pagedown_converter
//= require pagedown/pagedown_sanitizer
//= require pagedown/pagedown_editor

ready = ->
  converter = Markdown.getSanitizingConverter()
  editor = new Markdown.Editor(converter)
  editor.run()

$(document).ready(ready)
