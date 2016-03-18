% B-mode �v�����窺�d�ҵ{��
% �Y���M���ҨϥΤ�MATLAB���O�A�ЬdMATLAB help
% Edited by M.-L. Li 05/14/2002
clear all
DR = 60;	% dynamic range (�ʺA�d��) of the image		
                % �]Sonosite�L�k��ܨϥΪ��ʺA�d��(�q�`�|��ܦb��L�t�Ϊ���l�v���W),�i�����ϥ�DR=60
			
% �bMATLAB��,imread�i�Ӫ��v����� data type �� "uint8"
OriIm = imread('screenshot/exp1_1_2lighter_025_pen.bmp');
GrayIm = rgb2gray(OriIm);	% rgb to gray scale, data type : uint8

% �bMATLAB���A+,-,*,/���ƭȹB��Ψ禡�u��ϥΩ�data type��double����ƤW�A
% �]���A�b�����Nuint8��data type�ন"double"
GrayIm = double(OriIm);	

%    figure,imagesc(GrayIm), colormap(gray)

% �N��l�v���W�A�u���ݩ����v�����������X�A���P���v�������ϰ줣�P�A
% �Цۤv��X�ۤv�^���v���u���ݩ����v��������
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

% gray to dB ��0-255���Ƕ��ন dB

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
