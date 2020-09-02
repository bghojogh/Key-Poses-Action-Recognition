function display_frame_or_frames(one_frame_or_whole_frames,skeleton,which_person,which_performance,which_action,frame,dataset_idx,pause_time,target_distance_hip_to_spine)

    global action_length;
    global show_lines_between_joints;

    if one_frame_or_whole_frames == 0
        %%%% load joints:
        joints = load_joints_and_align_them_IN_PLOT(which_person,which_performance,which_action,frame);

        figure
            view(3)
            plot3(joints(:,1),joints(:,3),joints(:,2),'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 4);
            if show_lines_between_joints == 1
                hold on
                plot_lines_between_joints_UTKinect(joints, 1);
            end
%             xlim([min(joints(:,1))*10, max(joints(:,1))*10]);
%             ylim([min(joints(:,3))*10, max(joints(:,3))*10]);
%             zlim([min(joints(:,2))*1.5, max(joints(:,2))*2]);
            xlim([-4000, 4000]);
            ylim([-3000, 3000]);
            zlim([-1500, 1500]);
            xlabel('x'); ylabel('z'); zlabel('y');
            hold on
        str = sprintf('Frame: %d', frame);
        title(str);
        hold off
        
    elseif one_frame_or_whole_frames == 1
        for frame = 1:action_length(which_person,which_performance,which_action)
            %%%% load joints:
            joints = load_joints_and_align_them_IN_PLOT(which_person,which_performance,which_action,frame);

            view(3)
            plot3(joints(:,1),joints(:,3),joints(:,2),'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 4);
            if show_lines_between_joints == 1
                hold on
                plot_lines_between_joints_UTKinect(joints, 1);
            end
%             xlim([min(joints(:,1))*10, max(joints(:,1))*10]);
%             ylim([min(joints(:,3))*10, max(joints(:,3))*10]);
%             zlim([min(joints(:,2))*1.5, max(joints(:,2))*2]);
            xlim([-4000, 4000]);
            ylim([-3000, 3000]);
            zlim([-1500, 1500]);
            xlabel('x'); ylabel('z'); zlabel('y');
            hold on
            str = sprintf('Frame: %d', frame);
            title(str);
            pause(pause_time);
            hold off
        end
    end
end