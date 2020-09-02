function [index_of_states, number_of_states, number_of_state_samples, state, name_of_states, name_of_actions, name_of_actions_withoutNumber, class_center] = determine_train_state_samples_MANUAL()
    
    global display_centers_of_pose_classes;
    global show_lines_between_joints;

    %%%% guide: state(i,:) --> [which_person,which_performance,which_action,frame,state_index]
    
    %%
    state_cell = cell(1,1); % pre-define the cell
    
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% state 1 (stand):
    state_index = 1;
    % walk, frame 1:
    state_cell{state_index}(1,:) = [1,1,1,1,state_index];
    state_cell{state_index}(2,:) = [2,1,1,1,state_index];
    state_cell{state_index}(3,:) = [3,1,1,1,state_index];
    state_cell{state_index}(4,:) = [4,1,1,1,state_index];
    state_cell{state_index}(5,:) = [5,1,1,1,state_index];
    state_cell{state_index}(6,:) = [6,1,1,1,state_index];
    state_cell{state_index}(7,:) = [7,1,1,1,state_index];
    state_cell{state_index}(8,:) = [8,1,1,1,state_index];
    state_cell{state_index}(9,:) = [9,1,1,1,state_index];
    state_cell{state_index}(10,:) = [10,1,1,1,state_index];
    state_cell{state_index}(11,:) = [1,2,1,1,state_index];
    state_cell{state_index}(12,:) = [2,2,1,1,state_index];
    state_cell{state_index}(13,:) = [3,2,1,1,state_index];
    state_cell{state_index}(14,:) = [4,2,1,1,state_index];
    state_cell{state_index}(15,:) = [5,2,1,1,state_index];
    state_cell{state_index}(16,:) = [6,2,1,45,state_index];
    state_cell{state_index}(17,:) = [7,2,1,1,state_index];
    state_cell{state_index}(18,:) = [8,2,1,1,state_index];
    state_cell{state_index}(19,:) = [9,2,1,20,state_index];
    state_cell{state_index}(20,:) = [10,2,1,1,state_index];
    % stand up, frame last:
    state_cell{state_index}(21,:) = [1,1,3,13,state_index];
    state_cell{state_index}(22,:) = [2,1,3,30,state_index];
    state_cell{state_index}(23,:) = [3,1,3,34,state_index];
    state_cell{state_index}(24,:) = [4,1,3,20,state_index];
    state_cell{state_index}(25,:) = [5,1,3,19,state_index];
    state_cell{state_index}(26,:) = [6,1,3,17,state_index];
    state_cell{state_index}(27,:) = [7,1,3,22,state_index];
    state_cell{state_index}(28,:) = [8,1,3,18,state_index];
    state_cell{state_index}(29,:) = [9,1,3,23,state_index];
    state_cell{state_index}(30,:) = [10,1,3,34,state_index];
    state_cell{state_index}(31,:) = [1,2,3,23,state_index];
    state_cell{state_index}(32,:) = [2,2,3,29,state_index];
    state_cell{state_index}(33,:) = [3,2,3,28,state_index];
    %state_cell{state_index}(34,:) = [4,2,3,20,state_index]; --> not good
    state_cell{state_index}(34,:) = [5,2,3,20,state_index];
    %state_cell{state_index}(36,:) = [6,2,3,25,state_index]; --> not good
    state_cell{state_index}(35,:) = [7,2,3,38,state_index];
    state_cell{state_index}(36,:) = [8,2,3,29,state_index];
    state_cell{state_index}(37,:) = [9,2,3,28,state_index];
    state_cell{state_index}(38,:) = [10,2,3,26,state_index];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% state 2 (sit on chair):
    state_index = 2;
    % sit down, frame last:
    state_cell{state_index}(1,:) = [1,1,2,39,state_index];
    state_cell{state_index}(2,:) = [2,1,2,39,state_index];
    state_cell{state_index}(3,:) = [3,1,2,45,state_index];
    state_cell{state_index}(4,:) = [4,1,2,15,state_index];
    state_cell{state_index}(5,:) = [5,1,2,19,state_index];
    state_cell{state_index}(6,:) = [6,1,2,17,state_index];
    state_cell{state_index}(7,:) = [7,1,2,32,state_index];
    state_cell{state_index}(8,:) = [8,1,2,29,state_index];
    state_cell{state_index}(9,:) = [9,1,2,33,state_index];
    state_cell{state_index}(10,:) = [10,1,2,46,state_index];
    state_cell{state_index}(11,:) = [1,2,2,29,state_index];
    state_cell{state_index}(12,:) = [2,2,2,38,state_index];
    state_cell{state_index}(13,:) = [3,2,2,48,state_index];
    state_cell{state_index}(14,:) = [4,2,2,34,state_index];
    state_cell{state_index}(15,:) = [5,2,2,31,state_index];
    state_cell{state_index}(16,:) = [6,2,2,35,state_index];
    state_cell{state_index}(17,:) = [7,2,2,40,state_index];
    state_cell{state_index}(18,:) = [8,2,2,30,state_index];
    state_cell{state_index}(19,:) = [9,2,2,38,state_index];
    state_cell{state_index}(20,:) = [10,2,2,46,state_index];
    % stand up, frame 1:
    state_cell{state_index}(21,:) = [1,1,3,1,state_index];
    state_cell{state_index}(22,:) = [2,1,3,1,state_index];
    state_cell{state_index}(23,:) = [3,1,3,1,state_index];
    state_cell{state_index}(24,:) = [4,1,3,1,state_index];
    state_cell{state_index}(25,:) = [5,1,3,1,state_index];
    state_cell{state_index}(26,:) = [6,1,3,1,state_index];
    state_cell{state_index}(27,:) = [7,1,3,1,state_index];
    state_cell{state_index}(28,:) = [8,1,3,1,state_index];
    state_cell{state_index}(29,:) = [9,1,3,1,state_index];
    state_cell{state_index}(30,:) = [10,1,3,1,state_index];
    state_cell{state_index}(31,:) = [1,2,3,1,state_index];
    state_cell{state_index}(32,:) = [2,2,3,1,state_index];
    state_cell{state_index}(33,:) = [3,2,3,1,state_index];
    state_cell{state_index}(34,:) = [4,2,3,1,state_index];
    state_cell{state_index}(35,:) = [5,2,3,1,state_index];
    state_cell{state_index}(36,:) = [6,2,3,1,state_index];
    state_cell{state_index}(37,:) = [7,2,3,1,state_index];
    state_cell{state_index}(38,:) = [8,2,3,1,state_index];
    state_cell{state_index}(39,:) = [9,2,3,1,state_index];
    state_cell{state_index}(40,:) = [10,2,3,1,state_index];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% state 3 (bend):
    state_index = 3;
    % pick up, frame middle:  ---> totally not good
    state_cell{state_index}(1,:) = [1,1,4,11,state_index];
    state_cell{state_index}(2,:) = [2,1,4,6,state_index];
    state_cell{state_index}(3,:) = [3,1,4,26,state_index];
    state_cell{state_index}(4,:) = [4,1,4,8,state_index];
    state_cell{state_index}(5,:) = [5,1,4,7,state_index];
    state_cell{state_index}(6,:) = [6,1,4,7,state_index];
    state_cell{state_index}(7,:) = [7,1,4,10,state_index];
    state_cell{state_index}(8,:) = [8,1,4,13,state_index];
    state_cell{state_index}(9,:) = [9,1,4,9,state_index];
    state_cell{state_index}(10,:) = [10,1,4,8,state_index];
    state_cell{state_index}(11,:) = [1,2,4,12,state_index];
    state_cell{state_index}(12,:) = [2,2,4,8,state_index];
    state_cell{state_index}(13,:) = [3,2,4,22,state_index];
    %state_cell{state_index}(14,:) = [4,2,4,8,state_index]; ---> back to camera
    state_cell{state_index}(14,:) = [5,2,4,23,state_index];
    state_cell{state_index}(15,:) = [6,2,4,13,state_index];
    %state_cell{state_index}(17,:) = [7,2,4,10,state_index]; --> back to camera
    state_cell{state_index}(16,:) = [8,2,4,7,state_index];
    state_cell{state_index}(17,:) = [9,2,4,7,state_index];
    state_cell{state_index}(18,:) = [9,2,4,8,state_index]; % --> another good from person 9
    state_cell{state_index}(19,:) = [10,2,4,9,state_index];
    state_cell{state_index}(20,:) = [10,2,4,10,state_index]; % --> another good from person 10
    state_cell{state_index}(21,:) = [10,2,4,11,state_index]; % --> another good from person 10
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% state 4 (hands together front):
    state_index = 4;
    % carry, frame last / a frame:
    state_cell{state_index}(1,:) = [1,1,5,56,state_index];
    state_cell{state_index}(2,:) = [2,1,5,12,state_index];
    state_cell{state_index}(3,:) = [3,1,5,6,state_index];
    state_cell{state_index}(4,:) = [4,1,5,54,state_index];
    state_cell{state_index}(5,:) = [5,1,5,26,state_index];
    state_cell{state_index}(6,:) = [6,1,5,28,state_index];
    state_cell{state_index}(7,:) = [7,1,5,26,state_index];
    state_cell{state_index}(8,:) = [8,1,5,10,state_index];
    state_cell{state_index}(9,:) = [9,1,5,85,state_index];
    state_cell{state_index}(10,:) = [10,1,5,90,state_index];
    state_cell{state_index}(11,:) = [1,2,5,5,state_index];
    state_cell{state_index}(12,:) = [2,2,5,40,state_index]; % not very good
    state_cell{state_index}(13,:) = [3,2,5,8,state_index];
    state_cell{state_index}(14,:) = [4,2,5,4,state_index];
    state_cell{state_index}(15,:) = [5,2,5,23,state_index];
    state_cell{state_index}(16,:) = [6,2,5,7,state_index];
    state_cell{state_index}(17,:) = [7,2,5,16,state_index];
    state_cell{state_index}(18,:) = [8,2,5,11,state_index];
    state_cell{state_index}(19,:) = [8,2,5,13,state_index]; % another good from person 8
    state_cell{state_index}(20,:) = [9,2,5,3,state_index];
    state_cell{state_index}(21,:) = [9,2,5,4,state_index]; % another good from person 9
    state_cell{state_index}(22,:) = [9,2,5,6,state_index]; % another good from person 9
    %state_cell{state_index}(10,:) = [10,2,5,90,state_index]; --> carry with only one (right) hand
    % clap hands, a frame:
    state_cell{state_index}(23,:) = [1,1,10,24,state_index];
    state_cell{state_index}(24,:) = [2,1,10,16,state_index];
    state_cell{state_index}(25,:) = [3,1,10,17,state_index];
    state_cell{state_index}(26,:) = [4,1,10,3,state_index];
    state_cell{state_index}(27,:) = [5,1,10,11,state_index];
    state_cell{state_index}(28,:) = [6,1,10,31,state_index];
    state_cell{state_index}(29,:) = [7,1,10,13,state_index];
    state_cell{state_index}(30,:) = [8,1,10,16,state_index];
    state_cell{state_index}(31,:) = [9,1,10,43,state_index];
    state_cell{state_index}(32,:) = [10,1,10,16,state_index];
    state_cell{state_index}(33,:) = [1,2,10,8,state_index];
    state_cell{state_index}(34,:) = [2,2,10,18,state_index];
    state_cell{state_index}(35,:) = [3,2,10,8,state_index];
    state_cell{state_index}(36,:) = [4,2,10,6,state_index];
    state_cell{state_index}(37,:) = [4,2,10,7,state_index];  % another good from person 4
    state_cell{state_index}(38,:) = [5,2,10,4,state_index];
    state_cell{state_index}(39,:) = [6,2,10,4,state_index];
    state_cell{state_index}(40,:) = [7,2,10,4,state_index];
    state_cell{state_index}(41,:) = [8,2,10,3,state_index];
    state_cell{state_index}(42,:) = [9,2,10,6,state_index];
    state_cell{state_index}(43,:) = [10,2,10,4,state_index];
    state_cell{state_index}(44,:) = [10,2,10,5,state_index];  % another good from person 10
    state_cell{state_index}(45,:) = [10,2,10,6,state_index];  % another good from person 10
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% state 6 (right hand attack): --> (not a good state but: to make difference between actions push and throw)
    state_index = 5;
    % throw, frame 1 / a frame:
    state_cell{state_index}(1,:) = [1,1,6,8,state_index];
    state_cell{state_index}(2,:) = [2,1,6,1,state_index];
    state_cell{state_index}(3,:) = [3,1,6,2,state_index];
    %state_cell{state_index}(4,:) = [4,1,6,2,state_index];  % not good --> very similar to push action!
    state_cell{state_index}(4,:) = [5,1,6,1,state_index];
    state_cell{state_index}(5,:) = [6,1,6,1,state_index];
    state_cell{state_index}(6,:) = [7,1,6,4,state_index];
    %state_cell{state_index}(8,:) = [8,1,6,3,state_index];  --> very bad
    %state_cell{state_index}(9,:) = [9,1,6,1,state_index];   % with different hand
    state_cell{state_index}(7,:) = [10,1,6,4,state_index];
    state_cell{state_index}(8,:) = [1,2,6,2,state_index];
    state_cell{state_index}(9,:) = [2,2,6,4,state_index];
    state_cell{state_index}(10,:) = [2,2,6,5,state_index];  % another good from person 2
    state_cell{state_index}(11,:) = [3,2,6,1,state_index];
    %state_cell{state_index}(4,:) = [4,2,6,1,state_index];  % not good --> very similar to push action!
    state_cell{state_index}(12,:) = [5,2,6,3,state_index];
    state_cell{state_index}(13,:) = [5,2,6,4,state_index]; % another good from person 5
    state_cell{state_index}(14,:) = [6,2,6,3,state_index];
    state_cell{state_index}(15,:) = [7,2,6,6,state_index];
    state_cell{state_index}(16,:) = [7,2,6,13,state_index]; % another good from person 7
    state_cell{state_index}(17,:) = [7,2,6,14,state_index]; % another good from person 7 --> the action of person 7 is odd (seems reverse!)
    %state_cell{state_index}(8,:) = [8,2,6,3,state_index];  --> not good
    %state_cell{state_index}(9,:) = [9,2,6,1,state_index];   % with different hand
    state_cell{state_index}(18,:) = [10,2,6,3,state_index];
    state_cell{state_index}(19,:) = [10,2,6,5,state_index]; % another good from person 10
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% state 7 (right hand near body, front):
    state_index = 6;
    % push, frame 1:
    state_cell{state_index}(1,:) = [1,1,7,1,state_index];
    state_cell{state_index}(2,:) = [2,1,7,1,state_index];
    state_cell{state_index}(3,:) = [3,1,7,3,state_index];
    state_cell{state_index}(4,:) = [4,1,7,1,state_index];
    state_cell{state_index}(5,:) = [5,1,7,1,state_index];
    state_cell{state_index}(6,:) = [6,1,7,1,state_index];
    state_cell{state_index}(7,:) = [7,1,7,2,state_index];
    state_cell{state_index}(8,:) = [8,1,7,1,state_index];
    state_cell{state_index}(9,:) = [9,1,7,7,state_index];
    state_cell{state_index}(10,:) = [10,1,7,1,state_index];
    state_cell{state_index}(11,:) = [1,2,7,1,state_index];
    state_cell{state_index}(12,:) = [2,2,7,1,state_index];
    state_cell{state_index}(13,:) = [3,2,7,1,state_index];
    state_cell{state_index}(14,:) = [4,2,7,1,state_index];
    state_cell{state_index}(15,:) = [5,2,7,1,state_index];
    state_cell{state_index}(16,:) = [6,2,7,1,state_index];
    state_cell{state_index}(17,:) = [7,2,7,1,state_index];
    state_cell{state_index}(18,:) = [8,2,7,3,state_index];
    state_cell{state_index}(19,:) = [9,2,7,4,state_index];
    state_cell{state_index}(20,:) = [10,2,7,3,state_index];
    % pull, frame last:
    state_cell{state_index}(21,:) = [1,1,8,12,state_index];
    state_cell{state_index}(22,:) = [2,1,8,9,state_index];
    state_cell{state_index}(23,:) = [3,1,8,12,state_index];
    state_cell{state_index}(24,:) = [4,1,8,8,state_index];
    state_cell{state_index}(25,:) = [5,1,8,12,state_index];
    state_cell{state_index}(26,:) = [6,1,8,8,state_index];
    state_cell{state_index}(27,:) = [7,1,8,30,state_index];
    state_cell{state_index}(28,:) = [8,1,8,11,state_index];
    state_cell{state_index}(29,:) = [9,1,8,33,state_index];
    state_cell{state_index}(30,:) = [10,1,8,19,state_index];
    state_cell{state_index}(31,:) = [1,2,8,7,state_index];
    state_cell{state_index}(32,:) = [2,2,8,11,state_index];
    state_cell{state_index}(33,:) = [3,2,8,27,state_index];
    state_cell{state_index}(34,:) = [4,2,8,13,state_index];
    state_cell{state_index}(35,:) = [5,2,8,9,state_index];
    state_cell{state_index}(36,:) = [6,2,8,9,state_index];
    state_cell{state_index}(37,:) = [7,2,8,24,state_index];
    state_cell{state_index}(38,:) = [8,2,8,14,state_index];
    state_cell{state_index}(39,:) = [9,2,8,18,state_index];
    state_cell{state_index}(40,:) = [10,2,8,15,state_index];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% state 8 (right hand straight, front):
    state_index = 7;
    % push, frame last:
    state_cell{state_index}(1,:) = [1,1,7,15,state_index];
    state_cell{state_index}(2,:) = [2,1,7,6,state_index];
    state_cell{state_index}(3,:) = [3,1,7,11,state_index];
    state_cell{state_index}(4,:) = [4,1,7,8,state_index];
    state_cell{state_index}(5,:) = [5,1,7,7,state_index];
    state_cell{state_index}(6,:) = [6,1,7,6,state_index];
    state_cell{state_index}(7,:) = [7,1,7,10,state_index];
    state_cell{state_index}(8,:) = [8,1,7,6,state_index];
    state_cell{state_index}(9,:) = [9,1,7,23,state_index];
    state_cell{state_index}(10,:) = [10,1,7,13,state_index];
    state_cell{state_index}(11,:) = [1,2,7,7,state_index];
    state_cell{state_index}(12,:) = [2,2,7,9,state_index];
    state_cell{state_index}(13,:) = [3,2,7,11,state_index];
    state_cell{state_index}(14,:) = [4,2,7,10,state_index];
    state_cell{state_index}(15,:) = [5,2,7,9,state_index];
    state_cell{state_index}(16,:) = [6,2,7,7,state_index];
    state_cell{state_index}(17,:) = [7,2,7,12,state_index];
    state_cell{state_index}(18,:) = [8,2,7,9,state_index];
    state_cell{state_index}(19,:) = [9,2,7,17,state_index];
    state_cell{state_index}(20,:) = [10,2,7,11,state_index];
    % pull, frame 1:
    state_cell{state_index}(21,:) = [1,1,8,1,state_index];
    state_cell{state_index}(22,:) = [2,1,8,1,state_index];
    state_cell{state_index}(23,:) = [3,1,8,1,state_index];
    state_cell{state_index}(24,:) = [4,1,8,2,state_index];
    state_cell{state_index}(25,:) = [5,1,8,1,state_index];
    state_cell{state_index}(26,:) = [6,1,8,1,state_index];
    state_cell{state_index}(27,:) = [7,1,8,1,state_index];
    state_cell{state_index}(28,:) = [8,1,8,1,state_index];
    state_cell{state_index}(29,:) = [9,1,8,1,state_index];
    state_cell{state_index}(30,:) = [10,1,8,1,state_index];
    state_cell{state_index}(31,:) = [1,2,8,1,state_index];
    state_cell{state_index}(32,:) = [2,2,8,1,state_index];
    state_cell{state_index}(33,:) = [3,2,8,1,state_index];
    state_cell{state_index}(34,:) = [4,2,8,2,state_index];
    state_cell{state_index}(35,:) = [5,2,8,1,state_index];
    state_cell{state_index}(36,:) = [6,2,8,1,state_index];
    state_cell{state_index}(37,:) = [7,2,8,1,state_index];
    state_cell{state_index}(38,:) = [8,2,8,1,state_index];
    state_cell{state_index}(39,:) = [9,2,8,1,state_index];
    state_cell{state_index}(40,:) = [10,2,8,1,state_index];
    % throw, a frame:
    state_cell{state_index}(41,:) = [1,1,6,11,state_index];
    state_cell{state_index}(42,:) = [2,1,6,3,state_index];
    state_cell{state_index}(43,:) = [3,1,6,5,state_index];
    state_cell{state_index}(44,:) = [4,1,6,3,state_index];
    state_cell{state_index}(45,:) = [5,1,6,10,state_index];
    state_cell{state_index}(46,:) = [6,1,6,3,state_index];
    %state_cell{state_index}(7,:) = [7,1,6,15,state_index];  % not good
    %state_cell{state_index}(7,:) = [8,1,6,6,state_index];  --> not good
    %state_cell{state_index}(8,:) = [9,1,6,5,state_index];   --> with different hand
    state_cell{state_index}(47,:) = [10,1,6,11,state_index];  % has some bending
    state_cell{state_index}(48,:) = [1,2,6,4,state_index];
    state_cell{state_index}(49,:) = [2,2,6,8,state_index];
    state_cell{state_index}(50,:) = [3,2,6,10,state_index];
    state_cell{state_index}(51,:) = [4,2,6,5,state_index];
    state_cell{state_index}(52,:) = [5,2,6,11,state_index];
    state_cell{state_index}(53,:) = [6,2,6,6,state_index];
    %state_cell{state_index}(16,:) = [7,2,6,15,state_index]; --> not good
    %state_cell{state_index}(17,:) = [8,2,6,6,state_index]; --> not good
    %state_cell{state_index}(18,:) = [9,2,6,5,state_index];   % with different hand
    state_cell{state_index}(54,:) = [10,2,6,11,state_index];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% state 9 (Cross):
    state_index = 8;
    % wave, a frame:
    state_cell{state_index}(1,:) = [1,1,9,4,state_index];
    state_cell{state_index}(2,:) = [1,1,9,14,state_index];
    state_cell{state_index}(3,:) = [1,1,9,21,state_index];
    state_cell{state_index}(4,:) = [1,1,9,32,state_index];
    state_cell{state_index}(5,:) = [1,1,9,40,state_index];
    state_cell{state_index}(6,:) = [1,1,9,52,state_index];
    state_cell{state_index}(7,:) = [2,1,9,2,state_index];
    state_cell{state_index}(8,:) = [2,1,9,10,state_index];
    state_cell{state_index}(9,:) = [2,1,9,14,state_index];
    state_cell{state_index}(10,:) = [2,1,9,21,state_index];
    state_cell{state_index}(11,:) = [3,1,9,13,state_index];
    state_cell{state_index}(12,:) = [3,1,9,24,state_index];
    state_cell{state_index}(13,:) = [4,1,9,2,state_index];
    state_cell{state_index}(14,:) = [4,1,9,11,state_index];
    state_cell{state_index}(15,:) = [4,1,9,16,state_index];
    state_cell{state_index}(16,:) = [4,1,9,17,state_index];
    state_cell{state_index}(17,:) = [5,1,9,3,state_index];
    state_cell{state_index}(18,:) = [5,1,9,22,state_index];
    state_cell{state_index}(19,:) = [5,1,9,23,state_index];
    state_cell{state_index}(20,:) = [5,1,9,41,state_index];
    state_cell{state_index}(21,:) = [5,1,9,42,state_index];
    state_cell{state_index}(22,:) = [5,1,9,56,state_index];
    state_cell{state_index}(23,:) = [5,1,9,57,state_index];
    state_cell{state_index}(24,:) = [5,1,9,58,state_index];
    state_cell{state_index}(25,:) = [6,1,9,3,state_index];
    state_cell{state_index}(26,:) = [6,1,9,11,state_index];
    state_cell{state_index}(27,:) = [6,1,9,22,state_index];
    state_cell{state_index}(28,:) = [6,1,9,23,state_index];
    state_cell{state_index}(29,:) = [6,1,9,34,state_index];
    state_cell{state_index}(30,:) = [7,1,9,3,state_index];
    state_cell{state_index}(31,:) = [7,1,9,16,state_index];
    state_cell{state_index}(32,:) = [7,1,9,35,state_index];
    state_cell{state_index}(33,:) = [7,1,9,50,state_index];
    state_cell{state_index}(34,:) = [8,1,9,9,state_index];
    state_cell{state_index}(35,:) = [8,1,9,18,state_index];
    state_cell{state_index}(36,:) = [9,1,9,6,state_index];
    state_cell{state_index}(37,:) = [9,1,9,36,state_index];
    state_cell{state_index}(38,:) = [9,1,9,76,state_index];
    state_cell{state_index}(39,:) = [10,1,9,3,state_index];
    state_cell{state_index}(40,:) = [10,1,9,14,state_index];
    state_cell{state_index}(41,:) = [10,1,9,21,state_index];
    state_cell{state_index}(42,:) = [10,1,9,32,state_index];
    state_cell{state_index}(43,:) = [10,1,9,38,state_index];
    state_cell{state_index}(44,:) = [10,1,9,52,state_index];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% state 10 (hands together up):
    state_index = 9;
    % wave, a frame:
    state_cell{state_index}(1,:) = [1,1,9,9,state_index];
    state_cell{state_index}(2,:) = [1,1,9,25,state_index];
    state_cell{state_index}(3,:) = [1,1,9,44,state_index];
    state_cell{state_index}(4,:) = [2,1,9,6,state_index];
    state_cell{state_index}(5,:) = [2,1,9,17,state_index];
    state_cell{state_index}(6,:) = [3,1,9,6,state_index];
    state_cell{state_index}(7,:) = [3,1,9,7,state_index];
    state_cell{state_index}(8,:) = [3,1,9,19,state_index];
    state_cell{state_index}(9,:) = [4,1,9,5,state_index];
    state_cell{state_index}(10,:) = [4,1,9,6,state_index];
    state_cell{state_index}(11,:) = [4,1,9,21,state_index];
    state_cell{state_index}(12,:) = [5,1,9,46,state_index];
    state_cell{state_index}(13,:) = [6,1,9,7,state_index];
    state_cell{state_index}(14,:) = [6,1,9,17,state_index];
    state_cell{state_index}(15,:) = [6,1,9,28,state_index];
    %state_cell{state_index}(7,:) = [7,1,9,25,state_index]; -- not good
    state_cell{state_index}(16,:) = [8,1,9,4,state_index];
    state_cell{state_index}(17,:) = [8,1,9,12,state_index];
    state_cell{state_index}(18,:) = [8,1,9,13,state_index];
    state_cell{state_index}(19,:) = [8,1,9,21,state_index];
    state_cell{state_index}(20,:) = [9,1,9,14,state_index];
    state_cell{state_index}(21,:) = [9,1,9,50,state_index];
    state_cell{state_index}(22,:) = [9,1,9,51,state_index];
    state_cell{state_index}(23,:) = [10,1,9,10,state_index];
    state_cell{state_index}(24,:) = [10,1,9,27,state_index];
    state_cell{state_index}(25,:) = [10,1,9,45,state_index];
    state_cell{state_index}(26,:) = [10,1,9,46,state_index];
    state_cell{state_index}(27,:) = [1,2,9,5,state_index];
    state_cell{state_index}(28,:) = [1,2,9,6,state_index];
    state_cell{state_index}(29,:) = [1,2,9,17,state_index];
    state_cell{state_index}(30,:) = [1,2,9,28,state_index];
    state_cell{state_index}(31,:) = [2,2,9,8,state_index];
    state_cell{state_index}(32,:) = [2,2,9,9,state_index];
    state_cell{state_index}(33,:) = [2,2,9,10,state_index];
    state_cell{state_index}(34,:) = [2,2,9,22,state_index];
    state_cell{state_index}(35,:) = [2,2,9,23,state_index];
    state_cell{state_index}(36,:) = [2,2,9,40,state_index];
    state_cell{state_index}(37,:) = [2,2,9,41,state_index];
    state_cell{state_index}(38,:) = [3,2,9,7,state_index];
    state_cell{state_index}(39,:) = [3,2,9,15,state_index];
    state_cell{state_index}(40,:) = [3,2,9,32,state_index];
    state_cell{state_index}(41,:) = [4,2,9,14,state_index];
    state_cell{state_index}(42,:) = [4,2,9,15,state_index];
    state_cell{state_index}(43,:) = [4,2,9,45,state_index];
    state_cell{state_index}(44,:) = [4,2,9,46,state_index];
    %state_cell{state_index}(10,:) = [5,2,9,46,state_index]; --> person 5 not good
    %state_cell{state_index}(10,:) = [6,2,9,46,state_index]; --> person 6 not good
    state_cell{state_index}(45,:) = [7,2,9,44,state_index]; % not very good
    state_cell{state_index}(46,:) = [8,2,9,4,state_index];
    state_cell{state_index}(47,:) = [8,2,9,15,state_index];
    state_cell{state_index}(48,:) = [8,2,9,29,state_index];
    state_cell{state_index}(49,:) = [9,2,9,5,state_index];
    state_cell{state_index}(50,:) = [9,2,9,7,state_index];
    state_cell{state_index}(51,:) = [9,2,9,15,state_index];
    state_cell{state_index}(52,:) = [9,2,9,26,state_index];
    state_cell{state_index}(53,:) = [9,2,9,27,state_index];
    state_cell{state_index}(54,:) = [9,2,9,42,state_index];
    state_cell{state_index}(55,:) = [10,2,9,26,state_index]; % not very good
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% state 11 (hands open in clap):
    state_index = 10;
    % clap hands, frame 1 / a frame:
    state_cell{state_index}(1,:) = [1,1,10,5,state_index];
    state_cell{state_index}(2,:) = [1,1,10,10,state_index];
    state_cell{state_index}(3,:) = [1,1,10,11,state_index];
    state_cell{state_index}(4,:) = [1,1,10,20,state_index];
    state_cell{state_index}(5,:) = [1,1,10,28,state_index];
    state_cell{state_index}(6,:) = [2,1,10,3,state_index];
    state_cell{state_index}(7,:) = [2,1,10,8,state_index];
    state_cell{state_index}(8,:) = [2,1,10,13,state_index];
    state_cell{state_index}(9,:) = [3,1,10,2,state_index];
    state_cell{state_index}(10,:) = [3,1,10,8,state_index];
    state_cell{state_index}(11,:) = [4,1,10,1,state_index];
    state_cell{state_index}(12,:) = [4,1,10,10,state_index];
    state_cell{state_index}(13,:) = [4,1,10,11,state_index];
    state_cell{state_index}(14,:) = [4,1,10,15,state_index];
    state_cell{state_index}(15,:) = [5,1,10,1,state_index];
    state_cell{state_index}(16,:) = [5,1,10,2,state_index];
    state_cell{state_index}(17,:) = [5,1,10,3,state_index];
    state_cell{state_index}(18,:) = [5,1,10,22,state_index];
    state_cell{state_index}(19,:) = [5,1,10,23,state_index];
    state_cell{state_index}(20,:) = [5,1,10,24,state_index];
    state_cell{state_index}(21,:) = [5,1,10,25,state_index];
    state_cell{state_index}(22,:) = [5,1,10,40,state_index];
    state_cell{state_index}(23,:) = [5,1,10,41,state_index];
    %state_cell{state_index}(6,:) = [6,1,10,1,state_index]; --> very very similar to carry
    state_cell{state_index}(24,:) = [7,1,10,1,state_index];
    state_cell{state_index}(25,:) = [7,1,10,11,state_index];
    state_cell{state_index}(26,:) = [7,1,10,29,state_index];
    state_cell{state_index}(27,:) = [8,1,10,2,state_index]; % --> other states of person 8 was very similar to carry
    state_cell{state_index}(28,:) = [9,1,10,1,state_index];
    state_cell{state_index}(29,:) = [9,1,10,6,state_index];
    state_cell{state_index}(30,:) = [9,1,10,10,state_index];
    state_cell{state_index}(31,:) = [9,1,10,12,state_index];
    state_cell{state_index}(32,:) = [9,1,10,15,state_index];
    state_cell{state_index}(33,:) = [9,1,10,28,state_index];
    state_cell{state_index}(34,:) = [9,1,10,30,state_index];
    state_cell{state_index}(35,:) = [9,1,10,34,state_index];
    state_cell{state_index}(36,:) = [9,1,10,35,state_index];
    state_cell{state_index}(37,:) = [9,1,10,51,state_index];
    state_cell{state_index}(38,:) = [10,1,10,2,state_index];
    state_cell{state_index}(39,:) = [10,1,10,3,state_index]; % --> other states of person 10 was very similar to carry
    
    %% name of states:
    name_of_states = {'Stand', 'Sit', 'Bend', 'Hands together front', 'Start throwing', 'Hand near shoulder', 'Hand straight front', 'Cross', 'Hands up', 'Hands open front'};
    
    %% name of actions:
    name_of_actions = {'(1) Walk';'(2) Sit Down';'(3) Stand Up';'(4) Pick Up';'(5) Carry'; '(6) Throw'; '(7) Push'; '(8) Pull'; '(9) Wave Hands'; '(10) Clap Hands'};
    name_of_actions_withoutNumber = {'Walk';'Sit Down';'Stand Up';'Pick Up';'Carry'; 'Throw'; 'Push'; 'Pull'; 'Wave Hands'; 'Clap Hands'};
    
    %%
    counter = 0;
    for i = 1:length(state_cell)
        for j = 1:size(state_cell{i},1)
            counter = counter + 1;
            state(counter,:) = state_cell{i}(j,:);
        end
    end
    
    %%
    index_of_states = unique(state(:,5));
    number_of_states = length(index_of_states);
    number_of_state_samples = size(state,1);
    
    %% find the centers of pose classes:
    for class_index = 1:number_of_states
        corresponding_samples_in_state = find(state(:,5) == class_index);
        class_center_temp = [];
        for sample_index = corresponding_samples_in_state'
            which_person = state(sample_index,1);
            which_performance = state(sample_index,2);
            which_action = state(sample_index,3);
            frame = state(sample_index,4);
            %%%% skeleton in the key frame:
            joints = load_joints_and_align_them(which_person,which_performance,which_action,frame);
            joints = reshape(joints,1,[]);
            class_center_temp(end+1, :) = joints;
        end
        class_center(class_index,:) = mean(class_center_temp,1);
    end
    
    %% display the skeletons of class centers:
    if display_centers_of_pose_classes == 1
        for class_index = 1:size(class_center,1)
            joints = reshape(class_center(class_index,:),[],3);
            joints = [0,0,0; joints(:,:)];
            figure
            view(3)
            plot3(joints(:,1),joints(:,3),joints(:,2),'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 4);
            if show_lines_between_joints == 1
                hold on
                plot_lines_between_joints_UTKinect(joints, 1);
            end
%             xlim([-4000, 4000]);
%             ylim([-3000, 3000]);
%             zlim([-2500, 1500]);
            xlim([-4000, 4000]);
            ylim([-3000, 3000]);
            zlim([-1500, 1500]);
            xlabel('x'); ylabel('z'); zlabel('y');
            hold off
        end
        input('Enter a key: ');
    end
    
end