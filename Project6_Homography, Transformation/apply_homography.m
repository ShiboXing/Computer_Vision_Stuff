function [p2]=apply_homography(p1,H)

    p2=H*[p1;1];
    p2(1,1)/p2(3,1)
    p2(2,1)/p2(3,1)
    


end