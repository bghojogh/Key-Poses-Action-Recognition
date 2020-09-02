function MakeTableGUI(Actions, Rates)

%// Create figure and uielements
handles.fig = figure();

%// Create table
handles.T = table(Rates,'RowNames',Actions);

t = uitable(handles.fig,'Data',handles.T{:,:},'ColumnWidth',{50},'ColumnName',{'Rates'},...
        'RowName',Actions);

%%% set the width and height of the uitable to match the size of the enclosing rectangle:
t.Position(3) = t.Extent(3);
t.Position(4) = t.Extent(4);

fgcolor = t.ForegroundColor;
t.ForegroundColor = [0 0 0];

cd('saved_files')
saveas(handles.fig, './Rate_table.jpg');
cd('..')

end

%%%% http://stackoverflow.com/questions/29701289/is-there-a-simple-way-to-display-table-in-matlab-gui