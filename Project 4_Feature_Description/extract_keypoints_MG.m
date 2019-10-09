function [x, y, scores, Ih, Iv] = extract_keypoints(image)

% Preprocess the image
im = double(rgb2gray(image));
rows = size(im, 1);
cols = size(im, 2);

% Use a constant of 0.05 for k
k = 0.05;

% Calculate the vertical and horizontal gradient
[Ih, Iv] = imgradientxy(im);

R = zeros(rows , cols);
scores = [];
for r=3:rows-2
    for c=3:cols-2
        
        % Calculate the Matrix M
        M = zeros(2, 2);
        for x=(r-2):(r+2)
            for y=(c-2):(c+2)
                M(1, 1) = M(1, 1) + (Ih(x, y) * Ih(x, y));
                M(1, 2) = M(1, 2) + (Ih(x, y) * Iv(x, y));
                M(2, 1) = M(2, 1) + (Ih(x, y) * Iv(x, y));
                M(2, 2) = M(2, 2) + (Iv(x, y) * Iv(x, y));
            end
        end 
        
        R(r, c) = det(M) - (k * trace(M)^2);
        
    end
end

threshold = mean(R(:))*5;
disp(threshold);

x = [];
y = [];
for r=2:(rows-1)
    for c=2:(cols-1)
        if (R(r, c) > threshold)
            scores(size(scores, 2) + 1) = R(r, c);
            x(size(x, 2) + 1) = c;
            y(size(y, 2) + 1) = r;
        end
    end
end

% Perform non-max suppression
remove = [];
for r=1:size(scores, 2)
    % Iterate through its eight neighbors
    curr = R(y(r), x(r));
    toRemove = 0;
    for i=(y(r)-1):(y(r)+1)
        for j=(x(r)-1):(x(r)+1)
            if (R(i, j) >= curr && i ~= y(r) && j ~= x(r))
                toRemove = 1;
                break;
            end
        end
    end
    if (toRemove == 1)
        remove(size(remove, 2) + 1) = r;
        toRemove = 0;
    end
end

% Remove non-max surpression
scores(remove) = [];
x(remove) = [];
y(remove) = [];

% Plot the image
imshow(image);
hold on;
for i=1:size(scores, 2)
    if (scores(i) <= 0) 
        continue;
    end
    % May sometimes need to change the value being divided by
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) / 100000000000);
end