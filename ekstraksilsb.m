function [pesan_ektraksi]=ekstraksilsb(hasil_gmb_stego,pjg_bit_pesan);

red_gmb_stego = hasil_gmb_stego(:,:,1);
gmb_stego=red_gmb_stego(:); %matrik citra dijadikan 1 baris
bitpesan=[];
for i=1:pjg_bit_pesan
    if mod(gmb_stego(i),2)==0
        bitpesan=[bitpesan '0'];
    end
    if mod(gmb_stego(i),2)==1
        bitpesan=[bitpesan '1'];
    end
end

pesan_ektraksi=[];
for i=1:8:pjg_bit_pesan
    psn_desimal=bin2dec(bitpesan(i:i+7)); %biner dijadikan desimal
    pesan_ektraksi=[pesan_ektraksi char(psn_desimal)]; %desimal diubah ke huruf
end

%disp(['Hasil Ekstraksi Pesan = ', pesan_ektraksi])