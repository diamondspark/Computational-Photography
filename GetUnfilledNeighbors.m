%% GetUnfilledNeighbors
% Finding unfilled pixel which borders some filled pixels
function [sortedNeighbourList] = GetUnfilledNeighbors(filled, winsize) 
% 
% border = bwmorph(filled,'dilate')-filled;
% list = find(border==1); % List of Frontier pixels
% randId = randperm(size(list,1));
% % randList(:) = list(randId); % Permuted list of frontier pixels
% % Sorting based on number of filled pixels in neighburhood of each pixel
% % from the randList. NOte that for any pixel the number of pixels in it's
% % neighbourhood is sum of elements in [winSIze winsize] window around it.
%  filledSums = colfilt(filled, [winsize winsize], 'sliding', @sum);
%  filled_ids= find(filled==1);
%  filledSums(filled_ids(:))=0;
% numFilledNeighboursIds = find(filledSums>0);
% [numFilledNeighboursRow,numFilledNeighboursCol]= find(filledSums>0);
% numFilledNeighbours = filledSums(numFilledNeighboursIds(:));
% [sorted, sortIndex] = sort(numFilledNeighbours, 1, 'descend');
% n = [numFilledNeighboursRow,numFilledNeighboursCol];
% sortedNeighbourList= n(sortIndex(:),:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d = filled;
d(d~=0)=1;
border = double(bwmorph(d,'dilate'))-double(d);
[r,c]=find(border~=0);
filledSums = colfilt(filled, [winsize winsize], 'sliding', @sum);
numFilledNeighbors = filledSums(sub2ind(size(filled),r,c));
[~,sortIndex] = sort(numFilledNeighbors,1,'descend');
r= r(sortIndex);
c = c(sortIndex);
sortedNeighbourList=[r,c];





end