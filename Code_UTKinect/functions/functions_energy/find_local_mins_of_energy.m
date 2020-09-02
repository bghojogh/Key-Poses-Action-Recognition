function [energy_local_mins_value, energy_local_mins_index] = find_local_mins_of_energy(energy_of_frames, which_action, display_kinetic_energy_curve)
    %%%% find local minimums:
    [energy_local_mins_value, energy_local_mins_index] = findpeaks(-1 .* energy_of_frames);
    energy_local_mins_value = -1 .* energy_local_mins_value;
    if display_kinetic_energy_curve == 1
        if which_action == 1
            %%%% plot the energy curve:
            plot(energy_of_frames, 'LineWidth', 3);
            hold on
            %%%% plot the minimums of curve:
            plot(energy_local_mins_index, energy_of_frames(energy_local_mins_index), 'o', 'MarkerFaceColor', 'r');
            %%%% plot the dashed lines on minimums of curve:
            yLimits = get(gca,'YLim');  %% Get the range of the y axis
            plot([energy_local_mins_index, energy_local_mins_index], [yLimits(1), yLimits(2)], '--k');
            hold off
            input('Enter a key: ');
        end
    end
end