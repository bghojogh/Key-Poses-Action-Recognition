function plot_LDA_projected_states_AndTestProjected(LDA_projected_joints_of_specific_states, number_of_states, name_of_states, LDA_projected_state_means, LDA_projected_joints_test, index_min_distance, frame, name_of_actions, which_action)

    plots = zeros(number_of_states,1);
    MarkersSymbols_plot = {'v', 's', 'd', '^', 'p', 'h', 'o', '>', '<', 'o', 'd'};
    MarkersColors_plot = {[1,1,0], [1,0,1], [0,1,1], [1,0,0], [1,0.5,0], [0,0,1], [0.6,0.4,0.7], [0,1,0], [0.6,0.5,0.3], [1,0,0.5], [0,0,0]};
    %%%% 2D plot:
    for state_index = 1:number_of_states
        first_Fisher_projection = reshape(LDA_projected_joints_of_specific_states{state_index}(1,:,:), [], 1);
        second_Fisher_projection = reshape(LDA_projected_joints_of_specific_states{state_index}(2,:,:), [], 1);
        plots(state_index) = plot(first_Fisher_projection, second_Fisher_projection, MarkersSymbols_plot{state_index}, 'MarkerEdgeColor', MarkersColors_plot{state_index}, 'MarkerFaceColor', MarkersColors_plot{state_index},'MarkerSize',9);
        hold on
    end
    % plot the mean of states:
    for state_index = 1:number_of_states
        first_Fisher_projection_mean(state_index) = reshape(LDA_projected_state_means(1,:,state_index), [], 1);
        second_Fisher_projection_mean(state_index) = reshape(LDA_projected_state_means(2,:,state_index), [], 1);
        plot(first_Fisher_projection_mean(state_index), second_Fisher_projection_mean(state_index), MarkersSymbols_plot{state_index}, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', MarkersColors_plot{state_index},'MarkerSize',16);
        hold on
    end
    % plot the test projected on LDA space:
    first_Fisher_projection_test = reshape(LDA_projected_joints_test(1), [], 1);
    second_Fisher_projection_test = reshape(LDA_projected_joints_test(2), [], 1);
    plot(first_Fisher_projection_test, second_Fisher_projection_test, '*', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b','MarkerSize',10);
    % plot the lines between test projected point and the train mean projected points:
    for state_index = 1:number_of_states
        X = [first_Fisher_projection_mean(state_index), first_Fisher_projection_test];
        Y = [second_Fisher_projection_mean(state_index), second_Fisher_projection_test];
        plot(X, Y, '--', 'MarkerEdgeColor', 'k');
        hold on
    end
    
%     leg = legend(plots,name_of_states{:});
%     set(leg, 'Location', 'NorthWest');
    xlabel('First Fisher Direction');
    ylabel('Second Fisher Direction');
    
    % title:
    str = sprintf('Action: %s  |  Frame %d  |  State %d (%s)', name_of_actions{which_action}, frame, index_min_distance, name_of_states{index_min_distance});
    title(str);
    
end