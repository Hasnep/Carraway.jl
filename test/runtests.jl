using Carraway
import EzXML
using Test

const foo = tag(:foo)
const div = tag(:div)

@testset "Test Carraway.jl" begin
    @testset "Test tag can be constructed with no children" begin
        element = foo()
        @test element isa EzXML.Node
    end
    @testset "Test tag can be constructed with a string child" begin
        element = foo("Test string")
        @test element isa EzXML.Node
    end
    @testset "Test tag can be constructed with an element child" begin
        element = foo(div())
        @test element isa EzXML.Node
    end
    @testset "Test tag can be constructed with a vector child" begin
        element = foo([div(), "Test string", div()])
        @test element isa EzXML.Node
    end
    @testset "Test tag can be constructed with no children and properties" begin
        element = foo(; bar="baz")
        @test element isa EzXML.Node
    end
    @testset "Test tag can be constructed with a string child and properties" begin
        element = foo("Test string"; bar="baz")
        @test element isa EzXML.Node
    end
    @testset "Test tag can be constructed with an element child and properties" begin
        element = foo(div(); bar="baz")
        @test element isa EzXML.Node
    end
    @testset "Test tag can be constructed with a vector child and properties" begin
        element = foo([div(), "Test string", div()]; bar="baz")
        @test element isa EzXML.Node
    end
    @testset "Test tag can be constructed with a do block" begin
        element = foo() do
            [div(), "Test string", div()]
        end
        @test element isa EzXML.Node
    end
end
