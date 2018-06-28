function decr=decryptrsa(pesan_stego,N,priv_key,e);

%decryption
pesan_stego=pesan_stego+0;
pjg_chip=length(pesan_stego);
plai=[];
for j=1:pjg_chip
    m=nthroot(((N*priv_key(j))+pesan_stego(j)),e);
    if mod(m,2)~=1
        m=round(m);
    else if mod(m,2)~=0
            m=round(m);
        end
    end
    plai=[plai m];
end
%m=mod((c^d),N);
decr=char(plai);
%fprintf('\nThe decryption message is %s\n',decr);