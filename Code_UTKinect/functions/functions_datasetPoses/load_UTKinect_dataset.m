function [ complete_skeleton,number_of_samples,action_length ] = load_UTKinect_dataset( path,reload )
    if reload==0
        % load skeleton with all available data from a mat file
        disp('Loading Dataset...');
        
        cd('dataset')
        load('UTKinect.mat','complete_skeleton','action_length','number_of_folders','number_of_tests','number_of_actions','number_of_joints','number_of_dimensions','scale_factor');
        cd('..')
        
    elseif reload==1
        % save skeleton with all available data in a mat file
        disp('Reloading Dataset...');
        
        % dataset parameters
        number_of_folders=10;
        number_of_tests=2;
        ActionName={'walk','sitDown','standUp','pickUp','carry','throw','push','pull','waveHands','clapHands'};
        number_of_actions=size(ActionName,2);
        number_of_joints=20;
        number_of_dimensions=3;
        scale_factor=100;
        
        complete_skeleton = zeros(number_of_folders,number_of_tests,number_of_actions,[],number_of_joints,number_of_dimensions);
        action_length = zeros(number_of_folders,number_of_tests,number_of_actions);
        for folder_idx = 1:number_of_folders
            for test_idx = 1:number_of_tests
                % read frame numbers file
                frameNumAddress=strcat(path,num2str(folder_idx),'\',num2str(test_idx),'\','frame_num.txt');
                frame_numbers=dlmread(frameNumAddress);
                % read skeleton file
                dataAddress=strcat(path,num2str(folder_idx),'\',num2str(test_idx),'\','skeleton.txt');
                data=dlmread(dataAddress);
                
                for actionName = ActionName
                    if strcmp(actionName,'walk')
                        action_idx=1;
                    elseif strcmp(actionName,'sitDown')
                        action_idx=2;
                    elseif strcmp(actionName,'standUp')
                        action_idx=3;
                    elseif strcmp(actionName,'pickUp')
                        action_idx=4;
                    elseif strcmp(actionName,'carry')
                        action_idx=5;
                    elseif strcmp(actionName,'throw')
                        action_idx=6;
                    elseif strcmp(actionName,'push')
                        action_idx=7;
                    elseif strcmp(actionName,'pull')
                        action_idx=8;
                    elseif strcmp(actionName,'waveHands')
                        action_idx=9;
                    elseif strcmp(actionName,'clapHands')
                        action_idx=10;
                    end

                    first_frame=frame_numbers(action_idx,1);
                    last_frame=frame_numbers(action_idx,2);
                    
                    jMat = zeros([],number_of_joints,number_of_dimensions);
                    number_of_frames=0;
                    for i=1:size(data,1)
                        if (data(i,1)>=first_frame) && (data(i,1)<=last_frame)
                            number_of_frames=number_of_frames+1;
                            jMat(number_of_frames,:,:)=reshape(data(i,2:size(data,2)),number_of_dimensions,number_of_joints)';
                        end
                    end
                    
                    % number of frames
                    NumFrameSkelSpace=size(jMat,1);
                    
                    % skeleton matrix
                    complete_skeleton(folder_idx,test_idx,action_idx,1:NumFrameSkelSpace,:,:)=jMat;

                    % action length matrix
                    action_length(folder_idx,test_idx,action_idx)=NumFrameSkelSpace;
                    
                end
            end
        end
                        
        cd('dataset')
        save('UTKinect.mat','complete_skeleton','action_length','number_of_folders','number_of_tests','number_of_actions','number_of_joints','number_of_dimensions','scale_factor');
        cd('..')
    end

    number_of_samples = zeros(size(complete_skeleton,1),size(complete_skeleton,3));
    for folder_idx = 1:size(complete_skeleton,1)
        for action_idx = 1:size(complete_skeleton,3)
            number_of_samples(folder_idx,action_idx) = size(complete_skeleton,2);
        end
    end
    
    complete_skeleton = complete_skeleton .* scale_factor;
    
end
