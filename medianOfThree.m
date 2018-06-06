function [out] = medianOfThree(in)
out = in;
last = size(in, 2);
mid = floor(last/2);

if(out(1) > out(last))
    out = swap(out, 1, last);
end

if(out(mid) > out(last))
    out = swap(out, mid, last);
end

if(out(1) > out(mid))
    out = swap(out, 1, mid);
end

out = swap(out, 1, mid);

out(1)
out(mid)
out(end)