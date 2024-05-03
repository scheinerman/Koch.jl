module Koch

using SimpleDrawing

export snowflake
export bump_seg, bump_polygon, base_triangle, draw_path

function bump_seg(a::Complex{T}, b::Complex{T}) where {T}
    aa = a + (b - a) / 3
    bb = b + (a - b) / 3

    mm = (a + b) / 2


    cc = mm - sqrt(3) * (bb - mm) * im

    return aa, cc, bb
end

function bump_polygon(v::Vector{Complex{T}}) where {T}
    result = Vector{Complex{Float64}}()
    n = length(v) - 1

    push!(result, v[1])

    for i = 1:n
        a = v[i]
        b = v[i+1]
        pts = bump_seg(a, b)
        for j = 1:3
            push!(result, pts[j])
        end
        push!(result, b)
    end
    return result
end

function base_triangle()
    [exp(im * k * 2π / 3) * im for k = 0:3]
end


function draw_path(vv, wide = 1)
    n = length(vv) - 1
    for i = 1:n
        draw_segment(vv[i], vv[i+1], color = :black, linewidth=wide)
    end
    finish()
end

"""
    snowflake(n::Int = 4, wide = 1)

Draw a picture of the Koch snowflake curve. The parameter `n`
determines the number of iterations of the bump algorithm. 
With `n=0` the result is an equilateral triangle. 

The optional second parameter specifies the line
width. 
"""
function snowflake(n::Int = 4, wide = 1)
    newdraw()
    a = base_triangle()
    for k = 1:n
        a = bump_polygon(a)
    end
    draw_path(a, wide)
    finish()
end
end # module Koch
