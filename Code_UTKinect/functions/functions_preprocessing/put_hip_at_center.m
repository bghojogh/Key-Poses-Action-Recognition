function joints = put_hip_at_center(joints,hip_index)
    %%% correcting x:
    joints(:,1) = joints(:,1) - joints(hip_index,1);
    %%% correcting y:
    joints(:,2) = joints(:,2) - joints(hip_index,2);
    %%% correcting z:
    joints(:,3) = joints(:,3) - joints(hip_index,3);
end