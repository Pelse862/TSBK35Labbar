function [PSNR, BPP]=transcoder(Image, transform, blockSize, Q1, Q2)

% This is a very simple transform coder and decoder. Copy it to your directory
% and edit it to suit your needs.
% You probably want to supply the image and coding parameters as
% arguments to the function instead of having them hardcoded.


% Read an image
im=double(imread(Image))/255;

% What blocksize do we want?
blocksize = blockSize;

% Quantization steps for luminance and chrominance
qy = Q1;
qc = Q2;

% Change colourspace 
imy=rgb2ycbcr(im);

%imy = imresize(imy,2);
bits=0;

% Somewhere to put the decoded image
imyr=zeros(size(im));

% First we code the luminance component
% Here comes the coding part
if transform == 1
    tmp = bdct(imy(:,:,1), blocksize);      % DCT
else 
    tmp = bdwht(imy(:,:,1),blocksize);
end

tmp = bquant(tmp, qy);             % Simple quantization
p = ihist(tmp(:));                 % Only one huffman code

%bits = bits + huffman(p);         
% Add the contribution from
% each component
bits=bits +sum(jpgrate(tmp, blockSize));
                                 
			
% Here comes the decoding part
tmp = brec(tmp, qy);               % Reconstruction
if transform == 1
   imyr(:,:,1) = ibdct(tmp, blocksize, [512 768]);  % Inverse DCT      % DCT
else 
    imyr(:,:,1) = ibdwht(tmp, blocksize, [512 768]);  % Inverse DCT
end


% Next we code the chrominance components
for c=2:3                          % Loop over the two chrominance components
  % Here comes the coding part

  tmp = imy(:,:,c);
    
  % If you're using chrominance subsampling, it should be done
  % here, before the transform.
  %tmp = imresize(tmp, 0.5);
  
if transform == 1
    tmp = bdct(tmp, blocksize);      % DCT
else 
    tmp = bdwht(tmp,blocksize);
end

  
  tmp = bquant(tmp, qc);           % Simple quantization
  p = ihist(tmp(:));               % Only one huffman code
  
  %bits = bits + huffman(p);        % Add the contribution from
  bits= bits +sum(jpgrate(tmp, blockSize));
                                % each component
			
  % Here comes the decoding part
  tmp = brec(tmp, qc);            % Reconstruction
if transform == 1
   % QL=repmat(1:16,16, 1);
  %  QL=(QL+QL-15)/16;
   % k1=0.1;
  %  k2=0.7;

   % Q2=k1*(1+k2*QL);
  %  tmp = bquant(tmp, Q2);
   % tmp = brec(tmp, Q2);    
  
    tmp = ibdct(tmp, blocksize, [512 768]);  % Inverse DCT
else 
    tmp = ibdwht(tmp, blocksize, [512 768]);  % Inverse DCT
end
 

  % If you're using chrominance subsampling, this is where the
  % signal should be upsampled, after the inverse transform.
   %tmp = imresize(tmp,2);
  imyr(:,:,c) = tmp;
  
end

% Display total number of bits and bits per pixel
	
BPP = bits/(size(im,1)*size(im,2));

% Revert to RGB colour space again.
imr=ycbcr2rgb(imyr);

% Measure distortion and PSNR
dist = mean((im(:)-imr(:)).^2);
PSNR = 10*log10(1/dist);

% Display the original image
figure, imshow(im)
title('Original image')


%Display the coded and decoded image
figure, imshow(imr);
title(sprintf('Decoded image, %5.2f bits/pixel, PSNR %5.2f dB', BPP, PSNR))

