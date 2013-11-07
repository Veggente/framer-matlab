function M = lqf(IG, Q)
%LQF    Longest-queue-first scheduling for interference graph with random
%tiebreaker.
%
%   M = LQF(IG,Q)
%   IG is the n-by-n interference graph with entries either 0 or 1, where
%   the (i, j) entry is 0 if link i does not interfere with link j, and 1
%   if link i does interfere with link j.
%   Q is the n-by-1 queue length vector.
%   M is the n-by-1 scheduling matching, where M(i) is 1 if link i is
%   scheduled and 0 if link i is not scheduled.

n = length(Q); % number of links

%% input size checking
if (size(IG, 1) ~= n) || (size(IG, 2) ~= n)
    fprintf('Sizes of interference graph and queues do not match!\n\r')
    return
end
% need to check the symmetry of IG
if ~isequal(IG, IG.')
    fprintf('Interference graph is not symmetric!\n\r')
    return
end

%% sort queues with random tiebreaker
rp = randperm(n); % take a random permutation of the sequence (1, 2, ..., n)
[B, IX] = sort(Q(rp), 'descend'); % sort the reordered queues
s = rp(IX); % s is the sorted queue indices

%% find LQF matchings
M = zeros(n, 1); % initialize output
IV = zeros(n, 1); % interference vector to be maintained
for I = 1:n
    if IV(s(I)) == 0 % if link s(I) does not interfering with selected links
        M(s(I)) = 1; % set link s(I)
        IV = IV | IG(:, s(I)); % update interference vector
    end
end
