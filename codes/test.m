% test
clear all; clc;

% Testing GENTRAFFIC (passed)
% rng(0);
% disp('A five-pattern for a network of four links, w/ max packets 5:')
% J1 = gentraffic(4, 5, 5);
% celldisp(J1);
% disp('A three-pattern for a network of five links, w/ max packets 2:')
% J2 = gentraffic(5, 3, 2);
% celldisp(J2);

% Testing LEAN (passed)
% rng(2);
% disp('A fat schedule is given by:')
% J3 = gentraffic(10, 9, 4);
% celldisp(J3);
% J4 = lean(J3, 3, 3);
% disp('The lean format is:')
% celldisp(J4);

% Testing CELLSUM (passed)
% rng(0);
% disp('A cell of matrices is:')
% J5 = gentraffic(3, 2, 5);
% celldisp(J5);
% disp('The total sum is')
% disp(cellsum(J5));

% Testing FATTEN (passed)
% rng(0);
% disp('A cell of matrices is:');
% J6 = gentraffic(3, 4, 2);
% celldisp(J6);
% disp('The fat version is:');
% J7 = fatten(J6, 3);
% celldisp(J7);

% Testing LQF (passed)
% Q = [-1 -3 -4 -2 -5];
% IG = [1 1 0 0 0;
%       1 1 1 0 0;
%       0 1 1 1 0;
%       0 0 1 1 1;
%       0 0 0 1 1];
% slqf = lqf(IG, Q);
% disp('The queues are')
% disp(Q)
% disp('The LQF schedule gives')
% disp(slqf')

% Testing EDF (passed)
% rng(0)
% J8 = gentraffic(5, 3, 10);
% disp('Traffic:')
% celldisp(J8);
% M = [   1 1 0 0;
%         0 0 1 1;
%         1 0 0 0;
%         0 1 1 0;
%         1 0 0 1];
% s = edf(J8, 3, 2, 5, M);
% disp('EDF schedule is')
% celldisp(s);

% Testing GETWORSTEDF (passed)
% rng(0);
% F = 7;
% Amax = 14;
% k = 2;
% Imax = 50;
% J = gentraffic (5, F, Amax);
% % disp('Traffic:');
% % celldisp(J);
% disp('The total number of arriving packets is');
% disp(cellsum(J));
% M = [1 1 0 0;
%      0 0 1 1;
%      1 0 0 0;
%      0 1 1 0;
%      1 0 0 1];
% [s,n] = getworstedf(J, M, k, F, Imax);
% % disp('The worst EDF schedule is:')
% % celldisp(s);
% disp('The total number of packets scheduled by the worst case is');
% disp(n);
% [sb, nb] = getbestedf(J, M, k, F, Imax);
% % disp('The best EDF schedule is:')
% % celldisp(sb);
% disp('The total number of packets scheduledby the best case is');
% disp(nb);

% Testing MAXIMAL (passed)
% F = 5;
% J = gentraffic(5, F, 5);
% disp('The traffic is');
% celldisp(J);
% M = [   1 1 0 0;
%         0 0 1 1;
%         1 0 0 0;
%         0 1 1 0;
%         1 0 0 1];
% s = maximal(J, F, 5, M);
% disp('A maximal schedule is');
% celldisp(s);

% Testing GETBESTMAX (passed)
% F = 5;
% J = cell(1, F); % traffic pattern
% J{1} = [1 1 1 1 1;
%         1 1 1 1 0;
%         1 1 1 0 0;
%         1 1 0 0 0;
%         1 0 0 0 0];
% disp('The traffic is');
% celldisp(J);
% M = [   1 1 0 0;
%         0 0 1 1;
%         1 0 0 0;
%         0 1 1 0;
%         1 0 0 1];
% sopt = getbestmax(J, M, F, 2);
% disp('The optimal schedule is')
% celldisp(sopt);
% disp('The total number of scheduled packets is')
% disp(cellsum(sopt));

% Testing fatten_first (passed)
% J = gentraffic(5, 3, 10);
% disp('The traffic is: ')
% celldisp(J);
% Jfat_first = fatten_first(J, 3);
% disp('The traffic with fatter first column is: ');
% celldisp(Jfat_first);

% Testing hybrid (passed)
% rng(0);
% network_size = 6;
% maximal_schedule_matrix = zeros(1);
% frame_size = 5;
% maximal_arrival = 5;
% J = gentraffic(network_size, frame_size, maximal_arrival);
% disp('The traffic is:')
% celldisp(J)
% rng(18);
% speed_up = 2;
% speed_up_indicator = [1, 1, 0, 0, 0];
% schedule_hybrid = hybrid(J, frame_size, speed_up, speed_up_indicator,...
%     network_size, maximal_schedule_matrix);
% disp('The (2, 1) hybrid schedule is:')
% celldisp(schedule_hybrid);
% disp(schedule_hybrid{1})

% Testing get_best_hybrid (passed)
% rng(1);
% network_size = 6;
% maximal_schedule_matrix = zeros(1);
% frame_size = 5;
% maximal_arrival = 5;
% J = gentraffic(network_size, frame_size, maximal_arrival);
% disp('The traffic is:')
% celldisp(J)
% speed_up = 2;
% speed_up_indicator = [0, 0, 0, 1, 1];
% maximal_num_iterations = 100;
% [best_hybrid_schedule, num_packets] = get_best_hybrid(J,...
%     maximal_schedule_matrix, speed_up, speed_up_indicator, frame_size,...
%     maximal_num_iterations);
% disp('The best hybrid schedule is:');
% celldisp(best_hybrid_schedule);
% disp('The number of scheduled packets is:')
% disp(num_packets)
% disp('Recall that the total packet number is:')
% disp(numpackets(J));

% Testing get_worst_maximal (passed)
% rng('shuffle');
% network_size = 6;
% maximal_schedule_matrix = [
%         1 1 0 0;
%         0 0 1 0;
%         1 0 0 1;
%         0 1 1 0;
%         1 0 0 0;
%         0 0 1 1]; % six grid
% frame_size = 2;
% maximal_arrival = 1;
% traffic = gentraffic(network_size, frame_size, maximal_arrival);
% disp('The traffic is');
% celldisp(traffic);
% speed_up = 2;
% maximal_num_iterations = 100;
% [worst_maximal_schedule_with_speed_up, worst_count_with_speed_up] =...
%     get_worst_maximal(traffic, maximal_schedule_matrix, speed_up,...
%     frame_size, maximal_num_iterations);
% [best_maximal_schedule, best_count] = getbestmax(traffic,...
%     maximal_schedule_matrix, frame_size, maximal_num_iterations);
% disp(['The worst maximal schedule with speed-up ', num2str(speed_up),...
%     ' is']);
% celldisp(worst_maximal_schedule_with_speed_up);
% disp(['The best maximal schedule without speed-up is']);
% celldisp(best_maximal_schedule);
% disp('The number of scheduled packets with speed-up is')
% disp(worst_count_with_speed_up);
% disp('The number of scheduled packets without speed-up is')
% disp(best_count);
% disp('The total number of packets is')
% disp(numpackets(traffic));

% Testing ratio_speedup_diagram_for_maximal (passed)
% rng('shuffle');
% network_size = 6;
% maximal_schedule_matrix = [
%         1 1 0 0;
%         0 0 1 0;
%         1 0 0 1;
%         0 1 1 0;
%         1 0 0 0;
%         0 0 1 1]; % six grid
% frame_size = 2;
% speed_up = 1;
% maximal_num_iterations_traffic = 1000;
% maximal_num_iterations_schedule = 100;
% [t, w, b, r] = ratio_speedup_diagram_for_maximal(...
%     maximal_schedule_matrix, speed_up, frame_size,...
%     maximal_num_iterations_traffic, maximal_num_iterations_schedule);
% disp(['RSD(', num2str(speed_up), ') = ']);
% disp(r);
