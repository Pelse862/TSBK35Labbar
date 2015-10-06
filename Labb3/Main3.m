numberofloops = 10;
block = 4;
psnr = zeros(1,numberofloops);
bpp = zeros(1,numberofloops);

img = sprintf('image1.png');
for n = 2:4
    2^n
    for j = 1:numberofloops
        [psnr(j), bpp(j)] = transcoder(img,2,[2^n 2^n], (j)*0.02, (j)*0.02);        
    end
    hold on
   plot(bpp,psnr)
end

legend('4x4','8x8','16x16')



%%
numberofloops2 = 1;
psnr2 = zeros(1,numberofloops2);
bpp2 = zeros(1,numberofloops2);
img = sprintf('image1.png');

for j = 1:numberofloops2
    [psnr2(j), bpp2(j)] = transcoder(img,1,[16 16], (j)*0.05, j*0.05 );
end
hold on
plot(bpp2,psnr2)


