function s = edf(J, F, k, Knet, M)
%EDF Earliest deadline first scheduling
%
%   S = EDF(J, F, K, KNET, M) returns an earliest deadline first schedule
%   for traffic pattern J and frame size F with speedup K. KNET is the size
%   of the network and M is the maximal schedule matrix. Ties are broken
%   uniformly randomly among links.

Jfat = fatten(J, k); % Jfat is for k speedup
s = cell(1, Knet);
for I = 1:Knet
    s{I} = zeros(size(Jfat{I})); % init
end
for I = 1:k*F
    if (cellsum(Jfat) == 0) % traffic is empty
        return
    end
    Q = zeros(Knet, 1); % earliest deadlines
    Imin = zeros(Knet, 1); % index for earliest deadlines
    for L = 1:Knet
        if ~isempty(Jfat{L})
            available = Jfat{L}(:, I);
            availableindex = find(available ~= 0);
            if ~isempty(availableindex) % exist available packets
                alldelays = sum(Jfat{L}, 2); % all remaining packet delays
                availdelays = alldelays(availableindex); % available delays
                [mindelay, mindelayindex] = min(availdelays);
                    % min delay and its index
                Q(L) = F+1-ceil(mindelay/k); % make min delay max queue
                Imin(L) = availableindex(mindelayindex); % record the index
                Jfat{L}(:, I) = zeros(size(Jfat{L}(:, I))); % erase sub
                                                            % time slot I
            end % otherwise Q is zero and Imin is zero
        end
    end
    IG = getsymintgraph(M); %TODO: get the symmetric interference graph
                            % matrix
    slqf = lqf(IG, Q); % do LQF over Q
    slqfindex = find(slqf ~= 0); % find the index of schedule
    for L = 1:length(slqfindex)
        IminL = Imin(slqfindex(L)); % index for L
        if IminL ~= 0 % packet available/Q not empty
            s{slqfindex(L)}(IminL, I) = 1;
            Jfat{slqfindex(L)}(IminL, :) = zeros(1, k*F); % packet erased
        end
    end
end
