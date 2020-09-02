function u_norm_LDA = Train_Forest_Fishers(test_person)

global index_of_states;
global number_of_states;
global number_of_state_samples;
global state;
global name_of_states;
global name_of_actions;
global joints_selected;
global number_of_selected_joints;
global do_subtract_from_total_mean;
global display_projected_LDA_mode;
global LDA_projected_joints_of_specific_states;
global project_of_means_MODE;
global distance_type;
global const_cov;
global use_manual_mahalanobis;
global LDA_projected_state_means;
global projected_means_of_classes;
global LDA_projected_states;
global covariance_matrix;
global distance_average_of_averages;
global confusion_matrix_trainStates;
global confusion_matrix_trainStates_minDistances;
global display_eigenvectors;

%% Loop for forest:
for forest_index = 1:number_of_states
    %% clear previous parameters:
    u_norm_LDA = [];
    LDA_projected_state_means = [];
    LDA_projected_joints_of_specific_states = [];
    LDA_projected_states = [];
    projected_means_of_classes = [];
    covariance_matrix = [];
    distance_average_of_averages = [];
    number_of_selected_joints = [];
    
    %% pick the selected joints:
    if forest_index ~= 1
        joints_selected = joints_selected_backup;
    end
    joints_selected_backup = joints_selected;
    temp = joints_selected{forest_index};
    joints_selected = temp;
    number_of_selected_joints = length(joints_selected) - 1;  % -1 because of removing hip joint
    
    %% preparing LDA data:
    joints_of_specific_states = cell(number_of_states,1);  % each cell contains a set of joints of one state. in each cell: 1st dimension is joints, 2nd dimension is (x,y,z), 3rd dimension is samples of states
    for state_index = 1:number_of_states
        joints_of_specific_states{state_index} = zeros(number_of_selected_joints,3,[]);
    end
    counter = 0;
    joints_stack = []; data_LDA = []; labels_LDA = [];
    for i = 1:number_of_state_samples
        if state(i,1) ~= test_person
            counter = counter + 1;

            which_person = state(i,1); which_performance = state(i,2); which_action = state(i,3); frame = state(i,4);
            joints = load_joints_and_align_them(which_person,which_performance,which_action,frame);

            joints_stack(:,:,counter) = joints;
            %%%% preparing LDA inputs:
            data_LDA(counter,:) = reshape(joints_stack(:,:,counter),1,[]);
            labels_LDA(counter,1) = state(i,5);
            joints_of_specific_states{labels_LDA(counter,1)}(:,:,end+1) = joints_stack(:,:,counter);
        end
    end

    %% Train LDA:
    train_joints_total_mean = mean(joints_stack,3);
    train_joints_state_mean = zeros(number_of_selected_joints,3,number_of_states);
    for state_index = 1:number_of_states
        train_joints_state_mean(:,:,state_index) = mean(joints_of_specific_states{state_index}, 3);
    end
    options = [];   
    [V,~] = LDA(labels_LDA,options,data_LDA);
    u_norm_LDA = V';

    %% projecting mean of states onto the Fisher LDA projection directions:
    for state_index = 1:number_of_states
        if do_subtract_from_total_mean == 1
            LDA_projected_state_means(:,:,state_index) = u_norm_LDA * reshape(train_joints_state_mean(:,:,state_index) - train_joints_total_mean,[],1);
        else
            LDA_projected_state_means(:,:,state_index) = u_norm_LDA * reshape(train_joints_state_mean(:,:,state_index),[],1);
        end
    end

    %% projecting state samples onto the Fisher LDA projection directions:
    LDA_projected_joints_of_specific_states = cell(number_of_states,1);  % each cell contains a set of joints of one state. in each cell: 1st and 2nd dimensions are projected joints, 3rd dimension is samples of states
    for state_index = 1:number_of_states
        LDA_projected_joints_of_specific_states{state_index} = zeros(size(u_norm_LDA,1),1,size(joints_of_specific_states{state_index},3));
    end
    for state_index = 1:number_of_states
        number_of_samples_of_states = size(joints_of_specific_states{state_index}(:,:,:),3);
        for state_sample = 1:number_of_samples_of_states
            if do_subtract_from_total_mean == 1
                LDA_projected_joints_of_specific_states{state_index}(:,:,state_sample) = u_norm_LDA * reshape(joints_of_specific_states{state_index}(:,:,state_sample) - train_joints_total_mean,[],1);
            else
                LDA_projected_joints_of_specific_states{state_index}(:,:,state_sample) = u_norm_LDA * reshape(joints_of_specific_states{state_index}(:,:,state_sample),[],1);
            end
        end
    end

    %% creatng LDA_projected_states (needed for mahalanobis):
    for state_index = 1:number_of_states
        number_of_samples_of_states = size(LDA_projected_joints_of_specific_states{state_index}(:,:,:),3);
        for state_sample = 1:number_of_samples_of_states
            %%%% LDA_projected_states: cell array (each cell is about a state)
            %%%% LDA_projected_states{state_index}: rows are state samples, columns are reshaped horizontal vector of "LDA_projected_joints_of_specific_states"
            LDA_projected_states{state_index}(state_sample,:) = reshape(LDA_projected_joints_of_specific_states{state_index}(:,:,state_sample),1,[]); 
        end
    end

    %% calculating: "projection of means of classes" + "covariance matices for mahalanobis":
    %%%% means:
    for state_index = 1:number_of_states
        if project_of_means_MODE == 1
            %%%% project of means:
            projected_means_of_classes(state_index,:) = reshape(LDA_projected_state_means(:,:,state_index),1,[]);
        elseif project_of_means_MODE == 2
            %%%% means of projected samples:
            projected_means_of_classes(state_index,:) = mean(LDA_projected_states{state_index}(:,:));
        end
    end
    %%%% covariance matrices:
    if distance_type == 2   %--> only needed for mahalanobis distance:
        for state_index = 1:number_of_states
            covariance_matrix(:,:,state_index) = cov(LDA_projected_states{state_index}(:,:));
        end
    else
        covariance_matrix = [];  %--> not important for Euclidean distance
    end

    %% calculating the average distance of train samples from the means of their class (needed for threshold in window):
    for state_index = 1:number_of_states
        number_of_samples_of_states = size(joints_of_specific_states{state_index}(:,:,:),3);
        distance = 0;
        for state_sample = 1:number_of_samples_of_states
            projected_sample = (LDA_projected_joints_of_specific_states{state_index}(:,:,state_sample))';
            if distance_type == 1  %%% Euclidean distance
                projected_mean_of_class = reshape(LDA_projected_state_means(:,:,state_index),1,[]);
                distance = distance + Euclidean_distance(projected_sample, projected_mean_of_class);
            elseif distance_type == 2  %%% Mahalanobis distance
                if use_manual_mahalanobis == 1
                    distance = distance + mahalanobis(projected_sample, projected_means_of_classes(state_index,:), covariance_matrix(:,:,state_index), const_cov);
                else
                    distance = distance + mahal(projected_sample, LDA_projected_states{state_index}(:,:));
                end
            end
        end
        distance_average(state_index) = distance / number_of_samples_of_states;
    end
    distance_average_of_averages = mean(distance_average);
    
    %% save the parameters of this iteration:
    u_norm_LDA_stack{forest_index} = u_norm_LDA;
    LDA_projected_state_means_stack{forest_index} = LDA_projected_state_means;
    LDA_projected_joints_of_specific_states_stack{forest_index} = LDA_projected_joints_of_specific_states;
    LDA_projected_states_stack{forest_index} = LDA_projected_states;
    projected_means_of_classes_stack{forest_index} = projected_means_of_classes;
    covariance_matrix_stack{forest_index} = covariance_matrix;
    distance_average_of_averages_stack{forest_index} = distance_average_of_averages;
    number_of_selected_joints_stack{forest_index} = number_of_selected_joints;
    
end

%% copy stacks back to parameters:
u_norm_LDA = u_norm_LDA_stack;
LDA_projected_state_means = LDA_projected_state_means_stack;
LDA_projected_joints_of_specific_states = LDA_projected_joints_of_specific_states_stack;
LDA_projected_states = LDA_projected_states_stack;
projected_means_of_classes = projected_means_of_classes_stack;
covariance_matrix = covariance_matrix_stack;
distance_average_of_averages = distance_average_of_averages_stack;
joints_selected = joints_selected_backup;
number_of_selected_joints = number_of_selected_joints_stack;

end
