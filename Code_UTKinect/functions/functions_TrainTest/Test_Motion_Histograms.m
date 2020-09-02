function estimated_action_MOTION = Test_Motion_Histograms(test_person, mean_histogram_1D, which_action, which_performance, estimated_action_MOTION, HMM_estimates_passed_to_motion_section)

global action_length;
global frame_step;
global number_of_actions;
global motive_joint_index;
global display_histogram_TEST;
global report_test_estimates_in_histogram;

which_person = test_person;
%%%% finding motion vectors in frames:
frames = 1:frame_step:action_length(which_person,which_performance,which_action);
motion_vector = zeros(length(frames)-1, 3);
motive_joint = zeros(length(frames), 3);
counter = 0;
for frame = frames
    %%%% load the motive joint:
    motive_joint(frame,:) = load_the_motive_joint(which_person,which_performance,which_action,frame,motive_joint_index);
    %%%% calculate the motion vector:
    if frame ~= 1
        counter = counter + 1;
        motion_vector(counter,:) = motive_joint(frame,:) - motive_joint(frame-1,:);
    end
end
%%%% histogram:
[Histogram_1D, Histogram_2D] = Calculate_Histogram(motive_joint(2:end,:));  % notice: 2:end because we remove the redundant first frame (which is in origin)
if display_histogram_TEST == 1
    figure
    view(3)
    bar3(Histogram_1D);
    input('Enter a key to continue: ');
    close all
end
%%%% find the minimum distance:
counter = 1;
for i = HMM_estimates_passed_to_motion_section
    distances(counter,1) = Euclidean_distance(Histogram_1D', mean_histogram_1D(i,:));
    counter = counter + 1;
end
[~,index_sort_distance] = sort(distances);
index_min_distance = index_sort_distance(1);
estimated_class = HMM_estimates_passed_to_motion_section(index_min_distance);
estimated_action_MOTION(test_person, which_action, which_performance) = estimated_class;
if report_test_estimates_in_histogram == 1
    disp('estimated_class:'); disp(estimated_class)
    disp('which_action:'); disp(which_action);
    disp('=============================');
end

end