%8
function [B] = normalize_rows(A)
    B=((A')./sum(A'))';
end