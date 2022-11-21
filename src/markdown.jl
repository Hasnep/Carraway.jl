# import Markdown
# import KaTeX

# export parse_markdown

# render_markdown(s::String) = s
# render_markdown(md::Markdown.MD) = collect(render_markdown.(md.content))
# render_markdown(md::Markdown.Admonition) = tag(:div)([tag(:p)(md.title; class="admonition-title"), render_markdown.(md.content)...]; class="admonition $(md.category)")
# render_markdown(md::Markdown.BlockQuote) = tag(:blockquote)(render_markdown.(md.content))
# render_markdown(md::Markdown.Bold) = tag(:strong)(md.text)
# render_markdown(md::Markdown.Code) = tag(:pre)(tag(:code)(md.code; class="language-$(md.language)"))
# # render_markdown(md::Markdown.Config) = 
# # render_markdown(md::Markdown.Footnote) = 
# render_markdown(md::Markdown.Header{1}) = tag(:h1)(md.text)
# render_markdown(md::Markdown.Header{2}) = tag(:h2)(md.text)
# render_markdown(md::Markdown.Header{3}) = tag(:h3)(md.text)
# render_markdown(md::Markdown.Header{4}) = tag(:h4)(md.text)
# render_markdown(md::Markdown.Header{5}) = tag(:h5)(md.text)
# render_markdown(md::Markdown.Header{6}) = tag(:h6)(md.text)
# render_markdown(::Markdown.HorizontalRule) = tag(:hr)()
# render_markdown(md::Markdown.Image) = tag(:img)(src=md.url, alt=md.alt)
# # render_markdown(md::Markdown.InnerConfig) = 
# render_markdown(md::Markdown.Italic) = tag(:em)(md.text)
# render_markdown(md::Markdown.LaTeX) = KaTeX.render_katex(md.formula)
# # render_markdown(md::Markdown.LineBreak) = 
# render_markdown(md::Markdown.Link) = tag(:a)(render_markdown.(md.text); href=md.url)
# # render_markdown(md::Markdown.List) = md.ordered ? tag(:ol)(tag(:li).(render_markdown(md.items))) : tag(:ul)(tag(:li).(render_markdown(md.items)))
# render_markdown(md::Markdown.Paragraph) = tag(:p)(render_markdown.(md.content))
# render_markdown(md::Markdown.Table) = md |> Markdown.html |> EzXML.parsehtml |> EzXML.root |> EzXML.firstnode |> EzXML.firstnode |> EzXML.unlink!

# parse_markdown(args...; kwargs...)::Vector{EzXML.Node} = render_markdown(Markdown.parse(args...; kwargs...))
