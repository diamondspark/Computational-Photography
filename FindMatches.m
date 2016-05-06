function [pixelList,SSD] = FindMatches(template, sampleIm, sample_patches, gauss_mask,winsize)
% Finding validmask
valid_mask=template;
valid_mask(valid_mask >0)=1;
%Gaussian2D(winsize,Sigma);
totWeight = sum(sum(gauss_mask*(valid_mask)));
mask = (gauss_mask .* valid_mask) / totWeight;
mask_vec = mask(:)'; 
template=reshape(template, [winsize*winsize, 1]);
template=repmat(template, 1, size(sample_patches,2));
dist =   (template - sample_patches).^2;
SSD = mask_vec*dist;
ErrThreshold = 0.1;
pixelList = SSD <= min(SSD) * (1+ErrThreshold); 
%SSD = dist'*
end