% clear all
% image = zeros(200, 200); % Empty Image
winsize=9;
MaxErrThreshold = 0.3;
% sampleIm = im2double(imread(filename)); 
% sampleIm = im2double(imread('T5.gif')); 
[rows, columns] = size(sampleIm);
% Creating matrix to represent which sample patch belong to which region of
% sample image
for i = 1: size(sampleIm,1)
    for j = 1 : size (sampleIm,2)
    sample_patches_loc{i,j}=[i,j];
    end
end
sample_patches_loc= im2col(sample_patches_loc,[winsize winsize]);
% Initialize image with 3x3 seed at center and fill it with random texture
% from sampleIm
randRow = ceil(rand() * (rows - 2)); 
randCol = ceil(rand() * (columns - 2));
seedSize =3;
seedRows = ceil(200/2):ceil(200/2)+seedSize-1;
seedCols = ceil(200/2):ceil(200/2)+seedSize-1;
% image = im2double( imread('test_im2.bmp'));
% image(seedRows, seedCols, :) = sampleIm(randRow:randRow+seedSize-1, randCol:randCol+seedSize-1, :);
filled = false([size(image,1) size(image,2)]); 
filled(seedRows,seedCols,:)=1;
npixels=200*200;
nfilled= seedSize*seedSize;
MaxErrThreshold = 0.1;
%imshow(image), title('initial');

%%





%%
while(~all(image(:))>0)%(nfilled<npixels)
    progress=false;
    nfilled
%% GetUnfilledNeighbors
    sortedNeighbourList= GetUnfilledNeighbors(filled,winsize);
    Sigma = winsize/6.4;
    gauss_mask =  fspecial('gaussian',winsize,Sigma);
    sample_patches = im2col(sampleIm,[winsize winsize]);



% For each pixel in sorted neighbor list
    for i = 1: size(sortedNeighbourList,1)

      template = getNeighborhoodWindow(image,sortedNeighbourList(i,:),winsize);
      [pixelList,SSD] = FindMatches(template, sampleIm,sample_patches,gauss_mask,winsize);
      % Randomly choosing best match (1st element in returned pixellist)
      temp = find(pixelList==1);
      bestMatch=[];
      bestMatch=vertcat(bestMatch,sample_patches_loc{:,temp(1)});
      central_bestmatch=bestMatch(ceil(size(bestMatch,1)/2),:);
      if(SSD(temp(1))< MaxErrThreshold)
         image(sortedNeighbourList(i,1),sortedNeighbourList(i,2))= sampleIm(central_bestmatch(1),central_bestmatch(2));
         filled(sortedNeighbourList(i,1),sortedNeighbourList(i,2))=true;
         nfilled=nfilled+1;
         progress=true;
      end
      if (~progress)
          MaxErrThreshold= MaxErrThreshold*1.1;
      end
    end
end