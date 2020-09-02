function joints = align_shoulders(joints,left_shoulder,right_shoulder)

    x_dir = joints(right_shoulder,:) - joints(left_shoulder,:); % x direction
    x_dir = x_dir - [0,x_dir(1,2),0]; % projection on ground 
    angle = atan2(x_dir(1,3),x_dir(1,1)); % rotation angle

    rotation = [cos(angle),0,-sin(angle); 0,1,0; sin(angle),0,cos(angle)];
    joints(:,:) = joints(:,:) * rotation;
        
end