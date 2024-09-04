require 'tracer'
Tracer.on
def a; end
def b; a; end
def c; b; end
c
Tracer.off
