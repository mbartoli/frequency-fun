function [ newI ] = normalize3( oldI )
    
    maxI = max(max(max(oldI)));
    minI = min(min(min(oldI)));
  
    newI = (oldI - minI)/(maxI - minI);

end

