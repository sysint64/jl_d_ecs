import std.stdio;

import std.file;
import std.path;

import julia.binding;
import julia.components;
import julia.nodes;

void main() {
    jl_init();
    jl_eval_string(import("sim.jl"));

    auto ret = jl_eval_string("sqrt(4.0)");
    auto ret_unboxed = jl_unbox_float64(ret);

    writeln("sqrt(4.0) = ", ret_unboxed);

    auto func = jl_get_function(jl_base_module, "sqrt");
    auto argument = jl_box_float64(2.0);
    auto ret2 = jl_call1(func, argument);

    writeln("sqrt(2.0) = ", jl_unbox_float64(ret2));

    auto entry_func = jl_get_function(jl_main_module, "greet");
    jl_call0(entry_func);

    auto constructPosition_func = jl_get_function(jl_main_module, "constructPosition");
    Position* p = cast(Position*) jl_call0(constructPosition_func);
    writeln((*p).x);
    writeln((*p).y);

    //

    auto constructMoveNode_func = jl_get_function(jl_main_module, "constructMoveNode");
    MoveNode* node = cast(MoveNode*) jl_call0(constructMoveNode_func);
    writeln((*(*node).position).x);
    writeln((*(*node).position).y);

    writeln((*(*node).velocity).dx);
    writeln((*(*node).velocity).dy);

    jl_atexit_hook(0);
}
