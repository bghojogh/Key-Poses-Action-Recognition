function [index_of_states, number_of_states, number_of_state_samples, state, name_of_states, name_of_actions, name_of_actions_withoutNumber, cluster_centers] = determine_train_state_samples_AUTOMATIC()
    %%%% guide: state(i,:) --> [which_person,which_performance,which_action,frame,state_index]
    
    %%
    global number_of_actions;
    global number_of_persons;
    global number_of_samples;
    global show_lines_between_joints;
    global display_cluster_centers;
    global display_nonEmpty_cluster_centers;
    global number_of_clusters;
    global number_of_Kmeans_itertions;
    global number_of_repeating_clustering;
    global type_of_choosing_best_clustering;
    global load_clustering_files;
    
    %% find the key-frames (key-poses):
    if load_clustering_files == 0
        counter = 1;
        for which_person = 1:number_of_persons
            for which_action = 1:number_of_actions
                number_of_performances = number_of_samples(which_person,which_action);
                for which_performance = 1:number_of_performances
                    consider_first_frame_in_emptySequences = 0;
                    key_frames = find_key_frames(which_person,which_performance,which_action,consider_first_frame_in_emptySequences);
                    for frame = key_frames
                        key_frames_total(counter,:) = [which_person,which_performance,which_action,frame];
                        %%%% skeletons in key frames:
                        joints = load_joints_and_align_them(which_person,which_performance,which_action,frame);
                        skeleton_of_key_frames_total(counter,:) = reshape(joints,1,[]);
                        counter = counter + 1;
                    end
                end
            end
        end
    else
        cd('saved_files')
        load key_frames_total.mat
        load cluster_centers.mat
        load state.mat
        cd('..')
        for i = 1:size(key_frames_total,1)
            which_person = key_frames_total(i,1);
            which_performance = key_frames_total(i,2);
            which_action = key_frames_total(i,3);
            frame = key_frames_total(i,4);
            %%%% skeleton in the key frame:
            joints = load_joints_and_align_them(which_person,which_performance,which_action,frame);
            skeleton_of_key_frames_total(i,:) = reshape(joints,1,[]);
        end
    end
    
    %% do clustering for several iterations (with different initials):
    if load_clustering_files == 0
        for iteration = 1:number_of_repeating_clustering
            str = sprintf('Clustering iteration #%d out of %d iterations...', iteration, number_of_repeating_clustering);
            disp(str);

            %% cluster the key-poses (find center of clusters):
            k = number_of_clusters;  %% number of clusters
            numiter = number_of_Kmeans_itertions;    %% number of iterations in k-means
            vFeatures = skeleton_of_key_frames_total;
            cluster_centers = kmeans(vFeatures,k,numiter);

            %% remove dummy clusters (clusters with centers totally zero):
            temp = [];
            counter = 1;
            for i = 1:size(cluster_centers,1)
                if cluster_centers(i,:) ~= zeros(1,size(cluster_centers,2))
                    temp(counter,:) = cluster_centers(i,:);
                    counter = counter + 1;
                end
            end
            cluster_centers = temp;

            %% display the skeletons of cluster centers:
            if display_cluster_centers == 1
                for cluster_index = 1:size(cluster_centers,1)
                    joints = reshape(cluster_centers(cluster_index,:),[],3);
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
                    zlim([-2500, 1500]);
                    xlabel('x'); ylabel('z'); zlabel('y');
                    hold off
                end
                input('Enter a key: ');
            end

            %% cluster the key-poses (find cluster members):
            for i = 1:size(key_frames_total,1)
                which_person = key_frames_total(i,1);
                which_performance = key_frames_total(i,2);
                which_action = key_frames_total(i,3);
                frame = key_frames_total(i,4);
                %%%% skeleton in the key frame:
                joints = load_joints_and_align_them(which_person,which_performance,which_action,frame);
                %%%% find the cluster of the key-point:
                [cluster, distance] = findnn( reshape(joints,1,[]), cluster_centers );
                %%%% create the state (pose) array:
                state(i,:) = [which_person,which_performance,which_action,frame,cluster];
                %%%% total error of the clustering:
                distances_from_clusterCenters(i,1) = distance;
            end

            %% sort the matrix "state" according to its column 5:
            state = sortrows(state,5);

            %% remove the clusters with no members:
            counter = 1;
            state_with_no_empty_cluster = state;
            state_backup = state;
            for i = 1:size(state,1)
                cluster_index = state(i,5);
                if i ~= 1
                    previous_cluster_index = state(i-1,5);
                    if cluster_index ~= previous_cluster_index
                        counter = counter + 1;
                    end
                end
                state_with_no_empty_cluster(i,:) = [state(i,1:4), counter];
            end
            state = state_with_no_empty_cluster;

            temp = []; counter = 1;
            for cluster_index = 1:length(cluster_centers)
                if ~isempty(find(state(:,5) == cluster_index, 1))
                    temp(counter,:) = cluster_centers(cluster_index,:);
                    counter = counter + 1;
                end
            end
            cluster_centers = temp;

            %% save parameters of this iteration:
            clustering_error_itertions(iteration) = sum(distances_from_clusterCenters);
            state_itertions{iteration} = state;
            cluster_centers_itertions{iteration} = cluster_centers;
            
            %% find the scatter of clusters:
            if type_of_choosing_best_clustering == 2
                mean_of_cluster_centers = mean(cluster_centers,1);
                S_b = zeros(size(cluster_centers,2), size(cluster_centers,2));
                for cluster_index = 1:size(cluster_centers,1)
                    corresponding_samples_in_state = find(state(:,5) == cluster_index);
                    temp = [];
                    S_w = zeros(size(cluster_centers,2), size(cluster_centers,2));
                    for sample_index = corresponding_samples_in_state'
                        which_person = state(sample_index,1);
                        which_performance = state(sample_index,2);
                        which_action = state(sample_index,3);
                        frame = state(sample_index,4);
                        %%%% skeleton in the key frame:
                        joints = load_joints_and_align_them(which_person,which_performance,which_action,frame);
                        joints = reshape(joints,1,[])';
                        temp = joints - cluster_centers(cluster_index,:)';
                        S_w = S_w + (temp * temp');
                    end
                    [~,eigenvalue_matrix] = eig(S_w);
                    sum_eigenvalues_Sw_a_cluster(cluster_index) = trace(eigenvalue_matrix);
                    temp = cluster_centers(cluster_index,:)' - mean_of_cluster_centers';
                    S_b = S_b + (temp * temp');
                end
                sum_eigenvalues_Sw_all_cluster = sum(sum_eigenvalues_Sw_a_cluster);
                [~,eigenvalue_matrix] = eig(S_b);
                sum_eigenvalues_Sb = trace(eigenvalue_matrix);
                criterion(iteration) = sum_eigenvalues_Sb / sum_eigenvalues_Sw_all_cluster;
            end
        end
        %%%% choose the best clustering:
        if type_of_choosing_best_clustering == 1
            %%%% choose the clustering with minimum error:
            [~,index_min_error] = min(clustering_error_itertions);
            state = state_itertions{index_min_error};
            cluster_centers = cluster_centers_itertions{index_min_error};
        elseif type_of_choosing_best_clustering == 2
            %%%% choose the clustering with maximum amount of the criterion:
            [~,index_max_criterion] = max(criterion);
            state = state_itertions{index_max_criterion};
            cluster_centers = cluster_centers_itertions{index_max_criterion};
        end
    end
    str = sprintf('Number of pure extracted clusters: #%d', size(cluster_centers,1));
    disp(str);
    
    %% display the skeletons of non-empty cluster centers:
    if display_nonEmpty_cluster_centers == 1
        for cluster_index = 1:size(cluster_centers,1)
            joints = reshape(cluster_centers(cluster_index,:),[],3);
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
            zlim([-2500, 1500]);
            xlabel('x'); ylabel('z'); zlabel('y');
            hold off
        end
        input('Enter a key: ');
    end
    
    %% name of states:
    name_of_states = {'Stand', 'Sit', 'Bend', 'Hands together front', 'Start throwing', 'Hand near shoulder', 'Hand straight front', 'Cross', 'Hands up', 'Hands open front'};
    
    %% name of actions:
    name_of_actions = {'(1) Walk';'(2) Sit Down';'(3) Stand Up';'(4) Pick Up';'(5) Carry'; '(6) Throw'; '(7) Push'; '(8) Pull'; '(9) Wave Hands'; '(10) Clap Hands'};
    name_of_actions_withoutNumber = {'Walk';'Sit Down';'Stand Up';'Pick Up';'Carry'; 'Throw'; 'Push'; 'Pull'; 'Wave Hands'; 'Clap Hands'};
    
    %%
    index_of_states = unique(state(:,5));
    number_of_states = length(index_of_states);
    number_of_state_samples = size(state,1);
    
    %% save files:
    cd('saved_files')
    save key_frames_total.mat key_frames_total
    %save skeleton_of_key_frames_total.mat skeleton_of_key_frames_total
    save cluster_centers.mat cluster_centers
    save state.mat state
    save number_of_clusters.mat number_of_clusters
    save number_of_Kmeans_itertions.mat number_of_Kmeans_itertions
    save number_of_repeating_clustering.mat number_of_repeating_clustering
    cd('..')
    
    
    
end

