module data_layout;

import ecs.components;
import julia.components;

struct Data {
   Figure* figureComponents;
   Position* positionComponents;
   Velocity* velocityComponents;
}
