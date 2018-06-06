function [s] = swap(s, a, b)

c = in(a);
s(a) = s(b);
s(b) = c;