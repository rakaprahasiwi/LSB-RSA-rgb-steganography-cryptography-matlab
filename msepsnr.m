function [MSE,PSNR]=msepsnr(gmb_asli,hasil_gmb_stego);

img1 = gmb_asli(:,:,1);
img2 = hasil_gmb_stego(:,:,1);
img1 = double(img1);
img2 = double(img2);

[m n] = size(img1);

er=img1-img2;
MSE=sum(sum(er.^2))/(m*n);
PSNR= 10*log10(255^2/MSE);

fprintf('MSE = %f\n',MSE);
fprintf('PSNR = %f\n',PSNR);