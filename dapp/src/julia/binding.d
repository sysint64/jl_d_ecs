module julia.binding;

extern (C) {
   enum JL_DATA_TYPE;
   enum HT_N_INLINE = 32;
   enum AL_N_INLINE = 29;

   alias uint64_t = ulong;
   alias uint32_t = uint;
   alias uint8_t = ubyte;

   alias int64_t = long;
   alias int32_t = int;
   alias int8_t = byte;

   struct jl_value_t;
   alias jl_function_t = jl_value_t;

   struct htable_t {
       size_t size;
       void** table;
       void*[HT_N_INLINE] _space;
   }

   struct arraylist_t {
       size_t len;
       size_t max;
       void** items;
       void*[AL_N_INLINE] _space;
   }

   @JL_DATA_TYPE
   struct jl_sym_t {
      jl_sym_t* left;
      jl_sym_t* right;
      void* hash;
   }

   @JL_DATA_TYPE
   struct jl_module_t {
      jl_sym_t* name;
      jl_module_t* parent;
      htable_t bindings;
      arraylist_t usings;  // modules with all bindings potentially imported
      uint64_t uuid;
      size_t primary_world;
      uint32_t counter;
      uint8_t istopmod;
   }

   void jl_init();
   void jl_atexit_hook(int status);
   jl_value_t* jl_eval_string(const char* str);

   jl_function_t* jl_get_function(jl_module_t* m, const char* name) {
      return jl_get_global(m, jl_symbol(name));
   }

   jl_value_t* jl_get_global(jl_module_t* m, jl_sym_t* var);
   jl_sym_t* jl_symbol(const char* str);
   jl_value_t* jl_box_float64(double x);
   double jl_unbox_float64(jl_value_t* v);

   jl_value_t* jl_call(jl_function_t* f, jl_value_t** args, int32_t nargs);
   jl_value_t* jl_call0(jl_function_t* f);
   jl_value_t* jl_call1(jl_function_t* f, jl_value_t* a);
   jl_value_t* jl_call2(jl_function_t* f, jl_value_t* a, jl_value_t* b);
   jl_value_t* jl_call3(jl_function_t* f, jl_value_t* a, jl_value_t* b, jl_value_t* c);

   // modules and global variables
   extern __gshared jl_module_t* jl_main_module;
   extern __gshared jl_module_t* jl_internal_main_module;
   extern __gshared jl_module_t* jl_core_module;
   extern __gshared jl_module_t* jl_base_module;
   extern __gshared jl_module_t* jl_top_module;
}
