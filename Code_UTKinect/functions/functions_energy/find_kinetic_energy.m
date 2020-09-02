function energy_of_frames = find_kinetic_energy(which_person,which_performance,which_action,frame_step_in_energy)
    
    global action_length;

    
    frames = 1:frame_step_in_energy:action_length(which_person,which_performance,which_action);
    counter = 0;
    for frame = frames(2:end)  %%% should not consider the first frame
        %%%% load joints:
        joints = load_joints_and_align_them(which_person,which_performance,which_action,frame);
        joints_previous_frame = load_joints_and_align_them(which_person,which_performance,which_action,frame - frame_step_in_energy);
        %%%% find kinetic energy:
        delta_T = 1;
        for joint_index = 1:size(joints,1)  %%%% iteration on joints
            velocity_of_joint(joint_index,1) = Euclidean_distance(joints(joint_index), joints_previous_frame(joint_index)) / delta_T;
            energy_of_joint(joint_index,1) = 0.5 * (velocity_of_joint(joint_index,1) ^ 2);
        end
        counter = counter + 1;
        energy_of_frames(counter,1) = sum(energy_of_joint);
    end

end