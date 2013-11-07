function [sedflean, numpackets] = getbestedf(J, M, k, F, Imax)
%GETBESTEDF Get the best case EDF schedule
%
%   [SEDFLEAN, NUMPACKETS] = GETBESTEDF(J, M, K, F, IMAX) returns the
%   best case EDF schedule in lean format for given traffic pattern J,
%   maximal schedule matrix M, speedup K, frame size F, and maximum
%   iteration number IMAX. Lean format means the K speedup sub-time slots
%   are combined into one time slot in the representation of schedule.
%   NUMPACKETS is the number of packets scheduled.

Knet = length(J); % network size
edfbestcount = 0; % best case count initialized to lower bound of
                   % # of packets scheduled
sedfbest = cell(1, Knet); % best case schedule initialized
for I = 1:Imax
    sedf = edf(J, F, k, Knet, M); % a random edf schedule
    sedfcount = cellsum(sedf); % # of scheduled links
    if sedfcount > edfbestcount % record broken
        sedfbest = sedf;
        edfbestcount = sedfcount;
    end
end
sedflean = lean(sedfbest, k, F); % best case schedule in lean format
numpackets = edfbestcount;
