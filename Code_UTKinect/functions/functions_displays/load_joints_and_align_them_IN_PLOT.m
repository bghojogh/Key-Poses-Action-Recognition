function joints = load_joints_and_align_them_IN_PLOT(which_person,which_performance,which_action,frame)
    global skeleton
    global hip_index;
    global left_shoulder;
    global right_shoulder;
    global spine_index;
    global head_index;
    global joints_selected;
    global target_distance_hip_to_spine;
    global scale_mode;
    
    %%%% load skeleton:
    joints = reshape(skeleton(which_person,which_performance,which_action,frame,:,:),[],3); 
    %%%% align skeleton:
    joints = put_hip_at_center(joints,hip_index);
    joints = align_shoulders(joints,left_shoulder,right_shoulder);
    %%%% unit scale size:
    joints =  unit_scale_body_size(joints, hip_index, spine_index, head_index, target_distance_hip_to_spine, scale_mode);
    %%%% select the joints out of all joints of skeleton:
    joints = joints(joints_selected,:);
end