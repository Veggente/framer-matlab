function s = hybrid(traffic, frame_size, speed_up, speed_up_indicator,...
    network_size, maximal_schedule_matrix)
%HYBRID EDF-maximal hybrid scheduling
%
%   S = HYBRID(TRAFFIC, FRAME_SIZE, SPEED_UP, SPEED_UP_INDICATOR,
%   NETWORK_SIZE, MAXIMAL_SCHEDULE_MATRIX) return an edf-maximal-hybrid
%   schedule given the traffic TRAFFIC, frame size FRAME_SIZE, speed up
%   SPEED_UP, speed-up indicator sequence SPEED_UP_INDICATOR, network size
%   NETWORK_SIZE, and the maximal schedule matrix MAXIMAL_SCHEDULE_MATRIX.
%   The traffic is in cell format. The speed-up indicator sequence
%   indicates whether one time slot employs speed-up or not. The columns of
%   the maximal schedule matrix are the possible maximal schedules.

%TODO: check the input format

s = cell(1, network_size);
if (cellsum(traffic) == 0) % traffic is empty
    return
end
for I = 1:network_size
    s{I} = zeros(size(traffic{I})); % init
end
working_traffic = traffic; % working traffic for current time slot
interference_graph = getsymintgraph(maximal_schedule_matrix);
for time_slot = 1:frame_size
    if speed_up_indicator(time_slot) % speed-up is on in current time slot
        % use EDF
        % fatten traffic
        working_traffic = fatten_first(working_traffic, speed_up);
        
        for sub_time_slot = 1:speed_up
            % get deadlines
            earliest_deadlines = zeros(network_size, 1);
            earliest_deadline_indices = zeros(network_size, 1);
            working_frame_size_edf = frame_size+speed_up-time_slot...
                -sub_time_slot+1;
            for I = 1:network_size
                if ~isempty(working_traffic{I})
                    available = working_traffic{I}(:, 1);
                    available_index = find(available ~= 0);
                    if ~isempty(available_index) % exist available packets
                        all_delays = sum(working_traffic{I}, 2);
                            % all remaining packet delays
                        available_delays = all_delays(available_index);
                            % available delays
                        [min_delay, min_delay_index] = ...
                            min(available_delays);
                            % min delay and its index
                        earliest_deadlines(I) = working_frame_size_edf+...
                            1-min_delay; % earlier deadline, higher value
                        earliest_deadline_indices(I) = available_index(...
                            min_delay_index); % record the index
                    end % otherwise deadline is zero and Imin is zero
                end
            end
            
            % use lqf on deadlines
            schedule_edf = lqf(interference_graph, earliest_deadlines);
            
            % update hybrid schedule and working traffic
            for I = 1:network_size
                if (schedule_edf(I) ~= 0) &&...
                        (earliest_deadline_indices(I) ~= 0)
                        % scheduled and available
                    s{I}(earliest_deadline_indices(I), time_slot) = 1;
                        % set the schedule in s
                    working_traffic{I}(earliest_deadline_indices(I), :)...
                        = zeros(1, working_frame_size_edf);
                        % erase packet
                end
                working_traffic{I} = working_traffic{I}(:, 2:end);
                    % erase current sub-time-slot
            end
        end
    else % speed-up is off in current time slot
        % use maximal
        % get queues
        queues = zeros(network_size, 1);
        queue_indices = zeros(network_size, 1);
        working_frame_size_maximal = frame_size-time_slot+1;
        for I = 1:network_size
            if ~isempty(working_traffic{I})
                available = working_traffic{I}(:, 1);
                available_index = find(available ~= 0);
                if ~isempty(available_index)
                    queues(I) = 1;
                    queue_indices(I) =...
                        available_index(randi(length(available_index)));
                end
            end
        end

        % use lqf on available links
        schedule_maximal = lqf(interference_graph, queues);
        
        % update hybrid schedule and working traffic
        for I = 1:network_size
            if (schedule_maximal(I) ~= 0) &&...
                    (queue_indices(I) ~= 0)
                    % scheduled and available
                s{I}(queue_indices(I), time_slot) = 1;
                    % set the schedule in s
                working_traffic{I}(queue_indices(I), :)...
                    = zeros(1, working_frame_size_maximal);
                    % erase packet
            end
            working_traffic{I} = working_traffic{I}(:, 2:end);
                % erase current sub-time-slot
        end
    end
end
