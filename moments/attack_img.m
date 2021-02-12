function [img_atk] = attack_img(img)
I1 =img;
%%
%%%%%%%%%%%%%%%%%%%%%%% JPEG5,10,30
% imwrite(uint8(I1),'.\imgs\atk_JPEG30.jpg','jpg','Quality',30);
% I1 = double(imread('.\imgs\atk_JPEG30.jpg'));

%%%%%%%%%%%%%%%%%%%%%%% gaussian filter
% sigma = 1;
% gausFilter = fspecial('gaussian', [5,5], sigma);
% I1= imfilter(I1, gausFilter, 'replicate');
% imwrite(uint8(I1),'.\imgs\atk_gaussian551.bmp');

%%%%%%%%%%%%%%%%%%%%%%% gaussian noise
% I1 = imnoise(I1, 'gaussian', 0.001);
% imwrite(uint8(I1), '.\imgs\atk_gaussiannoise0001.bmp');

%%%%%%%%%%%%%%%%%%%%%%%  saltpepper
% I1 = imnoise(I1,'salt & pepper',0.02);
% imwrite(uint8(I1),'.\imgs\atk_saltpepper002.bmp');

%%%%%%%%%%%%%%%%%%%%%%%  rotate
% I1=imrotate(I1,45,'bilinear','crop');
% imwrite(uint8(I1),'.\imgs\atk_rotation45.bmp');

%%%%%%%%%%%%%%%%%%%%%%%  zoom in 
% I1=imresize(I1,1.5,'bilinear');
% imwrite(uint8(I1),'.\imgs\atk_zoomin.bmp');

%%%%%%%%%%%%%%%%%%%%%%%% zoom out 
% I1=imresize(I1,0.81,'bilinear');
% imwrite(uint8(I1),'.\imgs\atk_zoomout.bmp');

%%%%%%%%%%%%%%%%%%%%%%%% x-move
% se = translate(strel(1), [0 5]);
% I1=imdilate(I1,se);
% imwrite(I1,'.\imgs\atk_X_5.bmp');

%%%%%%%%%%%%%%%%%%%%%%%% Y-move
% se = translate(strel(1), [10 0]);
% I1=imdilate(I1,se);
% imwrite(I1,'.\imgs\atk_Y_10.bmp');
%------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%% medianfilter
% I1=medfilt2(I1,[3 3]);
% imwrite(uint8(I1),'.\imgs\atk_median33.bmp');

%%%%%%%%%%%%%%%%%%%%%%% edge sharpening
% sharpfilter=fspecial('laplacian',0);  
% g1=imfilter(I1,sharpfilter,'replicate');  
% I1=I1-g1; 
% imwrite(uint8(I1),'.\imgs\atk_sharpening.bmp');

% %%%%%%%%%%%%%%%%%%%%%%  average filter
% H=fspecial('average',[5 5]);
% I1=imfilter(I1,H);
% imwrite(uint8(I1),'.\imgs\atk_average55.bmp');

% 
%%
img_atk = I1;
end