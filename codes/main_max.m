% MC-MR MAX: a worst case scan for frame-based traffic
clear all; clc;

frame_size = 3; % frame size
network_size = 9;
maximal_schedule_matrix = [ % nine grid
        1 1 0 0;
        0 0 1 0;
        1 0 0 1;
        0 1 1 0;
        1 0 0 0;
        0 0 1 1];
maximal_arrival = frame_size; % maximum packet number
seed = rng('shuffle'); % shuffle rng seed based on time
maximal_iteration_num = 30; % maximum iteration
maximal_traffic_num = 50; % number of traffic patterns
interference_degree = 3;
maximum_independent_set_size = 3;
network = 'six-grid'; % network topology

% read current ratio-speedup-diagram
rsd = ones(1, interference_degree); % rsd initialized to an upper bound
data_directory = ['../rsd/', network, '/'];
rsdfile = [data_directory, 'rsd.txt']; % rsd filename
if ~(exist(rsdfile, 'file') == 2)
    dlmwrite(rsdfile, rsd);
else
    rsd = dlmread(rsdfile);
end

for speed_up = 1:min(interference_degree, maximum_independent_set_size-1)
    [worst_traffic, worst_max, best_max, ratio] =...
        ratio_speedup_diagram_for_maximal(maximal_schedule_matrix,...
        speed_up, frame_size, maximal_traffic_num, maximal_iteration_num);
    if ratio < rsd(speed_up)
        rsd(speed_up) = ratio;
        save([data_directory, 'record', num2str(speed_up), '.mat'],...
            'worst_traffic', 'worst_max', 'best_max');
    end
end
dlmwrite(rsdfile, rsd);

% inspect rsd
figure;
stem(rsd);
grid on;
