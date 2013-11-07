function [schedule_maximal_worst, worst_count] = get_worst_maximal(...
    traffic, maximal_schedule_matrix, speed_up, frame_size,...
    maximal_num_iterations)
%GET_WORST_MAXIMAL Get the worst case maximal schedule
%
%   [SCHEDULE_MAXIMAL_WORST, WORST_COUNT] = GET_WORST_MAXIMAL(TRAFFIC,
%   MAXIMAL_SCHEDULE_MATRIX, SPEED_UP, FRAME_SIZE, MAXIMAL_NUM_ITERATIONS)
%   returns the worst case maximal schedule for given traffic pattern
%   TRAFFIC, maximal schedule matrix MAXIMAL_SCHEDULE_MATRIX, speed-up
%   SPEED_UP, frame size FRAME_SIZE, and maximum iteration number
%   MAXIMAL_NUM_ITERATIONS. NUM_PACKETS is the number of packets scheduled.

network_size = length(traffic); % network size
worst_count = speed_up*network_size*frame_size+1;
    % worst case count initialized to upper bound of number of packets
    % scheduled
schedule_maximal_worst = cell(1, network_size);
    % worst case schedule initialized
for I = 1:maximal_num_iterations
    schedule_maximal = maximal_with_speed_up(traffic, frame_size,...
        speed_up, maximal_schedule_matrix);
        % a random maximal schedule with speed-up
    schedule_maximal_count = cellsum(schedule_maximal);
        % number of scheduled links
    if schedule_maximal_count < worst_count % record broken
        schedule_maximal_worst = schedule_maximal;
        worst_count = schedule_maximal_count;
    end
end
