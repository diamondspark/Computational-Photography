function[template,windowRows,windowCols] = getNeighborhoodWindow(image,pixel,winsize)
    
    halfWindow = floor((winsize-1)/2);
    d=padarray(image,[halfWindow halfWindow],0,'both');
    windowRows = pixel(1): pixel(1)+winsize-1;
    windowCols = pixel(2): pixel(2)+winsize-1;
    template = d(windowRows,windowCols,:);
    
  
end