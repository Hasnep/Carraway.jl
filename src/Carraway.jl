module Carraway

import Genie
import KaTeX

# Create functions for all HTML elements

ALL_ELEMENTS = [Genie.Renderer.Html.NORMAL_ELEMENTS; Genie.Renderer.Html.VOID_ELEMENTS]

for element in ALL_ELEMENTS
  # Create element function
  Core.eval(@__MODULE__, Meta.parse("const $element = Genie.Renderer.Html.$element"))
  # Export the function
  Core.eval(@__MODULE__, Meta.parse("export $element"))
end

# Re-export the HTML string type that Genie functions return
const ParsedHTMLString = Genie.Renderer.Html.ParsedHTMLString
export ParsedHTMLString

# Building
export build_page
function build_page(content::ParsedHTMLString, file_path)
  @info "Building `$file_path`."
  write(file_path, content)
end

# Markdown
import Markdown

# markdown_to_html(io::IO, md::Markdown.LaTeX) = print(io, KaTeX.render_katex(md.formula))
# markdown_to_html(io::IO, md) = print(io, Markdown.html(io, md))
# markdown_to_html(md) = sprint(markdown_to_html, md)

# Do a little type piracy as a treat :)
Markdown.html(io::IO, md::Markdown.LaTeX) = print(io, KaTeX.render_katex(md.formula))
Markdown.htmlinline(io::IO, md::Markdown.LaTeX) = print(io, KaTeX.render_katex(md.formula))

export parse_markdown
parse_markdown(markdown_string) = markdown_string |> Markdown.parse |> Markdown.html |> ParsedHTMLString

# Config
import TOML
export get_website_config
function get_website_config(config_struct, config_file_path=joinpath(pwd(), "config.toml"))
  config_dict = Dict(Symbol(k) => v for (k, v) in open(TOML.parse, config_file_path))
  return config_struct(; config_dict...)
end

# Static
export copy_static_files
function copy_static_files()
  destination = joinpath("build", "static")
  mkpath(destination)
  return cp(joinpath(pwd(), "static"), destination; force=true)
end

end # module
