function joints = unit_scale_body_size(joints, hip_index, spine_index, head_index, target_distance_hip_to_spine, scale_mode)
    
    if scale_mode == 1
        joint1 = joints(hip_index,:);
        joint2 = joints(spine_index,:);
    elseif scale_mode == 2
        joint1 = joints(hip_index,:);
        joint2 = joints(head_index,:);
    end
    
    distance_hip_to_spine = sqrt(sum((joint2 - joint1).^2));
    
    scale_factor = target_distance_hip_to_spine / distance_hip_to_spine;
    
    joints = joints .* scale_factor;

end