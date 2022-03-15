function [contourTable, contourArray] = getContourLineCoordinates(cm)
% Extracts coordinates from contour lines created by contour plots.
%
% contourTable = getContourLineCoordinates(cm) creates an nx4 table
% showing the contour level, contour group number, x, and y coordinates
% from the contour lines.  cm is a 2xm matrix produced by contour
% functions.
%
% contourTable = getContourLineCoordinates(h) does the same thing but
% receives as input the contour object handle.
%
% [contourTable, contourArray] = getContourLineCoordinates(__) returns a 
% 1xk cell array containing nx2 matrices of the [x,y] values listed in 
% contourTable for all k levels.  
% 
% Example 1: Plot 1 level
%     % Create contour plot
%     [X,Y,Z] = peaks;
%     [cm, h] = contourf(X,Y,Z,20);
%     % Get contour line coordinates
%     contourTable = getContourLineCoordinates(cm);
%     % Show all lines that match the 7th level
%     hold on
%     levelIdx = contourTable.Level == h.LevelList(7);
%     plot(contourTable.X(levelIdx), contourTable.Y(levelIdx), 'r.', 'MarkerSize', 10)
%
% Example 2: Plot all contour lines using either output
%     % Create contour plot
%     [X,Y,Z] = peaks;
%     [cm, h] = contourf(X,Y,Z,20);
%     % Get contour line coordinates
%     [contourTable,contourArray] = getContourLineCoordinates(cm);
%     % Recreate all contour lines
%     figure();
%     subplot(1,2,1); title('Using table output #1'); hold on
%     splitapply(@(x,y)plot(x,y,'-'),contourTable.X, contourTable.Y, contourTable.Group)
%     subplot(1,2,2); title('Using Cell array output #2'); hold on
%     cellfun(@(m)plot(m(:,1),m(:,2),'-'),contourArray)
%
% Source: <a href = "https://www.mathworks.com/matlabcentral/fileexchange/74010-getcontourlinecoordinates">getContourLineCoord​inates</a>
% Copyright (c) 2020, Adam Danz  
% All rights reserved
% Change history
% vs 1.0.0	200123  Uploaded to file exchange
% vs 1.1.0  200514  removed sortrows() from contourTable so (x,y) are in proper order. 
%                   Added Example 2 & improved documentation.
% Determine if input is handle or matrix; get matrix.
if ishandle(cm)
    cm = cm.ContourMatrix;
end
% Set up while loop
cmSize = size(cm,2);   	% number of columns in ContourMatrix
cmWindow = [0,0];      	% [start,end] index of moving window
contourArray = {};     	% Store the (x,y) coordinates of each contour line
% Extract coordinates of each contour line
while cmWindow(2) < cmSize
    cmWindow(1) = cmWindow(2) + 1;
    cmWindow(2) = cmWindow(2) + cm(2,cmWindow(1)) + 1;
    contourArray(end+1) = {cm(:,cmWindow(1):cmWindow(2)).'};  %#ok<AGROW>
end
% Separate the level, count, and coordinates.
level = cellfun(@(c)c(1,1),contourArray).';
numCoord = cellfun(@(c)c(1,2),contourArray).';
contourArray = cellfun(@(c)c(2:end,:),contourArray,'UniformOutput',false);
% Sort by level (just in case Matlab doesn't)
[~,sortIdx] = sort(level);
% Create a table with combined coordinates from all levels and grouping variable
levelsRep = cell2mat(arrayfun(@(v,n)repmat(v,n,1),level(sortIdx),numCoord(sortIdx),...
    'UniformOutput',false));
group = cell2mat(arrayfun(@(v,n)repmat(v,n,1),(1:numel(level)).',numCoord,...
    'UniformOutput',false));
contourTable = array2table([levelsRep, group, vertcat(contourArray{sortIdx})],...
    'VariableNames',{'Level','Group','X','Y'});
% Copyright (c) 2020, Adam Danz
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% * Redistributions of source code must retain the above copyright notice, this
% list of conditions and the following disclaimer.
%
% * Redistributions in binary form must reproduce the above copyright notice,
% this list of conditions and the following disclaimer in the documentation
% and/or other materials provided with the distribution
% * Neither the name of nor the names of its
% contributors may be used to endorse or promote products derived from this
% software without specific prior written permission.
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
