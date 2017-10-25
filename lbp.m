% Demo: A simple 3x3 LBP (local binary pattern) code.
% Cite: T. Chakraborti, B. McCane, S. Mills, and U. Pal, "LOOP: Descriptor:
% Encoding Repeated Local Patternsfor Fine-grained Visual Identification of
% Lepidoptera", IEEE Signal Processing Letters, 2017. (submitted, under
% review)

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
z=zeros(8,1);
b=zeros(m,n);


% LBP calculation
for i=2:m-1
    for j=2:n-1        
        t=1;
        for k=-1:1
            for l=-1:1                
                if (k~=0)||(l~=0)
                if (I(i+k,j+l)-I(i,j)<0) %threshold to generate bit
                    z(t)=0;
                else
                    z(t)=1;
                end
                t=t+1;
                end
            end
        end
        
        for t=0:7
           b(i,j)=b(i,j)+((2^t)*z(t+1));  %binary to decimal conversion
        end
    end
end

b=uint8(b); %convert decimal 2-d matrix to image
figure;
imshow(b);  %display LBP image


%LBP Histogram
H=imhist(b); %find histogram
figure;
bar(H); %display histogram


%%--------------------------------------------------------------%%

