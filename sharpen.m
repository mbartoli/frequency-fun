function [ newI ] = sharpen( oldI )

    newI = imfilter(oldI, fspecial('gaussian',[11 11], 10));    
    newI = oldI + 2*(oldI - newI);

end

