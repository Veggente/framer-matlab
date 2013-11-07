function y = fatten_first(x, k)
%FATTEN_FIRST Make the first column of availability matrix k times fatter
%
%   Y = FATTEN(X, K) returns the availability matrix with the first column
%   K times fatter.

y = cell(size(x));
for I = 1:length(x)
    if ~isempty(x{I})
        y{I} = [x{I}(:, 1)*ones(1, k), x{I}(:, 2:end)];
    end
end
