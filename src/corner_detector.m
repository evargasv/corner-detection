clc; close all; clear;

im = imread('images/chessboard06.png');

% original image
img_orig = im;

if size(im,3)>1 im=rgb2gray(im); end

% Image size
[ROWS, COLS] = size(im);

% Derivative masks

dx = [-1 0 1; -1 0 1; -1 0 1];
dy = dx';

% Image derivatives
Ix = conv2(double(im), dx, 'same');
Iy = conv2(double(im), dy, 'same');

sigma=2;

% Generate Gaussian filter of size 9x9 and std. dev. sigma.
g = fspecial('gaussian',9, sigma);

% Smoothed squared image derivatives
Ix2 = conv2(Ix.^2, g, 'same');
Iy2 = conv2(Iy.^2, g, 'same');
Ixy = conv2(Ix.*Iy, g, 'same');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PART 1: computation of matrix E
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% definition of matrix E
E = zeros(size(im));

sum_Ix2w = zeros(size(im));
sum_Ixyw = zeros(size(im));
sum_Iy2w = zeros(size(im));

tic
for i=2:( ROWS - 1 ) 
    for j=2:( COLS - 1 )       
        % computation of matrix M
        Ix2w = Ix2(i-1:i+1,j-1:j+1);
        Ixyw = Ixy(i-1:i+1,j-1:j+1);
        Iy2w = Iy2(i-1:i+1,j-1:j+1);
        
        sum_Ix2w(i,j) = sum( Ix2w(:) );
        sum_Ixyw(i,j) = sum( Ixyw(:) );
        sum_Iy2w(i,j) = sum( Iy2w(:) );
        
        M = [ sum_Ix2w(i,j) sum_Ixyw(i,j); sum_Ixyw(i,j) sum_Iy2w(i,j) ];
        eig_val = eig(M);
        % computation of matrix E
        E(i,j) = (min(eig_val));
    end
end
toc

% display matrix E
figure;
imshow(mat2gray(E));
title('Matrix E');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PART 2: computation of matrix R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R = zeros( size(im) );
k = 0.04;

tic
% determinant of matrix M
detM = (sum_Ix2w .* sum_Iy2w) - (sum_Ixyw .* sum_Ixyw);
% trace of matrix M
traceM = sum_Ix2w + sum_Iy2w;
% computation of matrix R
R = detM - k .* ( traceM .^ 2 );
toc

figure;
imshow(mat2gray(R))
title('Matrix R');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PART 3: selection of most salient points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% most salient points in R:
salient_R_pts = extract_corners( R, 81 );
figure; imshow(img_orig); hold on;
title('81 Most salient points in R');
for i=1:81,
    plot(salient_R_pts(i).p_x, salient_R_pts(i).p_y, 'r+');
end

% most salient points in E:
salient_E_pts = extract_corners( E, 81 );
figure; imshow(img_orig); hold on;
title('81 Most salient points in E');
for i=1:81,
    plot(salient_E_pts(i).p_x, salient_E_pts(i).p_y, 'g+');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PART 4: non-maximal supression
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Non-maximal Supression E:
E_sup = non_maximal_supression( E, 11 );
figure; title('Non-maximal Supression in E');
imshow(mat2gray(E_sup));

% 81 most salient points using non-maximal supression in E
salient_E_sup_pts = extract_corners( E_sup, 81 );
figure; imshow(img_orig); hold on;
title('81 Most salient points using Non-maximal supression in E');
for i=1:81,
    plot(salient_E_sup_pts(i).p_x, salient_E_sup_pts(i).p_y, 'g+');
end

% Non-maximal Supression R:
R_sup = non_maximal_supression( R, 11 );
figure; title('Non Maximal Supression in R');
imshow(mat2gray(R_sup));

% 81 most salient points using non-maximal supression in R
salient_R_sup_pts = extract_corners( R_sup, 81 );
figure; imshow(img_orig); hold on;
title('81 Most salient points using Non-maximal supression in R');
for i=1:81,
    plot(salient_R_sup_pts(i).p_x, salient_R_sup_pts(i).p_y, 'r+');
end

