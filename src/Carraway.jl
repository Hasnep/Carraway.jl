module Carraway

import EzXML
import Markdown

export tag
export parse_markdown

function tag(name)
    # No children
    function fn(; properties...)
        node = EzXML.ElementNode(String(Symbol(name)))
        for (property, value) in properties
            node[String(property)] = value
        end
        return node
    end

    # String child
    function fn(child::String; properties...)
        node = fn(; properties...)
        EzXML.link!(node, EzXML.TextNode(child))
        return node
    end

    # Element child
    function fn(child::EzXML.Node; properties...)
        node = fn(; properties...)
        EzXML.link!(node, child)
        return node
    end

    # Vector of children
    function fn(children::Vector; properties...)
        node = fn(; properties...)
        for child in children
            if child isa String
                child = EzXML.TextNode(child)
            elseif child isa EzXML.Node
            end
            EzXML.link!(node, child)
        end
        return node
    end

    # Function child to allow do-syntax
    fn(child::Function; properties...) = fn(child(); properties...)

    return fn
end

function parse_markdown(args...; kwargs...)::Vector{EzXML.Node}
    elements = Markdown.parse(args...; kwargs...) |> Markdown.html |> EzXML.parsehtml |> EzXML.root |> EzXML.firstnode |> EzXML.eachelement |> collect
    EzXML.unlink!.(elements)
    return elements
end

end # module
