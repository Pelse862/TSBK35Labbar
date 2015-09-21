
%% Entropi ljud
frequenzy = 44100;

[audioVec, f] = audioread('hey.wav');

audioVec = 128*audioVec+128;
[k, j] = size(audioVec);


%%
H = zeros(256, 1);
for n = 1:size(audioVec)
    H(audioVec(n))= H(audioVec(n))+1;
end

prob = H./k;

logVec = zeros(256,1);
for i = 1:256
   if prob(i) ~= 0
        logVec(i) = -sum(prob(i)).*log2(prob(i));
   else
        logVec(i) = 0;
   end
end

if(f == 44100)
    
    entro = sum(logVec);
else
    entro = sum(logVec);
end

%%  kolla på hur ofta paren uppstår i signalen istället för hur ofta karaktär speciell uppstår

H = zeros(256,256);
l = 12;
%kollar alla möjliga kombinationer av värdena, ex (0,0) mot hela vektorn
for i = 1:(max(size(audioVec))-1)
   H(audioVec(i),audioVec(i+1)) = H(audioVec(i),audioVec(i+1))+1;
end

prob2 = H./k;

logVec2 = zeros(256,256);


for i = 1:256
    for l3 = 2:256
       if prob2(i,l3) ~= 0
            logVec2(i,l3) = -sum(prob2(i,l3)).*log2(prob2(i,l3));
       else
            logVec2(i,l3) = 0;
       end
    end
end

if(f == 44100)
    
    entro2 = sum(sum(logVec2));
else
    entro2 = sum(sum(logVec2));
end

%%betinget parentropen - minnesfri entropi = betingad entropi

entro3 = entro2-entro;      

%%
%%Huffmannkodning och dyligt

P = zeros(size(audioVec));

P(1,1) = 0;

P(2:length(P),1) = audioVec(1:k-1,1);

Y = audioVec - P;
c = histc(Y,min(Y):max(Y));

prob = c./k;
L = huffman(prob);
%%
P2 = zeros(size(audioVec));

P2(1,1) = 0;
P2(2,1) = 0;

P2(3:length(P),1) = audioVec(1:k-2,1);

Y = audioVec - 2*P+P2;
c = histc(Y,min(Y):max(Y));

prob = c./k;
L2 = huffman(prob);

%% Part 2

Image = imread('boat.png');
Image = double(Image)+1;

%%
H = zeros(size(Image));
count = 0;


for i = 1:512
    for j = 1:512
       H(Image(i,j),Image(i,j)) = H(Image(i,j),Image(i,j))+1;
    end
end

prob = H./((512*512)+count);

sum(sum(prob))
logVec2 = zeros(size(Image));
for i = 1:512
    for j = 1:512
       if prob(i,j) ~= 0
            logVec2(i,j) = -sum(prob(i,j)).*log2(prob(i,j));
       else
            logVec2(i,j) = 0;
       end
    end
end
entro = sum(sum(logVec2));

%%


H = zeros(size(Image));
for i = 1:512
    for j = 1:512
       if i+1 == 513
           H(Image(i,j),Image(i,j)) = H(Image(i,j),Image(i,j))+1;
       else
           H(Image(i,j),Image(i+1,j)) = H(Image(i,j),Image(i+1,j))+1;
       end
    end
end

prob = H./(512*512);

sum(sum(prob))

logVec2 = zeros(size(Image));
for i = 1:512
    for j =1:512
       if prob(i,j) ~= 0
            logVec2(i,j) = -sum(prob(i,j)).*log2(prob(i,j));
       else
            logVec2(i,j) = 0;
       end
    end
end
entro2 = sum(sum(logVec2));
%%

H = zeros(size(Image));
for i = 1:512
    for j = 1:512
       if j+1 == 513
           H(Image(i,j),Image(i,j)) = H(Image(i,j),Image(i,j))+1;
       else
           H(Image(i,j),Image(i,j+1)) = H(Image(i,j),Image(i,j+1))+1;
       end
    end
end

prob = H./(512*512);

sum(sum(prob))

logVec2 = zeros(size(Image));
for i = 1:512
    for j =1:512
       if prob(i,j) ~= 0
            logVec2(i,j) = -sum(prob(i,j)).*log2(prob(i,j));
       else
            logVec2(i,j) = 0;
       end
    end
end
entro3 = sum(sum(logVec2));
%%
betEntro1 = entro2 -entro;
betEntro2 = entro3 -entro;

%%
Image = imread('boat.png');
Image = double(Image)+1;
vecPad = zeros(512,1);
vecPad(:,1) = 128;
Image = [Image vecPad; vecPad' 128];
 %%
%%Huffman del 2

P = zeros(size(Image));

P(:,1) = 128;

P(2:length(P),:) = Image(1:512,:);

Y = Image - P;
c = histc(Y,min(Y):max(Y));

prob3 = c./(513*513);
L = sum(huffman(prob3));

%%
P = zeros(size(Image));

P(1,:) = 128;

P(:,2:length(P)) = Image(:,1:512);

Y = Image - P;
c = histc(Y,min(Y):max(Y));

prob3 = c./(512*512);
L = sum(huffman(prob3));

%%
P = zeros(size(Image));
P1 = zeros(size(Image));
P2 = zeros(size(Image));


P(:,1) = 0;
P(2:length(P),:) = Image(1:512,:);

P1(1,:) = 0;
P1(:,2:length(P)) = Image(:,1:512);

P3(1,:) = 0;
P3(:,1) = 0;
P3(2:length(P),2:length(P)) = Image(1:512,1:512);
P4 = P3+P-P1;

Y = Image - P4;
c = histc(Y,min(Y):max(Y));

prob3 = c./(512*512);
L = sum(huffman(prob3));
