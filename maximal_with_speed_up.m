function [schedule, num_packets] = maximal_with_speed_up(traffic,...
    frame_size, speed_up, maximal_schedule_matrix)
%MAXIMAL_WITH_SPEED_UP Random maximal scheduling with speed-up
%
%   [SCHEDULE, NUM_PACKETS] = MAXIMAL_WITH_SPEED_UP(TRAFFIC, FRAME_SIZE,
%   SPEED_UP, MAXIMAL_SCHEDULE_MATRIX) returns a random maximal schedule
%   with speed-up SPEED_UP for traffic pattern TRAFFIC_PATTERN and frame
%   size FRAME_SIZE. MAXIMAL_SCHEDULE_MATRIX is the maximal schedule
%   matrix. Ties are broken uniformly randomly among links.

network_size = length(traffic); % network size
traffic_fat = fatten(traffic, speed_up); % make the traffic *speed_up*
                                         % times fatter
schedule = maximal(traffic_fat, frame_size*speed_up, network_size,...
    maximal_schedule_matrix);
num_packets = cellsum(schedule);
