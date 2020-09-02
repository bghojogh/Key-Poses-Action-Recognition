function key_frames = find_key_frames(which_person,which_performance,which_action,consider_first_frame_in_emptySequences)
    
    global display_kinetic_energy_curve;
    global frame_step_in_energy;

    energy_of_frames = find_kinetic_energy(which_person,which_performance,which_action,frame_step_in_energy);
    [energy_local_mins_value, energy_local_mins_index] = find_local_mins_of_energy(energy_of_frames, which_action, display_kinetic_energy_curve);  
    %%%%% add first frames to keyFrames:
    if ~isempty(energy_local_mins_index)
        if energy_local_mins_index(1) ~= 1
            energy_local_mins_index = [1; energy_local_mins_index];
        end
    else
        if consider_first_frame_in_emptySequences == 1
            energy_local_mins_index = [1];
        end
    end
    key_frames = 1 + ((energy_local_mins_index - 1) * frame_step_in_energy);
    key_frames = key_frames';
end