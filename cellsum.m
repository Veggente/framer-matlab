function x = cellsum(s)
%CELLSUM Calculate the sum of all elements of the cells
%
%   X = CELLSUM(S) returns the sum of all elements of the cells in S. S
%   must be a vector of cells.

K = length(s); % length
x = 0;
for I = 1:K
    if ~isempty(s{I})
        x = x+sum(sum(s{I}));
    end
end
