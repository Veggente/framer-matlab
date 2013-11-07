function [worst_traffic, worst_schedule_with_speed_up,...
    best_schedule_without_speed_up, ratio] =...
    ratio_speedup_diagram_for_maximal(maximal_schedule_matrix, speed_up,...
    frame_size, max_num_iterations_traffic, max_num_iterations_schedule)
%RATIO_SPEEDUP_DIAGRAM Estimate the ratio-speedup-diagram
%
%   [WORST_TRAFFIC, WORST_SCHEDULE_WITH_SPEED_UP,
%   BEST_SCHEDULE_WITHOUT_SPEED_UP, RATIO] =
%   RATIO_SPEEDUP_DIAGRAM_FOR_MAXIMAL(MAXIMAL_SCHEDULE_MATRIX, SPEED_UP,
%   FRAME_SIZE, MAX_NUM_ITERATIONS_TRAFFIC, MAX_NUM_ITERATIONS_SCHEDULE)
%   scans and returns the worst traffic for maximal scheduling with
%   speed-up SPEED_UP, for network with maximal schedule matrix
%   MAXIMAL_SCHEDULE_MATRIX and frame size FRAME_SIZE with maximum number
%   of traffic iterations MAX_NUM_ITERATIONS_TRAFFIC and maximum number of
%   schedule iterations MAX_NUM_ITERATIONS_SCHEDULE. The maximal number of
%   arrivals in each time slot is assumed to be equal to FRAME_SIZE.

network_size = size(maximal_schedule_matrix, 1);
maximum_arrival = frame_size; % assume the maximum number of arrivals in
                              % each time slot is equal to the frame size
worst_traffic = cell(1, network_size);
worst_schedule_with_speed_up = cell(1, network_size);
best_schedule_without_speed_up = cell(1, network_size);
ratio = speed_up+1; % worst-case ratio initialized to an upper bound
for I = 1:max_num_iterations_traffic
    traffic = gentraffic(network_size, frame_size, maximum_arrival);
    [schedule_sped_up, count_sped_up] = get_worst_maximal(traffic,...
        maximal_schedule_matrix, speed_up, frame_size,...
        max_num_iterations_schedule);
    [schedule_not_sped_up, count_not_sped_up] = getbestmax(traffic,...
        maximal_schedule_matrix, frame_size, max_num_iterations_schedule);
    current_ratio = count_sped_up/count_not_sped_up;
    if current_ratio < ratio
        ratio = current_ratio;
        worst_traffic = traffic;
        worst_schedule_with_speed_up = schedule_sped_up;
        best_schedule_without_speed_up = schedule_not_sped_up;
    end
end
