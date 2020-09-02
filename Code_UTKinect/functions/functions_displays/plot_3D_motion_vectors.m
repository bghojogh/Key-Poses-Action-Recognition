function plot_3D_motion_vectors(motive_joint)

global align_motions_to_one_plane;

% view(3)
% starts = motive_joint(1:end-1,:);
% ends = motive_joint(2:end,:);
% quiver3(starts(:,1), starts(:,3), starts(:,2), ends(:,1)-starts(:,1), ends(:,3)-starts(:,3), ends(:,2)-starts(:,2), 0, 'MaxHeadSize', 1/norm(ends-starts));
% xlabel('x'); ylabel('z'); zlabel('y');

view(3)
if align_motions_to_one_plane == 0
    plot3(motive_joint(:,1), motive_joint(:,3), motive_joint(:,2), '-o', 'MarkerFaceColor', 'b');
else
    plot3(motive_joint(:,1), zeros(size(motive_joint(:,3))), motive_joint(:,2), '-o', 'MarkerFaceColor', 'b');  % to cancel (in plot) the very small error of rotation
end
xlabel('x'); ylabel('z'); zlabel('y');

end