$ ->
  converter = Markdown.getSanitizingConverter()
  converter.hooks.chain "preBlockGamut", (text, rbg) ->
    text.replace(/^ {0,3}""" *\n((?:.*?\n)+?) {0,3}""" *$/g, (whole, inner) ->
      "<blockquote>" + rbg(inner) + "</blockquote>\n"
    )

  editor = new Markdown.Editor(converter)
  editor.run()
