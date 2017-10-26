% Demo: A simple 3x3 LOOP (local oriented optimal pattern) code.
% Cite: T. Chakraborti, B. McCane, S. Mills, and U. Pal, "LOOP: Descriptor:
% Encoding Repeated Local Patternsfor Fine-grained Visual Identification of
% Lepidoptera", arXiv:1710.09317.

clear all
close all

% pre-processing
I=imread('peppers.png'); %input image
imshow(I); %display input image

I=im2double(I); %convert to double
if size(I,3)==3
    I=rgb2gray(I); %convert to grayscale if rgb
end

figure;
imshow(I); %display grayscale image

[m,n]=size(I); %get the size of image

%initialise variable
x=zeros(8,1);
y=zeros(8,1);
b=zeros(m,n);

%Kirsch masks
msk=zeros(3,3,8); %east, north-east, north, north-west, west, south-west, south, south-east
msk(:,:,1)=[-3 -3 5; -3 0 5; -3 -3 5]; %east
msk(:,:,2)=[-3 5 5; -3 0 5; -3 -3 -3]; %north-east
msk(:,:,3)=[5 5 5; -3 0 -3; -3 -3 -3]; %north
msk(:,:,4)=[5 5 -3; 5 0 -3; -3 -3 -3]; %north-west
msk(:,:,5)=[5 -3 -3; 5 0 -3; 5 -3 -3]; %west
msk(:,:,6)=[-3 -3 -3; 5 0 -3; 5 5 -3]; %south-west
msk(:,:,7)=[-3 -3 -3; -3 0 -3; 5 5 5]; %south
msk(:,:,8)=[-3 -3 -3; -3 0 5; -3 5 5]; %south-east

%LOOP calculation
for i=2:m-1
    for j=2:n-1
        t=1;
            for k=-1:1
                for l=-1:1
                    if (k~=0)||(l~=0)
                         if (I(i+k,j+l)-I(i,j)<0) %threshold to generate bit
                            x(t)=0;
                         else
                            x(t)=1;
                         end
                         y(t)=I(i+k,j+l)*msk(2+k,2+l,t); %apply Kirsch masks
                         t=t+1;
                    end
                end
            end
      
 [p q]= sort(y);     %sort mask output and assign 1 to the highest 3, rest 0  
 
 for t=1:8
     b(i,j)=b(i,j)+((2^(q(t)-1))*x(t)); %decimal to binary conversion
 end

        
    end
end

b=uint8(b); %convert decimal 2-d matrix to image
figure;
imshow(b);  %display LBP image


%LDP Histogram
H=imhist(b); %find histogram
figure;
bar(H); %display histogram


%%--------------------------------------------------------------%%


