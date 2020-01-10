function [x, y, scores, Ih, Iv] = extract_keypoints(image)
    assert(isa(image, 'uint8'), 'TypeError: image');
    
    % const
    k = 0.05;
    half_window_size = 2;
    window_size = 5;
    [m, n, r] = size(image);
    
    % gradient filters
    dy = [0 -1 0; 0 0 0; 0 1 0];
    dx = [0 0 0; 1 0 -1; 0 0 0];
    
    imgray = double(rgb2gray(image));
    
    % gradients
    Ih = imfilter(imgray, dx);
    Iv = imfilter(imgray, dy);
    
    % products of gradients, with zero paddings of size half_window_size
    Ih2 = zeros(m + half_window_size * 2, n + half_window_size * 2);
    Iv2 = Ih2(:,:);
    IhIv = Ih2(:,:);
    
    Ih2(3:m+2, 3:n+2) = Ih .^ 2;
    Iv2(3:m+2, 3:n+2) = Iv .^ 2;
    IhIv(3:m+2, 3:n+2) = Ih .* Iv;
    
    % "cornerness" of pixels
    R = zeros(m, n);
    
    % M for each pixel
    M = zeros(2, 2);
    
    % compute "cornerness"
    for i = 1:m
        for j = 1:n
            % calculate the corresponding indices in products of gradients
            is = i; % the start index in 1st dim 
            js = j; % the start index in 2nd dim
            it = i + window_size - 1; % the terminal index in 1st dim
            jt = j + window_size - 1; % the terminal index in 2nd dim
            M(1, 1) = sum(Ih2(is:it,js:jt), 'all');
            M(2, 2) = sum(Iv2(is:it,js:jt), 'all');
            M(1, 2) = sum(IhIv(is:it,js:jt), 'all');
            M(2, 1) = M(1, 2);
            R(i, j) = det(M) - k * (trace(M))^2;
        end
    end
    
        
    % threshold of "cornerness"
    th = round(m * n * 0.05);
    sorted = sort(R(:), 'descend');
    
    indices = R > sorted(th);
    [y, x] = find(indices);
    scores = R(indices);
    
    for i = 1:length(y)
        assert(R(y(i), x(i)) == scores(i));
        assert(indices(y(i), x(i)) == 1);
        
        % boundaries
        if y(i) == 1 || y(i) == m || x(i) == 1 || x(i) == n
            indices(y(i), x(i)) = 0;
        else % compare with 8 neighbors
            comparator = R(y(i)-1:y(i)+1, x(i)-1:x(i)+1) >= scores(i);
            comparator(2, 2) = 0; % itself does not count
            if any(comparator, 'all') % any neighbor >= this
                indices(y(i), x(i)) = 0;
            end
        end
    end
    
    [y, x] = find(indices);
    scores = R(indices);
    
    figure;
    imshow(image);
    hold on
    for i = 1:length(y)
        plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) / 5e8);
    end
    hold off
    
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset; 
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    ax.Position = [left bottom ax_width ax_height];
end