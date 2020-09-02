function plot_LDA_projected_states(LDA_projected_joints_of_specific_states, number_of_states, name_of_states, LDA_projected_state_means)

    plots = zeros(number_of_states,1);
    MarkersSymbols_plot = {'v', 's', 'd', '^', 'p', 'h', 'o', '>', '<', 'o', 'd'};
    MarkersColors_plot = {[1,1,0], [1,0,1], [0,1,1], [1,0,0], [1,0.5,0], [0,0,1], [0.6,0.4,0.7], [0,1,0], [0.6,0.5,0.3], [1,0,0.5], [0,0,0]};
    %%%% 2D plot:
    figure;
    for state_index = 1:number_of_states
        first_Fisher_projection = reshape(LDA_projected_joints_of_specific_states{state_index}(1,:,:), [], 1);
        second_Fisher_projection = reshape(LDA_projected_joints_of_specific_states{state_index}(2,:,:), [], 1);
        plots(state_index) = plot(first_Fisher_projection, second_Fisher_projection, MarkersSymbols_plot{state_index}, 'MarkerEdgeColor', MarkersColors_plot{state_index}, 'MarkerFaceColor', MarkersColors_plot{state_index},'MarkerSize',9);
        hold on
    end
    % plot the mean of states:
    for state_index = 1:number_of_states
        first_Fisher_projection = reshape(LDA_projected_state_means(1,:,state_index), [], 1);
        second_Fisher_projection = reshape(LDA_projected_state_means(2,:,state_index), [], 1);
        plot(first_Fisher_projection, second_Fisher_projection, MarkersSymbols_plot{state_index}, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', MarkersColors_plot{state_index},'MarkerSize',16);
        hold on
    end
    leg = legend(plots,name_of_states{:});
    set(leg, 'Location', 'northeastoutside');
    xlabel('First Fisher Direction');
    ylabel('Second Fisher Direction');
    %%%% 3D plot:
    figure;
    for state_index = 1:number_of_states
        first_Fisher_projection = reshape(LDA_projected_joints_of_specific_states{state_index}(1,:,:), [], 1);
        second_Fisher_projection = reshape(LDA_projected_joints_of_specific_states{state_index}(2,:,:), [], 1);
        third_Fisher_projection = reshape(LDA_projected_joints_of_specific_states{state_index}(3,:,:), [], 1);
        plots(state_index) = plot3(first_Fisher_projection, second_Fisher_projection, third_Fisher_projection, MarkersSymbols_plot{state_index}, 'MarkerEdgeColor', MarkersColors_plot{state_index}, 'MarkerFaceColor', MarkersColors_plot{state_index},'MarkerSize',9);
        hold on
    end
    % plot the mean of states:
    for state_index = 1:number_of_states
        first_Fisher_projection = reshape(LDA_projected_state_means(1,:,state_index), [], 1);
        second_Fisher_projection = reshape(LDA_projected_state_means(2,:,state_index), [], 1);
        third_Fisher_projection = reshape(LDA_projected_state_means(3,:,state_index), [], 1);
        plot3(first_Fisher_projection, second_Fisher_projection, third_Fisher_projection, MarkersSymbols_plot{state_index}, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', MarkersColors_plot{state_index},'MarkerSize',16);
        hold on
    end
    leg = legend(plots,name_of_states{:});
    set(leg, 'Location', 'NorthEast');
    xlabel('First Fisher Direction');
    ylabel('Second Fisher Direction');
    zlabel('Third Fisher Direction');
    %%%% 2D plot (Second and third Fisher directions):
    figure;
    for state_index = 1:number_of_states
        second_Fisher_projection = reshape(LDA_projected_joints_of_specific_states{state_index}(2,:,:), [], 1);
        third_Fisher_projection = reshape(LDA_projected_joints_of_specific_states{state_index}(3,:,:), [], 1);
        plots(state_index) = plot(second_Fisher_projection, third_Fisher_projection, MarkersSymbols_plot{state_index}, 'MarkerEdgeColor', MarkersColors_plot{state_index}, 'MarkerFaceColor', MarkersColors_plot{state_index},'MarkerSize',9);
        hold on
    end
    % plot the mean of states:
    for state_index = 1:number_of_states
        second_Fisher_projection = reshape(LDA_projected_state_means(2,:,state_index), [], 1);
        third_Fisher_projection = reshape(LDA_projected_state_means(3,:,state_index), [], 1);
        plot(second_Fisher_projection, third_Fisher_projection, MarkersSymbols_plot{state_index}, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', MarkersColors_plot{state_index},'MarkerSize',16);
        hold on
    end
    leg = legend(plots,name_of_states{:});
    set(leg, 'Location', 'northeastoutside');
    xlabel('Second Fisher Direction');
    ylabel('Third Fisher Direction');

end