% MC-MR MAX: a worst case scan for frame-based traffic
clear all; clc;

frame_size = 3; % frame size
network_size = 6;
maximal_schedule_matrix = [ % six grid
        1 1 0 0;
        0 0 1 0;
        1 0 0 1;
        0 1 1 0;
        1 0 0 0;
        0 0 1 1];
maximal_arrival = frame_size; % maximum packet number
seed = rng('shuffle'); % fix rng seed
maximal_iteration_num = 3; % maximum iteration
maximal_traffic_num = 5; % number of traffic patterns
interference_degree = 2;

% read current ratio-speedup-diagram
rsd = ones(1, interference_degree); % rsd initialized to an upper bound
if ~(exist('rsd.txt', 'file') == 2)
    dlmwrite('rsd.txt', rsd);
else
    rsd = dlmread('rsd.txt');
end

for speed_up = 1:interference_degree
    [worst_traffic, worst_max, best_max, ratio] =...
        ratio_speedup_diagram_for_maximal(maximal_schedule_matrix,...
        speed_up, frame_size, maximal_traffic_num, maximal_iteration_num);
    if ratio < rsd(speed_up)
        rsd(speed_up) = ratio;
        save(['record', num2str(speed_up), '.mat'], 'worst_traffic', 'worst_max', 'best_max');
    end
end
dlmwrite('rsd.txt', rsd);

figure;
stem(rsd);
grid on;
