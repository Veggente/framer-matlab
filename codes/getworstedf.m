function [sedflean, numpackets] = getworstedf(J, M, k, F, Imax)
%GETWORSTEDF Get the worst case EDF schedule
%
%   [SEDFLEAN, NUMPACKETS] = GETWORSTEDF(J, M, K, F, IMAX) returns the
%   worst case EDF schedule in lean format for given traffic pattern J,
%   maximal schedule matrix M, speedup K, frame size F, and maximum
%   iteration number IMAX. Lean format means the K speedup sub-time slots
%   are combined into one time slot in the representation of schedule.
%   NUMPACKETS is the number of packets scheduled.

Knet = length(J); % network size
edfworstcount = k*Knet*F; % worst case count initialized to upper bound of
                          % # of packets scheduled
sedfworst = cell(1, Knet); % worst case schedule initialized
for I = 1:Imax
    sedf = edf(J, F, k, Knet, M); % a random edf schedule
    sedfcount = cellsum(sedf); % # of scheduled links
    if sedfcount < edfworstcount % record broken
        sedfworst = sedf;
        edfworstcount = sedfcount;
    end
end
sedflean = lean(sedfworst, k, F); % worst case schedule in lean format
numpackets = edfworstcount;

