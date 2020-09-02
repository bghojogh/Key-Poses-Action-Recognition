% help in code: http://stackoverflow.com/questions/21215352/how-to-avoid-displaying-zero-values-in-confusion-matrix

function plot_confusion_matrix(confusion_matrix, show_zeros, X_labels, Y_labels, number_of_actions, middleAccuracy, Color_type)

if Color_type == 1
    imagesc(1-confusion_matrix);            %# Create a colored plot of the matrix values
elseif Color_type == 2
    imagesc(confusion_matrix);            %# Create a colored plot of the matrix values
end
colormap(flipud(gray));  %# Change the colormap to gray (so higher values are
                         %#   black and lower values are white)

textStrings = num2str(confusion_matrix(:),'%0.2f');  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding

if show_zeros == 0
    idx = find(strcmp(textStrings(:), '0.00'));
    textStrings(idx) = {'   '};
end

[x,y] = meshgrid(1:number_of_actions);   %# Create x and y coordinates for the strings
hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
                'HorizontalAlignment','center');
%midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
midValue = middleAccuracy;
if Color_type == 1
    textColors = repmat(confusion_matrix(:) < midValue,1,3);  %# Choose white or black for the text color of the strings so they can be easily seen over the background color
elseif Color_type == 2
    textColors = repmat(confusion_matrix(:) > midValue,1,3);  %# Choose white or black for the text color of the strings so they can be easily seen over the background color
end

 
set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors

set(gca,'XTick',1:number_of_actions,...                         %# Change the axes tick marks
        'XTickLabel',X_labels,...  %#   and tick labels
        'YTick',1:number_of_actions,...
        'YTickLabel',Y_labels,...
        'TickLength',[0 0]);

end