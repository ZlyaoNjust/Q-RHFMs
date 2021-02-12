function Gp_re  = YXrec513(A_nmm,zmlistt,o,r)
%%%%%%%%%%%%%%%%%%
[M M]=size(o);
gg = zeros(M,M);
% [v,u] = meshgrid(1:M,1:M);
% rrr = (u-1)/M;
% ooo = (2*pi*(v-1))/M;
rrr=r;ooo=o;
for kk=1:(length(A_nmm))
    nj = zmlistt(kk,1);
    mc = zmlistt(kk,2); 
    if nj==0
        Ta = sqrt(1./rrr);
    elseif mod(nj,2)==0
        Ta = sqrt(2./rrr).*cos(pi*nj.*rrr);
    else
        Ta = sqrt(2./rrr).*sin(pi*(nj+1).*rrr);
    end

    gg = A_nmm(kk).*Ta.*exp(j*mc.*ooo)+gg;

end

Gp_re = gg;