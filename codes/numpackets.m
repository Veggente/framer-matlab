function y = numpackets(x)
%NUMPACKETS Number of packets in a traffic pattern
%
%   Y = NUMPACKETS(X) returns the number of packets in a traffic pattern.

K = length(x); % size of network
y = 0; % init
for I = 1:K
    y = y+size(x{I}, 1);
end
