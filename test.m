clear all
DR=60;
OriIm = imread('../screenshot/exp1_1_2lighter_025_pen.bmp');

%ColorIm=double(OriIm);
ColorIm=OriIm;
GrayIm= rgb2gray(OriIm);

choppedColorIm = ColorIm([1: 375], [250: 400], [1: 3]);
choppedGrayIm=GrayIm([1: 375], [250: 400]);


figure
image(OriIm)
title('original image')

figure
image(choppedColorIm)
title('chopped image')

figure
image(choppedGrayIm)
title('gray level image')

choppedGrayImDouble=double(choppedGrayIm);
min_of_GrayIm=min(min(choppedGrayImDouble));
Nor_GrayIm= choppedGrayImDouble-min_of_GrayIm;
ratioGrayImDouble=Nor_GrayIm/max(max(choppedGrayImDouble));
dbImDouble=ratioGrayImDouble*DR;

% show B-mode image
figure
image(dbImDouble)
colormap(gray(DR))
axis image
colorbar
title('B-mode image, dynamic range = 50dB')

%%%PSF

LateraldbIm= max(dbImDouble) - max(max(dbImDouble));
figure
plot(LateraldbIm)
title('Lateral projection')

dbImDoubleTranspose=transpose(dbImDouble);

VerticaldbIm= max(dbImDoubleTranspose) - max(max(dbImDoubleTranspose));  
figure
plot(VerticaldbIm)
title('Vertical projection')


idx = find(VerticaldbIm >= -6 );
i = 1;
Width6dB = 1;
while (Width6dB == 1)
    Width6dB = idx(i + 1)-idx(i);
    i = i + 1;
end
disp('vertical Width6dB:');
disp(Width6dB);

idx = find(LateraldbIm >= -6 );
i = 1;
Width6dB = 1;
while (Width6dB == 1)
    Width6dB = idx(i + 1)-idx(i);
    i = i + 1;
end
disp('lateral Width6dB:');
disp(Width6dB);

%%%%%%%Speckle

[xdim, ydim] = size(dbImDouble);

EBase = zeros(xdim, ydim);
IBase= zeros(xdim, ydim);
for i = 1: xdim
  for j = 1: ydim
    EBase(i, j) = 10^(dbImDouble(i,j)/20);
    IBase(i,j)= 10^(dbImDouble(i,j)/10);
  end
end

%2D-1D
histogramE=max(EBase);
histogramI=max(IBase);

figure
% 請先把 LinearIm_I 以及 LinearIm_E 變成column vector, 再使用hist指令畫出機率分布圖
hist(histogramE,500);	% 像expenential distribution嗎?
title('Speckle Intensity Distribution');xlabel('I');ylabel('P_I')

figure
hist(histogramI,1000);	% 像Reyleigh distribution嗎?
title('Speckle Amplitude Distribution');xlabel('E');ylabel('P_E')






