function	[Rhf,A_nm,zmlist]	= YXfenjie513(Gp,M,Nmax)   %¡£

Ekm1 = fft2(Gp);
Ekm = Ekm1/(M^2);
E = zeros(2*Nmax+1,2*Nmax+1);
E(1:Nmax,1:Nmax) = Ekm(M-Nmax+1:M,M-Nmax+1:M);
E(1:Nmax,Nmax+1:2*Nmax+1) = Ekm(M-Nmax+1:M,1:Nmax+1);
E(Nmax+1:2*Nmax+1,1:Nmax) = Ekm(1:Nmax+1,M-Nmax+1:M);
E(Nmax+1:2*Nmax+1,Nmax+1:2*Nmax+1) = Ekm(1:Nmax+1,1:Nmax+1);


Rhf = zeros(Nmax+1,2*Nmax+1);
Rhf(1,:) = sqrt(2).*E(Nmax+1,:);
NNNN = Nmax+1;
for i=2:NNNN
    j = floor(i/2);
    if(mod(i,2)==0) %%% Rhf(n,m)=sqrt(-1)*(E(k,m)-E(-k,m))    n=2*k-1,k=1,2,...
        Rhf(i,:) = sqrt(-1).*(E(NNNN+j,:)-E(NNNN-j,:));
    else %%% Rhf(n,m)=E(k,m)+E(-k,m)               n=2*k  ,k=1,2,...
        Rhf(i,:) = E(NNNN+j,:)+E(NNNN-j,:);
    end
end

c = 1;
for k=1:(Nmax+1)
    for m=1:(2*Nmax+1)
        zmlist(c,1:2) = [k-1 m-Nmax-1];
        A_nm(c) = Rhf(k,m);
        c = c+1;
    end
end
