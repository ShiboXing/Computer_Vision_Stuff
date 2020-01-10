
img=imread('egg.jpg');
quantizeRGB(img,5);
detectCircles(img,detectEdges(img,2),7,4);