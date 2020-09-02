function [estimated_class, distance_estimated_class, distances] = calculate_distance(LDA_projected_joints, LDA_projected_state_means, projected_means_of_classes, LDA_projected_states, covariance_matrix, const_cov, distance_type, use_manual_mahalanobis, number_of_states)

    for state_index = 1:number_of_states
        if distance_type == 1  %%% Euclidean distance
            distances(state_index,1) = Euclidean_distance(LDA_projected_joints', reshape(LDA_projected_state_means(:,:,state_index),1,[]));
        elseif distance_type == 2  %%% Mahalanobis distance
            if use_manual_mahalanobis == 1
                distances(state_index,1) = mahalanobis(LDA_projected_joints', projected_means_of_classes(state_index,:), covariance_matrix(:,:,state_index), const_cov);
            else
                distances(state_index,1) = mahal(LDA_projected_joints', LDA_projected_states{state_index}(:,:));
            end
        end
    end
    [~,index_sort_distance] = sort(distances);
    index_min_distance = index_sort_distance(1);
                        
    estimated_class = index_min_distance;
    distance_estimated_class = distances(index_min_distance);
                                
end