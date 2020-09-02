function [Histogram_1D, Histogram_2D] = Calculate_Histogram(vector)

global align_motions_to_one_plane;
global normalize_histogram;
global alpha_bins; global theta_bins;

%% Calculate the spherical coordinates:
alpha = myatand(vector(:,1),vector(:,3));  % notice: output of function myatand is in limit [0,360]
% if alpha >= 180   % making alpha limit as [-180,180] rather than [0,360]
%     alpha = alpha - 360;
% end
t = sqrt(vector(:,1).^2+vector(:,3).^2);
theta = myatand(vector(:,2),t);
r = sqrt(vector(:,2).^2+t.^2);

%% Calculate the histogram:
if align_motions_to_one_plane == 0
    Histogram_2D = zeros(length(alpha_bins),length(theta_bins)-1);
else
    Histogram_2D = zeros(length(theta_bins)-1,1);
end
for vector_index = 1:size(vector,1)
    if align_motions_to_one_plane == 0
        for alpha_bin_index = 1:length(alpha_bins)
            if alpha_bin_index ~= length(alpha_bins)
                if (alpha(vector_index) >= alpha_bins(alpha_bin_index) && alpha(vector_index) < alpha_bins(alpha_bin_index+1))
                    hist_bin_dim1 = alpha_bin_index;
                end
            else
                if (alpha(vector_index) >= alpha_bins(alpha_bin_index) || alpha(vector_index) < alpha_bins(1))
                    hist_bin_dim1 = alpha_bin_index;
                end
            end
        end
        for theta_bin_index = 1:length(theta_bins)-1
            if theta_bin_index ~= length(theta_bins)-1
                if (theta(vector_index) >= theta_bins(theta_bin_index) && theta(vector_index) < theta_bins(theta_bin_index+1))
                    hist_bin_dim2 = theta_bin_index;
                end
            else
                if (theta(vector_index) >= theta_bins(theta_bin_index) && theta(vector_index) <= theta_bins(end))
                    hist_bin_dim2 = theta_bin_index;
                end
            end
        end
        Histogram_2D(hist_bin_dim1, hist_bin_dim2) = Histogram_2D(hist_bin_dim1, hist_bin_dim2) + (1*r(vector_index));
    else
        for theta_bin_index = 1:length(theta_bins)-1
            if theta_bin_index ~= length(theta_bins)-1
                if (theta(vector_index) >= theta_bins(theta_bin_index) && theta(vector_index) < theta_bins(theta_bin_index+1))
                    hist_bin_dim2 = theta_bin_index;
                end
            else
                if (theta(vector_index) >= theta_bins(theta_bin_index) && theta(vector_index) <= theta_bins(end))
                    hist_bin_dim2 = theta_bin_index;
                end
            end
        end
        Histogram_2D(hist_bin_dim2, 1) = Histogram_2D(hist_bin_dim2, 1) + (1*r(vector_index));
    end
end

%%%% 1D histogram:
Histogram_1D = reshape(Histogram_2D', [], 1);
Histogram_1D_backup = Histogram_1D;

%%%% normalize the histogram:
if normalize_histogram == 1
    Histogram_1D = Histogram_1D ./ sqrt(sum(Histogram_1D_backup .^ 2));
    Histogram_2D = Histogram_2D ./ sqrt(sum(Histogram_1D_backup .^ 2));
end

end