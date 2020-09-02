function [estimated_class, distance_estimated_class] = project_on_Forest_Fishers(u_norm_LDA, which_person,which_performance,which_action,frame)
    
global do_subtract_from_total_mean;
global joints_selected;
global number_of_selected_joints;
global LDA_projected_state_means;
global projected_means_of_classes;
global LDA_projected_states;
global covariance_matrix;
global const_cov;
global distance_type;
global use_manual_mahalanobis;
global number_of_states;
global decision_in_Forest_Fishers_mode;
global distance_average_of_averages;

%% Backing up parameters of forest:
joints_selected_backup = joints_selected;
number_of_selected_joints_backup = number_of_selected_joints;
u_norm_LDA_backup = u_norm_LDA;
LDA_projected_state_means_backup = LDA_projected_state_means;
projected_means_of_classes_backup = projected_means_of_classes;
LDA_projected_states_backup = LDA_projected_states;
covariance_matrix_backup = covariance_matrix;

%% Loop for forest:
for forest_index = 1:number_of_states
    %% pick the parameters for this Fisher in forest:
    temp = joints_selected{forest_index};
    joints_selected = temp;
    temp = number_of_selected_joints{forest_index};
    number_of_selected_joints = temp;
    temp = u_norm_LDA{forest_index};
    u_norm_LDA = temp;
    temp = LDA_projected_state_means{forest_index};
    LDA_projected_state_means = temp;
    temp = projected_means_of_classes{forest_index};
    projected_means_of_classes = temp;
    temp = LDA_projected_states{forest_index};
    LDA_projected_states = temp;
    temp = covariance_matrix{forest_index};
    covariance_matrix = temp;
    
    %% project and find min distance:
    %%%% load joints:
    joints = load_joints_and_align_them(which_person,which_performance,which_action,frame);
    %%%% projecting frame samples onto the Fisher LDA projection directions:
    if do_subtract_from_total_mean == 1
        LDA_projected_joints = u_norm_LDA * reshape(joints - train_joints_total_mean,[],1);
    else
        LDA_projected_joints = u_norm_LDA * reshape(joints,[],1);
    end
    %%%% distance between projected joints and classes:
    [estimated_class(forest_index), distance_estimated_class(forest_index), ~] = calculate_distance(LDA_projected_joints, LDA_projected_state_means, projected_means_of_classes, LDA_projected_states, covariance_matrix, const_cov, distance_type, use_manual_mahalanobis, number_of_states);
    
    %%%% find the normalized distances:
    project_train_samples = LDA_projected_states{estimated_class(forest_index)};
    project_train_samples_mean = mean(project_train_samples,1);
    for i = 1:size(project_train_samples,1)
        d(i,1) = Euclidean_distance(project_train_samples(i,:), project_train_samples_mean);
    end
    variance_of_winner_class(forest_index) = sum(d) / length(d);
    
%     var(LDA_projected_states{estimated_class(forest_index)},0,2)
%     variance_of_winner_class(forest_index,1) = var(LDA_projected_states{estimated_class(forest_index)},0,2);
    normalized_distance_estimated_class(forest_index) = distance_estimated_class(forest_index) / variance_of_winner_class(forest_index);
    
    %% copy the parameters back:
    joints_selected = joints_selected_backup;
    number_of_selected_joints = number_of_selected_joints_backup;
    u_norm_LDA = u_norm_LDA_backup;
    LDA_projected_state_means = LDA_projected_state_means_backup;
    projected_means_of_classes = projected_means_of_classes_backup;
    LDA_projected_states = LDA_projected_states_backup;
    covariance_matrix = covariance_matrix_backup;
    
end

%% decide between forest Fishers:
if decision_in_Forest_Fishers_mode == 1   % simple voting
    COUNT = countmember(1:number_of_states,estimated_class);
    [~, index_max] = max(COUNT);
    winner_class = index_max;
    indexes_of_winner = find(estimated_class == winner_class);
    %distance_winner_class = mean(distance_estimated_class(indexes_of_winner));
    distance_winner_class = mean(normalized_distance_estimated_class(indexes_of_winner));
elseif decision_in_Forest_Fishers_mode == 2   % using confidence_factor
    Fishers_valid_in_decision = find(estimated_class == 1:number_of_states);  % Fishers which are related to their pose
    if isempty(Fishers_valid_in_decision)
        Fishers_valid_in_decision = 1:number_of_states;  % we have to consider all of them, with reluctance
    end
    %[min_distance,min_index] = min(distance_estimated_class(Fishers_valid_in_decision));
    [min_distance,min_index] = min(normalized_distance_estimated_class(Fishers_valid_in_decision));
    winner_class = Fishers_valid_in_decision(min_index);
    distance_winner_class = min_distance;
end
estimated_class = [];
distance_estimated_class = [];
estimated_class = winner_class;
distance_estimated_class = distance_winner_class;
temp = distance_average_of_averages{winner_class};
distance_average_of_averages = temp;

end
