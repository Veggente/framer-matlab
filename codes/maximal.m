function s = maximal(J, F, Knet, M)
%MAXIMAL Random maximal scheduling
%
%   S = MAXIMAL(J, F, KNET, M) returns a random maximal schedule for
%   traffic pattern J and frame size F. KNET is the size of the network and
%   M is the maximal schedule matrix. Ties are broken uniformly randomly
%   among links.

s = cell(1, Knet);
for I = 1:Knet
    s{I} = zeros(size(J{I})); % init
end
for I = 1:F
    if (cellsum(J) == 0) % traffic is empty
        return
    end
    Q = zeros(Knet, 1); % availability
    Imin = zeros(Knet, 1); % index for available links
    for L = 1:Knet
        if ~isempty(J{L})
            available = J{L}(:, I);
            availableindex = find(available ~= 0);
            if ~isempty(availableindex) % exist available packets
                Q(L) = 1; % make all queues one
                Imin(L) = availableindex(randi(length(availableindex)));
                    % record the index
                J{L}(:, I) = zeros(size(J{L}(:, I)));
                    % erase sub time slot I
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
            J{slqfindex(L)}(IminL, :) = zeros(1, F); % packet erased
        end
    end
end
