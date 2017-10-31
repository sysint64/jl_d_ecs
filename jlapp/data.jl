struct Position
   x::Float32
   y::Float16
end

struct Velocity
   dx::Float32
   dy::Float16
end

struct MoveNode
   position::Ref{Position}
   velocity::Ref{Velocity}
end
