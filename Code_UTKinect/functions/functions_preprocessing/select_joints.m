function select_joints(number_of_states, cluster_centers)

global joints_selected;
global joint_selection_mode;
global display_scaled_cluster_centers;
global show_lines_between_joints;
global hip_index;
global spine_index;
global head_index;
global target_distance_hip_to_spine;
global scale_mode;
global hip_index_after_joint_selection;
global acceptance_factor_in_automaticJointSelection;

    %% determine selected joints manually for every state (pose) class (or cluster):
    if joint_selection_mode == 2
        %%%% notice: all of them should contain 1 beause we will remove it in function "load joints and align them"
        %%%% notice: the joints should be sorted
        %%%% notice: this is only effective and good for manual pose selection
        joints_selected = [];
        joints_selected{1} = [1 2 3 4 5 6 7 8 9 10 11 12 14 15 18 19];  %stand
        joints_selected{2} = [1 3 5 6 9 10 14 15 18 19];  % sit
        joints_selected{3} = [1 2 3 4 5 7 8 9 11 12 14 18];  % bend
        joints_selected{4} = [1 5 6 7 8 9 10 11 12];  % hands together front
        joints_selected{5} = [1 5 6 7 8 9 10 11 12];  % start throwing
        joints_selected{6} = [1 5 6 7 8 9 10 11 12];  % hand near shoulder
        joints_selected{7} = [1 5 6 7 8 9 10 11 12];  % hand straight front
        joints_selected{8} = [1 5 6 7 8 9 10 11 12];  % cross
        joints_selected{9} = [1 5 6 7 8 9 10 11 12];  % hands up
        joints_selected{10} = [1 5 6 7 8 9 10 11 12];  % hands open front
        
%         joints_selected = [];
%         for pose_index = 1:number_of_states
%             joints_selected{pose_index} = [1 2 3 5];
%         end
%         joints_selected{2} = [1 2 3 5 6 7];
%         joints_selected{3} = [1 2 3];
%         joints_selected{4} = [1 2 3 10 15 18 20];
    end
    
    %% determine selected joints automatically for every state (pose) class (or cluster):
    if joint_selection_mode == 3
        %%%%%% load neutral standing skeleton:
        which_person = 1; which_performance = 1; which_action = 3; frame = 13;
        joints_neutral_stand = load_joints_and_align_them(which_person,which_performance,which_action,frame); 
        if display_scaled_cluster_centers == 1
            joints = joints_neutral_stand;
            figure
            view(3)
            plot3(joints(:,1),joints(:,3),joints(:,2),'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 4);
            xlim([-4000, 4000]);
            ylim([-3000, 3000]);
            zlim([-1500, 1500]);
            xlabel('x'); ylabel('z'); zlabel('y');
            title('Neutral Stand Pose');
        end
        %%%%%% load skeleton of cluster centers:
        for pose_index = 1:number_of_states
            joints = reshape(cluster_centers(pose_index,:),[],3);
            %%%% unit scale size:
            %joints_centers_scaled{pose_index} =  unit_scale_body_size(joints, hip_index, spine_index, head_index, 5*target_distance_hip_to_spine, scale_mode);                
            joints_centers_scaled{pose_index} = joints;
        end
        if display_scaled_cluster_centers == 1
            for cluster_index = 1:size(cluster_centers,1)
                joints = joints_centers_scaled{cluster_index};
                joints = [0,0,0; joints(:,:)];
                figure
                view(3)
                plot3(joints(:,1),joints(:,3),joints(:,2),'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 4);
                if show_lines_between_joints == 1
                    hold on
                    plot_lines_between_joints_UTKinect(joints, 1);
                end
                xlim([-4000, 4000]);
                ylim([-3000, 3000]);
                zlim([-1500, 1500]);
                xlabel('x'); ylabel('z'); zlabel('y');
                hold off
            end
            input('Enter a key: ');
        end
        %%%%%% find the differences of skeletons:
        joints_selected = [];
        for pose_index = 1:number_of_states
            skeleton_pose = joints_centers_scaled{pose_index};
            for joint_index = 1:size(joints_neutral_stand,1)
                distance_joints(joint_index) = Euclidean_distance(skeleton_pose(joint_index,:), joints_neutral_stand(joint_index,:));
            end
            threshold_joint_selection = max(distance_joints) * acceptance_factor_in_automaticJointSelection;
            temp = [];
            for joint_index = 1:size(joints_neutral_stand,1)
                if distance_joints(joint_index) > threshold_joint_selection
                    temp(end+1) = joint_index;
                end
            end
            temp(end+1) = hip_index_after_joint_selection;   % because we will remove it in function "load_joints_and_align_them"
            temp = sort(temp, 'ascend');
            joints_selected{pose_index} = temp;
        end
    end

end