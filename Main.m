
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






