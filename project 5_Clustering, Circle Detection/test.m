
img=imread('fish.jpg');
quantizeRGB(img,2);

detectCircles(img,detectEdges(img,2),7,10);