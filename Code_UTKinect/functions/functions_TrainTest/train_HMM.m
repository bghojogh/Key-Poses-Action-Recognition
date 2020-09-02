function [E,P,Pi,Threshold] = train_HMM(HMM_labels,number_of_states,M,number_of_actions)
% %% initialize
% clc
% clear all
% close all

%%%%%%%%%%%%%%%%%%%input%%%%%%%%%%%%%%%
% number_of_state=8;
% M=[2;2;2;2;2;2;2;2];%sit grasp walk lay front back side endupsit
%HMM_labels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%number_of_actions=8;

N = number_of_states; % output 
LR = 2; % degree of play in the left-to-right HMM transition matrix 

%%  HMM
pP=cell([1,number_of_actions]);
E=cell([1,number_of_actions]);
P=cell([1,number_of_actions]);
Pi=cell([1,number_of_actions]);
ATrainBinned=cell([size(HMM_labels,3),1]);
Threshold=zeros(number_of_actions,1);

for action=1:number_of_actions

%     ATrainBinned={(reshape(HMM_labels(action,:,1),1,size(HMM_labels,2)))';};
            
    for performance = 1:length(HMM_labels{action})  % iteration on total performances of each action
          ATrainBinned{performance,1}=(reshape(HMM_labels{action}{performance}(:),1,[]))';
    end

%     ATrainBinned=ATrainBinned';


    % training
    pP{action} = prior_transition_matrix(M(action,1),LR);

    % Train the model:
    cyc = 50;
    [E{action},P{action},Pi{action},~] = dhmm_numeric(ATrainBinned,pP{action},[1:N]',M(action,1),cyc,.00001);
    sumLik = 0;
    minLik = Inf;
    for j=1:length(ATrainBinned)
        lik = pr_hmm(ATrainBinned{j},P{action},E{action}',Pi{action});
        if (lik < minLik)
            minLik = lik;
        end
        sumLik = sumLik + lik;
    end
    
    Threshold(action,1) = 2.0*sumLik/length(ATrainBinned);

end
                          
    
    
end
