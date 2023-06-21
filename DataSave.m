% Save plots for angles to .dat separate files

% data files naming
baseFileName = 'saveData';

% number of plots to be saved
plotsNo = numel(g);

% get H data
plotDataH = tabH';

for i = 1:plotsNo
  % get g angle for a specific plot
  currDeg = g(i);
  % create file name based on the g angle
  currFileName = strcat(baseFileName,int2str(currDeg),'.dat');
  % get B data for specific g angle
  plotDataB = tabB(i,:)';
  plotData = [plotDataB, plotDataH];
  % detete old data and save a new file
  if isfile(currFileName)
    delete(currFileName);
  end
  dlmwrite(currFileName,plotData,'delimiter','\t','precision',4);
end
