function [schedule_hybrid, num_packets] = get_best_hybrid(traffic,...
    maximal_schedule_matrix, speed_up, speed_up_indicator, frame_size,...
    maximal_num_iterations)
%GET_BEST_HYBRID Get the best case hybrid schedule
%
%   [SCHEDULE_HYBRID, NUM_PACKETS] = GET_BEST_HYBRID(TRAFFIC,
%   MAXIMAL_SCHEDULE_MATRIX, SPEED_UP, SPEED_UP_INDICATOR, FRAME_SIZE,
%   MAXIMAL_NUM_ITERATIONS) returns the best case hybrid schedule for given
%   traffic pattern TRAFFIC, maximal schedule matrix
%   MAXIMAL_SCHEDULE_MATRIX, speed-up SPEED_UP, speed-up indicator sequence
%   SPEED_UP_INDICATOR, frame size FRAME_SIZE, and maximum iteration number
%   MAXIMAL_NUM_ITERATIONS. NUM_PACKETS is the number of packets scheduled.

network_size = length(traffic); % network size
best_count = 0; % best case count initialized to lower bound of
                % number of packets scheduled
schedule_hybrid_best = cell(1, network_size);
    % best case schedule initialized
for I = 1:maximal_num_iterations
    schedule = hybrid(traffic, frame_size, speed_up,...
        speed_up_indicator, network_size, maximal_schedule_matrix);
        % a random hybrid schedule
    schedule_hybrid_count = cellsum(schedule);
        % number of scheduled links
    if schedule_hybrid_count > best_count % record broken
        schedule_hybrid_best = schedule;
        best_count = schedule_hybrid_count;
    end
end
schedule_hybrid = schedule_hybrid_best; % best case schedule
num_packets = best_count;
