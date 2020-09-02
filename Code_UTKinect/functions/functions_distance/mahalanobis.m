function distance = mahalanobis(LDA_projected_joints, projected_means_of_classes, covariance_matrix, const_cov)
    mu = projected_means_of_classes;
    sigma = covariance_matrix;
    %distance = (LDA_projected_joints - mu) * inv(sigma + const_cov.*eye(size(sigma))) * (LDA_projected_joints - mu)';
    %distance = (LDA_projected_joints - mu) * inv(sigma + const_cov.*eye(size(sigma))) * (LDA_projected_joints - mu)' + log(det(sigma + const_cov.*eye(size(sigma))));
    %distance = sqrt((LDA_projected_joints - mu) * inv(sigma + const_cov.*eye(size(sigma))) * (LDA_projected_joints - mu)' + log(det(sigma)));
    
    distance = (LDA_projected_joints - mu) * inv(sigma + const_cov.*eye(size(sigma))) * (LDA_projected_joints - mu)';
    
%     (LDA_projected_joints - mu) * inv(sigma + const_cov.*eye(size(sigma))) * (LDA_projected_joints - mu)'
%     log(det(sigma))
%     '**************************'
end