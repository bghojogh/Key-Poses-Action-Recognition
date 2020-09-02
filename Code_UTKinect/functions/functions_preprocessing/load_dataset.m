function [ skeleton,number_of_samples,action_length,joint_num,joint_pair,joint_pair_begin,joint_pair_end,base_joint_center,base_joint_left,base_joint_right ] = load_dataset( dataset_idx )

    % load or reload dataset, 0:load dataset, 1:reload dataset(time consuming)
    reload_idx=0;
    
    % load skeleton matrix from database
    switch dataset_idx
        case 1
            path='C:\MATLAB\Dataset\TST\Data';
            base_joint_center=1;
            base_joint_left=5;
            base_joint_right=9;
            joint_pair_begin=[1,5,6,8,14,16];
            joint_pair_end=[4,9,10,12,18,20];
%             joint_num=[4,8,12,14,16,18,20];
            joint_num=1:20;
            [skeleton,number_of_samples,action_length]=load_TST_dataset(path,reload_idx);
    
        case 2
            path='C:\MATLAB\Dataset\UTKinect\Data';
            base_joint_center=1;
            base_joint_left=5;
            base_joint_right=9;
            joint_pair=[ 1  2  3  3  3  5  6  7  9 10 11  1  1 13 14 15 17 18 19;
                         2  3  4  5  9  6  7  8 10 11 12 13 17 14 15 16 18 19 20];
            joint_pair_begin=[6,8,14,16];
            joint_pair_end=[10,12,18,20];
%             joint_num=[4,8,12,14,16,18,20];
            joint_num=1:20;
            [skeleton,number_of_samples,action_length]=load_UTKinect_dataset(path,reload_idx);
    
        case 3
            path='C:\MATLAB\Dataset\UCFKinect\Data';
            base_joint_center=3;
            base_joint_left=4;
            base_joint_right=7;  %6;
            joint_pair=[];  % not necessary
            joint_pair_begin=[1,4,5,9,12,14];
            joint_pair_end=[3,6,7,11,13,15];
%             joint_num=[1,5,7,9,11,12,13,14,15];
            joint_num=1:15;
            [skeleton,number_of_samples,action_length]=load_UCFKinect_dataset(path,reload_idx);
     
        case 4
            path='C:\MATLAB\Dataset\MSRDailyActivity\Data';
            base_joint_center=1;
            base_joint_left=5;
            base_joint_right=9;
            joint_pair=[ 1  2  3  3  3  5  6  7  9 10 11  1  1 13 14 15 17 18 19;
                         2  3  4  5  9  6  7  8 10 11 12 13 17 14 15 16 18 19 20];
            joint_pair_begin=[1,5,6,8,14,16];
            joint_pair_end=[4,9,10,12,18,20];
%             joint_num=[4,8,12,14,16,18,20];
            joint_num=1:20;
            [skeleton,number_of_samples,action_length]=load_MSRDailyActivity_dataset(path,reload_idx);
        
        case {5,6,7,8,9,10}
            dataset_idx = dataset_idx-4;
            path='C:\MATLAB\Dataset\CAD 60\Data';
            base_joint_center=3;
            base_joint_left=4;
            base_joint_right=6;
            joint_pair=[1  2  2  2  4  5  6  7  3  3  8 10  9 11;
                        2  3  4  6  5 12  7 13  8 10  9 11 14 15];
            joint_pair_begin=[1,4,5,9,12,14];
            joint_pair_end=[3,6,7,11,13,15];
%             joint_num=[1,12,13,14,15];
            joint_num=1:15;
            [skeleton,number_of_samples,action_length]=load_CAD_dataset(dataset_idx,path,reload_idx);
            
        case 11
            path='C:\MATLAB\Dataset\Florence3D\';
            base_joint_center=3;
            base_joint_left=4;
            base_joint_right=7;
            joint_pair=[1  2  2  2  4  5  7  8  3  3 10 11 13 14;
                        2  3  4  7  5  6  8  9 10 13 11 12 14 15];
            joint_pair_begin=[5,6,11,12];
            joint_pair_end=[8,9,14,15];
%             joint_num=[4,8,12,14,16,18,20];
            joint_num=1:15;
            [skeleton,number_of_samples,action_length]=load_Florence3D_dataset(path,reload_idx);
        
        case {12,13,14,15}
            dataset_idx = dataset_idx-11;
            path='C:\MATLAB\Dataset\MSRAction3D\';
            base_joint_center=7;
            base_joint_left=1;
            base_joint_right=2;
            joint_pair=[20  1  2  1  8 10  2  9 11  3  4  7  7  5  6 14 15 16 17;
                         3  3  3  8 10 12  9 11 13  4  7  5  6 14 15 16 17 18 19];
%             joint_pair_begin=[8,10,14,16];
%             joint_pair_end=[9,11,15,17];
            joint_pair_begin=[10,11];
            joint_pair_end=[3,3];
%             joint_num=[10,11,16,17,20];
            joint_num=1:20;
            [skeleton,number_of_samples,action_length]=load_MSRAction3D_dataset(dataset_idx,path,reload_idx);
  
    end
    
end
