module ecs.components;

struct Point {
   float x;
   float y;
}

struct Color {
   float r;
   float g;
   float b;
   float a;
}

struct Figure {
   Color color;
   Point* points;
}
