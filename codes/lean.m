function sl = lean(s, k, F)
%LEAN Get the lean format of schedule
%
%   SL = LEAN(S, K, F) returns the lean format of schedule S for speedup K
%   and frame size F.
Knet = length(s); % network size
sl = cell(1, Knet);
for I = 1:Knet
    if ~isempty(s{I}) % if s is not empty
        for J = 1:F
            sl{I}(:, J) = sum(s{I}(:, k*(J-1)+1:k*J), 2); % sum each k 
                                                          % columns up
        end
    end
end

