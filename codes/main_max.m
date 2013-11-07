% MC-MR MAX: a worst case scan for frame-based traffic
clear all; clc;

frame_size = 3; % frame size
network_size = 9;
maximal_schedule_matrix = zeros(network_size, 1); % nine grid
maximal_arrival = frame_size; % maximum packet number
seed = rng('shuffle'); % shuffle rng seed based on time
maximal_iteration_num = 60; % maximum iteration
maximal_traffic_num = 400; % number of traffic patterns
interference_degree = 4;
maximum_independent_set_size = 5;
network = 'nine-grid'; % network topology

% read current ratio-speedup-diagram
rsd = ones(1, maximum_independent_set_size-1); % rsd initialized to an
                                               % upper bound
data_directory = ['../rsd/', network, '/'];
rsdfile = [data_directory, 'rsd.txt']; % rsd filename
if ~(exist(rsdfile, 'file') == 2)
    dlmwrite(rsdfile, rsd);
else
    rsd = dlmread(rsdfile);
end

for speed_up = 1:maximum_independent_set_size-1
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
