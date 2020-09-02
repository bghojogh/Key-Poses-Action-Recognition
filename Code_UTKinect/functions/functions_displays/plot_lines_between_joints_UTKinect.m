function plot_lines_between_joints_UTKinect(joints, line_width)

global joints_selected;

for i = 1:12
    switch i
        case 1
            joint_first = find(joints_selected == 1);
            joint_second = find(joints_selected == 14);
        case 2
            joint_first = find(joints_selected == 14);
            joint_second = find(joints_selected == 15);
        case 3
            joint_first = find(joints_selected == 1);
            joint_second = find(joints_selected == 18);
        case 4
            joint_first = find(joints_selected == 18);
            joint_second = find(joints_selected == 19);
        case 5
            joint_first = find(joints_selected == 1);
            joint_second = find(joints_selected == 2);
        case 6
            joint_first = find(joints_selected == 2);
            joint_second = find(joints_selected == 3);
        case 7
            joint_first = find(joints_selected == 3);
            joint_second = find(joints_selected == 4);
        case 8
            joint_first = find(joints_selected == 5);
            joint_second = find(joints_selected == 9);
        case 9
            joint_first = find(joints_selected == 5);
            joint_second = find(joints_selected == 7);
        case 10
            joint_first = find(joints_selected == 7);
            joint_second = find(joints_selected == 8);
        case 11
            joint_first = find(joints_selected == 9);
            joint_second = find(joints_selected == 11);
        case 12
            joint_first = find(joints_selected == 11);
            joint_second = find(joints_selected == 12);
    end
    
    
    plot3([joints(joint_first,1), joints(joint_second,1)],...
          [joints(joint_first,3), joints(joint_second,3)],...
          [joints(joint_first,2), joints(joint_second,2)],...
          '-r', 'LineWidth', line_width);
end

end