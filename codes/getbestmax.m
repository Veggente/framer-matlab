function [sopt, nopt] = getbestmax(J, M, F, Imax)
%GETBESTEDF Get the best maximal schedule
%
%   [SOPT, NOPT] = GETBESTMAX(J, M, F, IMAX) returns the best case maximal
%   schedule for given traffic pattern J, maximal schedule matrix M, frame
%   size F, and maximum iteration number IMAX. SOPT is the returned
%   schedule and NOPT is the number of packets scheduled.

Knet = length(J); % network size
maxbestcount = 0; % best case count initialized to lower bound of
                  % # of packets scheduled
smaxbest = cell(1, Knet); % best case schedule initialized
for I = 1:Imax
    s = maximal(J, F, Knet, M); % a random maximal schedule
    smaxcount = cellsum(s); % # of scheduled links
    if smaxcount > maxbestcount % record broken
        smaxbest = s;
        maxbestcount = smaxcount;
    end
end
sopt = smaxbest; % optimal schedule
nopt = maxbestcount;
