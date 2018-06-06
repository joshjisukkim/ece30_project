function [out] = partition(in, left, right, pivot)

if left >= right
    out = left;
    return
end



if in(left) > pivot
    right = right - 1;
    in = swap(in, left, right);
    out = partition(in, left, right, pivot);
else
    left = left + 1;
    out = partition(in, left, right, pivot);
end