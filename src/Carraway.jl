module Carraway

import EzXML
import Markdown

export tag
export build_page

include("markdown.jl")

function flatten_elements(elements)
    function append(a_list, to_add)
        if length(a_list) == 0
            return [to_add]
        elseif typeof(last(a_list)) == String && typeof(to_add) == String
            last_element = pop!(a_list)
            return vcat(a_list, last_element * to_add)
        else
            return vcat(a_list, to_add)
        end
    end

    return foldl(append, elements; init=[])
end

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
        for child in flatten_elements(children)
            if child isa String
                child_node = EzXML.TextNode(child)
                EzXML.link!(node, child_node)
            elseif child isa EzXML.Node
                child_node = child
                EzXML.link!(node, child_node)
            end
        end
        return node
    end

    # Function child to allow do-syntax
    fn(child::Function; properties...) = fn(child(); properties...)

    return fn
end

function build_page(file_path, page_data::EzXML.Node)
    @info "Compiling `$file_path`."
    html_document = EzXML.HTMLDocument()
    EzXML.setroot!(html_document, page_data)
    write(file_path, html_document)
end

end # module
