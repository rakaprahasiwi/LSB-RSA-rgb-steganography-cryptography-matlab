function [pjg_bit_pesan,hasil_gmb_stego]=lsbsisipcolor(enc,gmb_asli);

enc=uint8(enc); %convert ke angka
pjg_pesan=length(enc); %panjang pesan

%membagi 3 warna RGB
red = gmb_asli(:,:,1);
green = gmb_asli(:,:,2);
blue = gmb_asli(:,:,3);
warna = red; %mengambil warna merah

%citra=imresize(citra,[256 512]);
[baris,kolom]=size(warna);
gmb_stego=warna(:); %matrik gambar dijadikan satu baris

%pesan dijadikan biner
bit_pesan=[];
for i=1:pjg_pesan
    psn_biner=dec2bin(enc(i),8);
    bit_pesan=[bit_pesan psn_biner];
end
pjg_bit_pesan=length(bit_pesan); %panjang dari bit pesan
setappdata(0,'pjgInFunction',pjg_bit_pesan);

%penyisipan pesan
for i=1:pjg_bit_pesan
    if(mod(gmb_stego(i),2)==0) && (bit_pesan(i)=='1')
        gmb_stego(i)=gmb_stego(i)+1;
    else if(mod(gmb_stego(i),2)==1) && (bit_pesan(i)=='0')
            gmb_stego(i)=gmb_stego(i)-1;
        end
    end
end

gmb_stego=reshape(gmb_stego,[baris kolom]); %gambar baris dijadikan matrik

hasil_gmb_stego= cat(3,gmb_stego,green,blue);
setappdata(0,'hslInFunction',hasil_gmb_stego);
imwrite(hasil_gmb_stego,'stego.bmp');