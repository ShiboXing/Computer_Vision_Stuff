%9
function [B]=normalize_columns(A)
    B=A./sum(A);
end