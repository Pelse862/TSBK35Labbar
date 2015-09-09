
%% Entropi ljud
frequenzy = 44100;
kvant = 8;
audioVec = audioread('speech.wav');
audioVec = 128*audioVec+128;
[k, j] = size(audioVec);

H = zeros(256, 1);
for n = 1:size(audioVec)
    H(audioVec(n))= H(audioVec(n))+1;
end
prob = zeros(256,1);
prob = H./65600;



logVec = zeros(256,1);
for i = 1:256
   if prob(i) ~= 0
        logVec(i) = -sum(prob(i)).*log2(prob(i));
   else
        logVec(i) = 0;
   end
end

entro = sum(logVec);

%%  
probMatrix = [prob(:,1)', 256];
vec = ones(256,1);
x = vec/probMatrix;
