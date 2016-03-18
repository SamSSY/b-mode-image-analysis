% B-mode 影像實驗的範例程式
% 若不清楚所使用之MATLAB指令，請查MATLAB help
% Edited by M.-L. Li 05/14/2002
clear all
DR = 60;	% dynamic range (動態範圍) of the image		
                % 因Sonosite無法顯示使用的動態範圍(通常會顯示在其他系統的原始影像上),可直接使用DR=60
			
% 在MATLAB中,imread進來的影像資料 data type 為 "uint8"
OriIm = imread('screenshot/exp1_1_2lighter_025_pen.bmp');
GrayIm = rgb2gray(OriIm);	% rgb to gray scale, data type : uint8

% 在MATLAB中，+,-,*,/等數值運算或函式只能使用於data type為double的資料上，
% 因此，在此先將uint8的data type轉成"double"
GrayIm = double(OriIm);	

%    figure,imagesc(GrayIm), colormap(gray)

% 將原始影像上，真正屬於仿體影像的部份取出，不同的影像取的區域不同，
% 請自己找出自己擷取影像真正屬於仿體影像的部份
%GrayIm = GrayIm(?);
GrayIm = GrayIm([1: 375], [250: 400], [1: 3]);
croppedIm = OriIm([1: 375], [250: 400], [1: 3]);

figure
image(OriIm)
title('opriginal image')

figure
image(croppedIm)
title('cropped image')

figure
image(GrayIm)
title('gray level image')

% gray to dB 由0-255的灰階轉成 dB

a = min(min(GrayIm));

[xdim, ydim, zdim] = size(GrayIm);

dBIm = zeros(xdim, ydim, zdim);
minValue = min(min(GrayIm));

for i = 1: xdim
  for j = 1: ydim
    dBIm(i, j, 1) = GrayIm(i, j, 1) - minValue(:, :, 1); % set min value to 0
    dBIm(i, j, 2) = GrayIm(i, j, 2) - minValue(:, :, 2);
    dBIm(i, j, 3) = GrayIm(i, j, 3) - minValue(:, :, 3);
  end
end

%dBIm = dBIm/max(max(dBIm));			% normalization, 0 - 1
maxValue = max(max(dBIm));

for i = 1: xdim
  for j = 1: ydim
    dBIm(i, j, 1) = dBIm(i, j, 1)/ maxValue(:, :, 1);
    dBIm(i, j, 2) = dBIm(i, j, 2)/ maxValue(:, :, 2);
    dBIm(i, j, 3) = dBIm(i, j, 3)/ maxValue(:, :, 3);
  end
end

%dBIm = dBIm*DR;							% to dB, 0 - DR

for i = 1: xdim
  for j = 1: ydim
    dBIm(i, j, 1) = dBIm(i, j, 1)* DR;
    dBIm(i, j, 2) = dBIm(i, j, 2)* DR;
    dBIm(i, j, 3) = dBIm(i, j, 3)* DR;
  end
end


% show B-mode image

figure
image(dBIm)
colormap(gray(DR))
axis image
colorbar
title('B-mode image, dynamic range = 50dB')
