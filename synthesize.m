function [imout] = synthesize(imin, sizeout, tilesize, overlap)
% function [imout] = synthesize(imin, sizeout, tilesize, overlap)


imin = double(imin);

imout = zeros(sizeout);
sizein = size(imin);

temp = ones([overlap tilesize]);
errtop = xcorr2(imin.^2, temp);
temp = ones([tilesize overlap]);
errside = xcorr2(imin.^2, temp);
temp = ones([tilesize-overlap overlap]);
errsidesmall = xcorr2(imin.^2, temp);



for i=1:tilesize-overlap:sizeout(1)-tilesize+1,
  for j=1:tilesize-overlap:sizeout(2)-tilesize+1,

    if (i > 1) & (j > 1),
    % extract top shared region
      shared = imout(i:i+overlap-1,j:j+tilesize-1);
      err = errtop - 2 * xcorr2(imin, shared) + sum(shared(:).^2);
      
      % trim invalid data at edges, and off bottom where we don't want
      % tiles to go over the edge
      err = err(overlap:end-tilesize+1,tilesize:end-tilesize+1);

      % extract left shared region, skipping bit already checked
      shared = imout(i+overlap:i+tilesize-1,j:j+overlap-1);
      err2 = errsidesmall - 2 * xcorr2(imin, shared) + sum(shared(:).^2);
      % sum(shared(:).^2); trim invalid data at edges, and where we
      % don't want tiles to go over the edges
      err = err + err2(tilesize:end-tilesize+overlap+1, overlap:end-tilesize+1);

      [ibest, jbest] = find(err <= 1.1*1.1*min(err(:)));
      c = ceil(rand * length(ibest));
      pos = [ibest(c) jbest(c)];

    elseif i > 1
      shared = imout(i:i+overlap-1,j:j+tilesize-1);
      err = errtop - 2 * xcorr2(imin, shared) + sum(shared(:).^2);
      
      % trim invalid data at edges
      err = err(overlap:end-tilesize+1,tilesize:end-tilesize+1);

      [ibest, jbest] = find(err <= 1.1*1.1*min(err(:)));
      c = ceil(rand * length(ibest));
      pos = [ibest(c) jbest(c)];
    elseif j > 1
      shared = imout(i:i+tilesize-1,j:j+overlap-1);
      err = errside - 2 * xcorr2(imin, shared) + sum(shared(:).^2);
      
      % trim invalid data at edges
      err = err(tilesize:end-tilesize+1,overlap:end-tilesize+1);

      [ibest, jbest] = find(err <= 1.1*1.1*min(err(:)));
      c = ceil(rand * length(ibest));
      pos = [ibest(c) jbest(c)];
    else
      pos = ceil(rand([1 2]) .* (sizein-tilesize+1));
    end


    imout(i:i+tilesize-1,j:j+tilesize-1) = imin(pos(1):pos(1)+tilesize-1,pos(2):pos(2)+tilesize-1);
  end
end
