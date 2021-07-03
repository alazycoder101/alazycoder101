#include "ruby.h"
#include "extconf.h"

VALUE rb_return_nil() {
  return Qnil;
}

void rb_print_hello() {
  printf("hello");
}

VALUE create_hash() {
  VALUE hash = rb_hash_new();
  rb_hash_aset(hash, rb_str_new2("test"), INT2FIX(1));
  return hash;
}

void Init_first() {
  VALUE mod = rb_define_module("RubyGuides");
  rb_define_method(mod, "return_nil", rb_return_nil, 0);
  rb_define_method(mod, "print_hello", rb_print_hello, 0);
}
