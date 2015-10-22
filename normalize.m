function [ newI ] = normalize( oldI )
    
    maxI = max(max(oldI));
    minI = min(min(oldI));
  
    newI = (oldI - minI)/(maxI - minI);

end

