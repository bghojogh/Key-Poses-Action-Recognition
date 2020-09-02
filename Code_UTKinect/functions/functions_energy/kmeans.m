function vCenters = kmeans(vFeatures,k,numiter)

  nPoints  = size(vFeatures,1);
  nDims    = size(vFeatures,2);
  vCenters = zeros(k,nDims);

  % Initialize each cluster center to a different random point:
  %vCenters = round(10 + (20-10)*rand(k,nDims));  % random numbers between 10 and 20
  for dimension = 1:nDims
      min_limit = min(vFeatures(:,dimension));
      max_limit = max(vFeatures(:,dimension));
      vCenters(:,dimension) = round(min_limit + (max_limit - min_limit)*rand(k,1));  % random numbers between min_limit and max_limit
  end
  
  % Repeat for numiter iterations
  for i=1:numiter
    % Assign each point to the closest cluster
    %vCenters
    [Classes, ~] = findnn( vFeatures, vCenters );
    %Classes

    % Shift each cluster center to the mean of its assigned points
    vCenters = zeros(k,nDims);
    for c = 1:k          % iteration on classes
        counter = 0;
        for j = 1:nPoints    % iteration on featue vectors (points)
            if Classes(j) == c
                vCenters(c,:) = vCenters(c,:) + vFeatures(j,:);
                counter = counter + 1;
            end
        end
        if counter ~=0
            vCenters(c,:) = vCenters(c,:) ./ counter;
        end
    end
    
    %disp(strcat('K-means:',num2str(i),' from ',num2str(numiter),' iterations completed.'));
  end;
 
 
end
