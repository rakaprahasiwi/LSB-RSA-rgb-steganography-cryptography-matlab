clc;
clear all;
close all;

pesan=input('Input Pesan [Max. 200 Karakter] :','s');
if length(pesan) > 200
    pesan=pesan(1:200);
end

[chip,PK,N,e,enc]=encryptrsa(pesan); %encrypt RSA   

[pjg_bit_pesan,gmb_asli,hasil_gmb_stego]=lsbsisipcolor(enc); %penyisipan

figure,
subplot(2,1,1),imshow(gmb_asli),title('Citra Asli');
subplot(2,1,2),imshow(hasil_gmb_stego),title('Citra Stego');

[MSE,PSNR]=msepsnr(gmb_asli,hasil_gmb_stego);%MSE PSNR

[pesan_ektraksi]=ekstraksilsb(hasil_gmb_stego,pjg_bit_pesan); %ektraksi pesan

decr=decryptrsa(pesan_ektraksi,N,PK,e); %decrypt RSA