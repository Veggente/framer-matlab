function J = gentraffic(K, F, Amax)
%GENTRAFFIC Generate random traffic pattern
%
%   J = GENTRAFFIC(K, F, AMAX) returns the generated traffic pattern for
%   network size K, frame size F and maximum packet number AMAX. The return
%   value J is a 1xF cell, and J{I} is the availability matrix of packets
%   on link I.

J = cell(1, K);
for I = 1:K
    numpacket = randi(Amax+1)-1; % number of packets could be 0, 1, 2, ...,
                                 % Amax
    for L = 1:numpacket
        ra = randi(F);
        rb = randi(F); % two random integer from 1, 2, ..., F
        dob = min(ra, rb); % date of birth
        deadline = max(ra, rb); % deadline
        J{I}(L, :) = [zeros(1, dob-1), ones(1, deadline-dob+1), zeros(1,...
            F-deadline)]; % 0 denotes unavailable, 1 available
    end
end
