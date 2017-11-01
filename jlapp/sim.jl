struct Position
   x::Cint
   y::Cint
end

struct Velocity
   dx::Cint
   dy::Cint
end

struct MoveNode
   position::Ref{Position}
   velocity::Ref{Velocity}
end

function greet()
    println("Hello from julia")
end

function constructPosition()
    return Position(1, 90)
end

function constructVelocity()
    return Velocity(4, 23)
end

function constructMoveNode()
    pos = constructPosition()
    vel = constructVelocity()
    return MoveNode(Ref{Position}(pos), Ref{Velocity}(vel))
end
