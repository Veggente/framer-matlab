% MC-MR EPDF: a worst case scan
clear all; clc;

frame_size = 2; % frame size
speed_up = 2; % speed-up/# of channels
network_size = 6; % six grid
maximal_schedule_matrix = [
        1 1 0 0;
        0 0 1 0;
        1 0 0 1;
        0 1 1 0;
        1 0 0 0;
        0 0 1 1]; %TODO: general network generator
maximal_arrival = 4; % maximum packet number
s = rng; % fix rng seed
maximal_iteration_num = 50; % maximum iteration
maximal_traffic_num = 100; % number of traffic patterns

best_distance_to_opt = maximal_arrival*network_size; % initial distance
best_traffic_to_opt = cell(1, network_size);
best_distance_to_hybrid = maximal_arrival*network_size;
best_traffic_to_hybrid = cell(1, network_size);
best_edf_for_opt = cell(1, network_size);
best_opt = cell(1, network_size);
best_edf_for_hybrid = cell(1, network_size);
best_hybrid = cell(1, network_size);
speed_up_indicator = [0, 1];

for L = 1:maximal_traffic_num

    % Generate random traffic pattern
    J = gentraffic(network_size, frame_size, maximal_arrival);
    
    % Get (worst) EDF schedule
    [sedf, nedf] = getworstedf(J, maximal_schedule_matrix, speed_up,...
        frame_size, maximal_iteration_num);
    
    % Get (best) maximal schedule
    [sopt, nopt] = getbestmax(J, maximal_schedule_matrix, frame_size,...
        maximal_iteration_num);
    
    % Get (best) hybrid schedule
    [shyb, nhyb] = get_best_hybrid(J, maximal_schedule_matrix, speed_up,...
        speed_up_indicator, frame_size, maximal_iteration_num);
    
    new_distance_to_opt = nedf-nopt; % new difference of EDF and OPT
    new_distance_to_hybrid = nedf-nhyb; % new difference of EDF and HYBRID
    if new_distance_to_opt < best_distance_to_opt
        best_distance_to_opt = new_distance_to_opt;
        best_traffic_to_opt = J;
        best_edf_for_opt = sedf;
        best_opt = sopt;
        if best_distance_to_opt < 0
            disp('WE GOT A WINNER FOR OPT!')
        end
    end
    if new_distance_to_hybrid < best_distance_to_hybrid
        best_distance_to_hybrid = new_distance_to_hybrid;
        best_traffic_to_hybrid = J;
        best_edf_for_hybrid = sedf;
        best_hybrid = shyb;
        if best_distance_to_hybrid < 0
            disp('WE GOT A WINNER FOR HYBRID!')
        end
    end
end
disp('The best traffic is');
celldisp(best_traffic_to_opt);
disp('The best worst-case EDF schedule is');
celldisp(best_edf_for_opt);
disp('The best optimal schedule is');
celldisp(best_opt);
disp('The total number of arriving packets is');
disp(numpackets(best_traffic_to_opt));
disp('The number of packets scheduled by EDF is');
disp(cellsum(best_edf_for_opt));
disp('The number of packets scheduled by OPT is');
disp(cellsum(best_opt));
disp('The best difference between EDF(k) and OPT is');
disp(best_distance_to_opt);

% disp('The best traffic is');
% celldisp(best_traffic_to_hybrid);
% disp('The best worst-case EDF schedule is');
% celldisp(best_edf_for_hybrid);
% disp('The best worst-case HYBRID schedule is')
% celldisp(best_hybrid)
% disp(['In the above worst case, EDF schedules ',...
%     num2str(cellsum(best_edf_for_hybrid)),...
%     ' packets, while HYBRID schedules ',...
%     num2str(cellsum(best_hybrid)), ' packets']);
