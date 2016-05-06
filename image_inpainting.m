clear all
im= imread('test_im2.bmp');
sampleIm =im;
a = all(sampleIm==0,2); % find all rows which have all pixels 0
first_unfilled_row= find(a,1); % Choosing first empty row
last_unfilled_row = find(a,1,'last');
if(size(sampleIm,1)==320)
 texture = sampleIm(last_unfilled_row+1:size(sampleIm,1), 1: size(sampleIm,2));
% texture = sampleIm(first_unfilled_row-11:first_unfilled_row-1, 1: size(sampleIm,2));
elseif (size(sampleIm,1)==240)
 %   texture=imcrop(sampleIm,[20 20 278 191]);
end
image= sampleIm(a(:,:),:)                                ; % selecting unfilled area from the given image
image= im2double(image);
sampleIm = im2double(texture);
image = im2double(im);
newGrow;