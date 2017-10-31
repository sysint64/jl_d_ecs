module julia.components;

import julia.types;

struct Position {
   jlFloat32 x;
   jlFloat32 y;
}

struct Velocity {
   jlFloat32 dx;
   jlFloat32 dy;
}
