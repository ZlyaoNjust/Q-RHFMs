clc
clear all
%%%%%%%%%%%%%%
% Nmax = input('input order number:');
% tic;
% a1=imread('Lena128.tif');%size=64*64
a1 = imread('Peppers512.png'); %Lena128.tif
a1 = imresize(a1,[128 128],'bicubic');
% a=imresize(a1,[64 64]);

a = a1;
cs=a;

b=double(a);
tic;
[N22,m22,z]=size(a);
o1=ceil(N22/sqrt(2));
% o1=floor(N2/sqrt(2));
aa26=zeros(2*o1,2*o1,z); % 
for is=1:(2*(N22/sqrt(2)))
    for js=1:(2*(N22/sqrt(2)))
        if is>(o1-N22/2)&is<=(N22+o1-(N22/2))&js>(o1-(N22/2))&js<=(N22+o1-(N22/2)) %
            aa26(is,js,:)=b(is-(o1-(N22/2)),js-(o1-N22/2),:);
        end
    end
end

a=aa26;
b=double(a);
[n,m,z]=size(b);
N=n;
%%%%%%%%%%%%%%
M = 4*N;
fp = zeros(M,M,z);
Gp = zeros(M,M,z);
for u = 1:M
    for v = 1:M
        rrr = (u-1)/M;
        ooo = (2*pi*(v-1))/M;
        kk = ceil(rrr*(N/2)*sin(ooo));
        ll = ceil(rrr*(N/2)*cos(ooo));
        fp(u,v,:) = b((-1)*kk+(N/2)+1,ll+(N/2),:);
        Gp(u,v,:) = fp(u,v,:)*sqrt((u-1)/(2*M));
    end
end
R = Gp(:,:,1);
G = Gp(:,:,2);
B = Gp(:,:,3);
%%%%%%%%%%
msre =zeros(25,1);
i_index = 1;
% for Nmax=[ 2 4 8 10 18 22 25 28 32 40]
for Nmax = [32]
    [Rhf_R,A_nm_R,zmlist_R] = YXfenjie513(R,M,Nmax);
    [Rhf_G,A_nm_G,zmlist_G] = YXfenjie513(G,M,Nmax);
    [Rhf_B,A_nm_B,zmlist_B] = YXfenjie513(B,M,Nmax);
    mm = 1/sqrt(3);         %
    AE = -mm*(imag(A_nm_R)+imag(A_nm_G)+imag(A_nm_B));
    CE = real(A_nm_R)+mm*imag(A_nm_G)-mm*imag(A_nm_B);
    DE = -mm*imag(A_nm_R)+real(A_nm_G)+mm*imag(A_nm_B);
    EE = mm*imag(A_nm_R)-mm*imag(A_nm_G)+real(A_nm_B);
    FFZ=sqrt( AE.^2 + CE.^2 + DE.^2 + EE.^2 );
    toc;
    tic;
    
    %%%%%%%%%%%%
    [oo1,r1]=cal(a(:,:,1));
    [oo2,r2]=cal(a(:,:,2));
    [oo3,r3]=cal(a(:,:,3));
    A1= YXrec513(AE,zmlist_R,oo1,r1);
    C1= YXrec513(CE,zmlist_R,oo1,r1);
    D1 = YXrec513(DE,zmlist_R,oo1,r1);
    E1 = YXrec513(EE,zmlist_R,oo1,r1);
    fa = real(A1)-mm*imag(C1)-mm*imag(D1)-mm*imag(E1);
    fc = mm*imag(A1)+real(C1)+mm*imag(D1)-mm*imag(E1);
    fd = mm*imag(A1)-mm*imag(C1)+real(D1)+mm*imag(E1);
    fe = mm*imag(A1)+mm*imag(C1)-mm*imag(D1)+real(E1);
    Gp_re(:,:,1) = fc;
    Gp_re(:,:,2) = fd;
    Gp_re(:,:,3) = fe;
    toc
    aa=Gp_re;
    bb3=zeros(N22,N22,z);   %
    X1=2*(N22/sqrt(2));
    X2=o1-N22/2;
    for is=1:(2*(N22/sqrt(2)))
        for js=1:(2*(N22/sqrt(2)))
            if is>(o1-N22/2)&is<=(N22+o1-(N22/2))&js>(o1-(N22/2))&js<=(N22+o1-(N22/2))
                bb3(is-(o1-(N22/2)),js-(o1-N22/2),:)=aa(is,js,:);
            end
        end
    end
    
    % figure,imshow(uint8(bb3));
    imwrite(uint8(bb3),'aa.bmp');
    % toc;
    recimg = bb3;
    
    % % % %%%%%%%%%%%%
    different = double(bb3)-double(cs);
    imwrite(uint8(different),'bb.bmp');
    imwrite(uint8(different*5),'cc.bmp');
    %%%%%%%%%%%%%%%%%%%%%%% £¨EEE1£©  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    different2 = different;
    different2a = abs(different2);
    % figure,imshow(uint8(different2a));
    % % imwrite(uint8(different2a),'chonggou45chazhi.bmp');
    EEE1 = sum(different2a(:));  %%%%
    EEE1 = floor(0.01*EEE1);
    
    %%%%%%%%%%%%%%%%%%%%%%%  £¨EE2£©  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    different3a = (different2a).^2;
    cs=double(cs);
    different3b = (cs).^2;
    EEE2 = sum(different3a(:))/sum(different3b(:))  %%%%
    EE2_arr(1,Nmax) = EEE2;
    msre(i_index,1) = EEE2;
    i_index = i_index + 1;
end
