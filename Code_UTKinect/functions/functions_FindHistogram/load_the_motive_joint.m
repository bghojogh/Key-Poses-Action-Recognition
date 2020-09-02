function motive_joint = load_the_motive_joint(which_person,which_performance,which_action,frame,motive_joint_index)
    
    global skeleton;
    global left_shoulder;
    global right_shoulder;
    global align_motions_to_one_plane;
    
    %%%% load skeleton (this frame AND first frame):
    joints_thisFrame = reshape(skeleton(which_person,which_performance,which_action,frame,:,:),[],3); 
    joints_firstFrame = reshape(skeleton(which_person,which_performance,which_action,1,:,:),[],3); 
    
    %%%% shift the skeleton (removing global motion from skeleton):
    for i = 1:size(joints_thisFrame,1)
        joints_thisFrame(i,:) = joints_thisFrame(i,:) - joints_firstFrame(motive_joint_index,:);
    end
    
    %%%% calculate the rotation angle:
    if align_motions_to_one_plane == 1
        motive_joint_thisFrame = joints_thisFrame(motive_joint_index,:);
        angle = atan2(motive_joint_thisFrame(1,3),motive_joint_thisFrame(1,1)); % rotation angle
        rotation = [cos(angle),0,-sin(angle); 0,1,0; sin(angle),0,cos(angle)];
    else
        motive_joint_firstFrame = joints_firstFrame(motive_joint_index,:);
        angle = atan2(motive_joint_firstFrame(1,3),motive_joint_firstFrame(1,1)); % rotation angle
        rotation = [cos(angle),0,-sin(angle); 0,1,0; sin(angle),0,cos(angle)];
    end
    
    %%%% rotate the joints of this frame:
    joints_thisFrame(:,:) = joints_thisFrame(:,:) * rotation;
    
    %%%% take the motive joint out of skeleton in this frame:
    motive_joint = joints_thisFrame(motive_joint_index,:);

end