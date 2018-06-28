function [chip,PK,N,e,enc]=encryptrsa(pesan);
%pesan=input('Masukkan Pesan : ','s');
pesan=pesan+0;

P=11; %bil. prima
Q=19; %bil. prima

%hitung r
N=P*Q;
setappdata(0,'nInFunction',N);

%hitung omega r
OR=(P-1)*(Q-1);

%public key
cd=0;
e=1;
cekp=0;
while(cd~=1 || cekp~=1)
    e=e+1;
    cekp=isprime(e);
    cd=gcd(e,OR);
end
setappdata(0,'eInFunction',e);

%encryption
panjang_pesan=length(pesan);
chip=[];
PK=[];
for i=1:panjang_pesan
    c=mod((pesan(i).^e),N);
    chip=[chip c];
    
    %private key
    q=((pesan(i).^e)-c)/N; 
    PK=[PK q];
end
setappdata(0,'pkInFunction',PK);
enc=char(chip);
%fprintf('\nThe encrypted message is %s\n',enc);
