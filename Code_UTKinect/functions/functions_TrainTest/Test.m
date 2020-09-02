function [estimated_action_HMM, estimated_action_MOTION, estimated_action_TOTAL, HMM_confidence, estimatedMatrix_action_HMM, confidenceMatrix_action_HMM] = Test(test_person, u_norm_LDA, E, P, Pi, estimated_action_HMM, estimated_action_MOTION, estimated_action_TOTAL, HMM_confidence, mean_histogram_1D, estimatedMatrix_action_HMM, confidenceMatrix_action_HMM, Threshold)

global index_of_states;
global number_of_states;
global number_of_state_samples;
global state;
global name_of_states;
global name_of_actions;
global joints_selected;
global number_of_selected_joints;
global do_subtract_from_total_mean;
global display_projected_LDA_mode;
global LDA_projected_joints_of_specific_states;
global project_of_means_MODE;
global distance_type;
global const_cov;
global use_manual_mahalanobis;
global LDA_projected_state_means;
global projected_means_of_classes;
global LDA_projected_states;
global covariance_matrix;
global distance_average_of_averages;
global action_length;
global frame_step;
global number_of_actions;
global number_of_persons;
global number_of_samples;
global report_trained_states_mode;
global step_of_sliding;
global length_of_window;
global INITIAL_distance_factor_for_accepting_frame;
global STEP_distance_factor_for_accepting_frame;
global do_HMM_equal_sequence_numbers;
global report_estimated_states_mode;
global report_estimated_states_mode_ACTION; 
global display_projected_LDA_test_mode;
global confusion_matrix_action;
global error_action;
global acceptance_factor_HMM;
global omit_motion_part;
global pass_how_many_HMM_estimates_to_motion_section;
global report_estimates_in_HMM_and_motion;
global type_of_selecting_frames_for_HMM_input;
global joint_selection_mode;
global distance_average_of_averages_backup;

%%%% loop:
HMM_labels_test = cell(number_of_actions,1);  %%% preallocation - part 1
which_person = test_person;
for which_action = 1:number_of_actions
    number_of_performances = number_of_samples(which_person,which_action);
    for which_performance = 1:number_of_performances
        %%%% report estimated states:
        if report_estimated_states_mode == 1
            if which_action == report_estimated_states_mode_ACTION
                disp('=============================');
                str = sprintf('Actual Action: %s', name_of_actions{which_action});
                disp(str);
                str = sprintf('Test Person: %d', which_person);
                disp(str);
                str = sprintf('Performance: %d', which_performance);
                disp(str);
                disp('Estimated States:');
            end
        end
        %%%% finding distances:
        if type_of_selecting_frames_for_HMM_input == 0
            frames = 1:frame_step:action_length(which_person,which_performance,which_action);
        elseif type_of_selecting_frames_for_HMM_input == 1
            consider_first_frame_in_emptySequences = 1;
            key_frames = find_key_frames(which_person,which_performance,which_action,consider_first_frame_in_emptySequences);
            frames = key_frames;
        end
        for frame = frames
            if joint_selection_mode == 1
                %%%% load joints:
                joints = load_joints_and_align_them(which_person,which_performance,which_action,frame);
                %%%% projecting frame samples onto the Fisher LDA projection directions:
                if do_subtract_from_total_mean == 1
                    LDA_projected_joints = u_norm_LDA * reshape(joints - train_joints_total_mean,[],1);
                else
                    LDA_projected_joints = u_norm_LDA * reshape(joints,[],1);
                end
                %%%% distance between projected joints and classes:
                [estimated_class(frame), distance_estimated_class(frame), ~] = calculate_distance(LDA_projected_joints, LDA_projected_state_means, projected_means_of_classes, LDA_projected_states, covariance_matrix, const_cov, distance_type, use_manual_mahalanobis, number_of_states);
            elseif joint_selection_mode == 2 || joint_selection_mode == 3
                distance_average_of_averages = distance_average_of_averages_backup;
                [estimated_class(frame), distance_estimated_class(frame)] = project_on_Forest_Fishers(u_norm_LDA, which_person,which_performance,which_action,frame);
            end
        end
        %%%% window:
        counter_of_slidings = 1;
        finished_sliding_window = 0;
        last_accepted_frame_in_previous_window = -1;  %--> should not be considered in first window
        while ~finished_sliding_window
            index_first_of_window = (counter_of_slidings - 1)*step_of_sliding + 1;
            index_last_of_window = (counter_of_slidings - 1)*step_of_sliding + length_of_window;
            if index_last_of_window <= length(frames)
                frames_in_window = frames(index_first_of_window : index_last_of_window);
            else
                frames_in_window = frames(index_first_of_window : end);
                finished_sliding_window = 1;
            end
            if index_first_of_window > length(frames)
                break;
            end
            is_all_empty_in_window = 1;
            distance_factor_for_accepting_frame = INITIAL_distance_factor_for_accepting_frame;
            while is_all_empty_in_window
                for frame = frames_in_window
                    estimated_class_this_frame = estimated_class(frame);
                    distance_estimated_class_this_frame = distance_estimated_class(frame);
                    if distance_estimated_class_this_frame > distance_factor_for_accepting_frame + distance_average_of_averages
                        do_count_this_frame = 0;
                    else
                        if last_accepted_frame_in_previous_window == frames(end)  %--> if last accepted frame was the last frame
                            do_count_this_frame = 0;     % do not count this frame because all needed frames are selected
                            is_all_empty_in_window = 0;  % do not continue the loop because all needed frames are selected
                        else
                            if frame <= last_accepted_frame_in_previous_window
                                do_count_this_frame = 0;
                            else
                                do_count_this_frame = 1;
                                is_all_empty_in_window = 0;  % at least one frame is considered and thus window is not empty
                                temp_to_be_copied_in_future = frame;
                            end
                        end
                    end
                    if do_count_this_frame == 1
                        if isempty(HMM_labels_test{which_action})
                            l = 0;
                        elseif which_performance > length(HMM_labels_test{which_action})
                            l = 0;
                        else
                            l = length(HMM_labels_test{which_action}{which_performance});
                        end
                        HMM_labels_test{which_action}{which_performance}(l + 1) = estimated_class_this_frame;  %% --> dimension 1 of cell: action, dimension 2 of cell: performance (of the test person), dimension 3 (array): frames
                    end
                    %%%% display the two/three first dimensions of LDA-projected samples:
                    if display_projected_LDA_test_mode == 1
                        if which_action == report_estimated_states_mode_ACTION
                            disp('Plot test mode: Plotting the projected states onto Fisher directions...');
                            figure;
                            % make the figure full screen:
                            set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                            subplot(1,2,1);
                            plot_LDA_projected_states_AndTestProjected(LDA_projected_joints_of_specific_states, number_of_states, name_of_states, LDA_projected_state_means, LDA_projected_joints, estimated_class_this_frame, frame, name_of_actions, which_action);
                            % display skeleton:
                            subplot(1,2,2);
                            one_frame_or_whole_frames = 0;
                            pause_time = 0.1; % a fake input, no need to it.
                            display_frame_or_frames(one_frame_or_whole_frames,skeleton,which_person,which_performance,which_action,frame,base_joint_center,action_length,joints_selected,base_joint_left,base_joint_right,dataset_idx,pause_time);
                            % pause:
                            pause(2);
                            %input('');
                            close all
                        end
                    end
                    %%%% report estimated states:
                    if report_estimated_states_mode == 1
                        if which_action == 6
                            str = sprintf('>>>>>> state %d: %s', estimated_class_this_frame, name_of_states{estimated_class_this_frame});
                            disp(str);
                        end
                    end

                end
                distance_factor_for_accepting_frame = distance_factor_for_accepting_frame + STEP_distance_factor_for_accepting_frame;
            end
            counter_of_slidings = counter_of_slidings + 1;
            last_accepted_frame_in_previous_window = temp_to_be_copied_in_future;
        end
        %%%% labeling the remaining frames (till the maximum_frame_length) as the last found state:
        if do_HMM_equal_sequence_numbers == 1
            for fend = (f+1) : sequence_length
                HMM_labels_test{which_action}{end}(fend) = HMM_labels_test{which_action}{end}(f);
            end
        end
    end
