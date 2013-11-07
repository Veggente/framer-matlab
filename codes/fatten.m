function y = fatten(x, k)
%FATTEN Make availability matrix k times fatter
%
%   Y = FATTEN(X, K) returns a K-times fat version of X.

y = cell(size(x));
for I = 1:length(x)
    if ~isempty(x{I})
        y{I} = kron(x{I}, ones(1, k));
    end
end
