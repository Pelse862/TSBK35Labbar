%samplad med 16 bitar/sampel
[soundVec, freq] = audioread('hey01.wav');
rng(0,'twister');

%Random start codebook
randomVec = randi(256,512,1000);

%%


for k = 0:1000
    R_xx(k+1) = mean(soundVec(1:end-k).*soundVec(k+1:end));
end
%%
R_x = toeplitz(R_xx(1:1001));
[A, dummy] = eig(R_x);
A = flipud(A');
%vecIndelad = reshape(soundVec',1000,[]);

tsound

%R_teta = A*R_x*A';

%kvantisera, nästa på listan likformig


%huffman eller nått sånt


%audiowrite('lol.wav',R_teta,44100);