end
%%%% HMM output:
for which_action = 1:number_of_actions
    for which_performance = 1:length(HMM_labels_test{which_action})    % test each action for all samples (performances) of test person
        testbin = (reshape(HMM_labels_test{which_action}{which_performance}(:),1,[]))';
        likelihood = zeros(number_of_actions,1);
        for j = 1:number_of_actions
            likelihood(j,1) = pr_hmm(testbin,P{j},E{j}',Pi{j});
        end
        %%% maximum likelihood:
        [m,estimated_action] = max(likelihood(:,1));
        %%%% report estimated states:
        if report_estimated_states_mode == 1
            if which_action == report_estimated_states_mode_ACTION
                disp('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
                str = sprintf('Actual Action: %s', name_of_actions{which_action});
                disp(str);
                str = sprintf('Test Person: %d', which_person);
                disp(str);
                str = sprintf('Performance: %d', which_performance);
                disp(str);
                str = sprintf('Estimated ACTION: %s', name_of_actions{estimated_action});
                disp(str);
            end
        end
        estimated_action_HMM(test_person, which_action, which_performance) = estimated_action;
        %%%% total result (HMM confidence + Motion test + ...):
        [value_sort,index_sort] = sort(likelihood, 'descend');
        if report_estimates_in_HMM_and_motion == 1
            for j = 1:number_of_actions
                estimatedMatrix_action_HMM{j}(test_person, which_action, which_performance) = index_sort(j);
                confidenceMatrix_action_HMM{j}(test_person, which_action, which_performance) = value_sort(j);
            end
        end
%         if value_sort(1) > 0 || value_sort(2) > 0
%             disp('error in Test function....'); 
%         end
        if omit_motion_part == 1
            estimated_action_TOTAL(test_person, which_action, which_performance) = estimated_action_HMM(test_person, which_action, which_performance);
        else  %% if motion is considered
            HMM_confidence(test_person, which_action, which_performance) = value_sort(1);
            if HMM_confidence(test_person, which_action, which_performance) > Threshold(which_action) * acceptance_factor_HMM
                estimated_action_TOTAL(test_person, which_action, which_performance) = estimated_action_HMM(test_person, which_action, which_performance);
            else
                %%%% Test with motion vector:
                HMM_estimates_passed_to_motion_section = index_sort(1:pass_how_many_HMM_estimates_to_motion_section)';
                estimated_action_MOTION = Test_Motion_Histograms(test_person, mean_histogram_1D, which_action, which_performance, estimated_action_MOTION, HMM_estimates_passed_to_motion_section);
                estimated_action_TOTAL(test_person, which_action, which_performance) = estimated_action_MOTION(test_person, which_action, which_performance);
            end
        end
        %%%% total estimation:
        estimated_action = estimated_action_TOTAL(test_person, which_action, which_performance);
        %%% error:
        if(estimated_action ~= which_action)
            error_action(which_action,test_person) = error_action(which_action,test_person) + 1;
        end
        %%% confusion matrix:
        confusion_matrix_action(which_action,estimated_action,test_person) = confusion_matrix_action(which_action,estimated_action,test_person) + 1;
    end
end

end