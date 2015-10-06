%samplad med 16 bitar/sampel
[soundVec, freq] = audioread('hey01.wav');
%sound(soundVec,freq);
rng(0,'twister');
soundVec2 = soundVec;
soundVec = soundVec;
%Random start codebook
blockSize = 256;

%%


for k = 0:(blockSize-1)
    R_xx(k+1) = mean(soundVec(1:end-k).*soundVec(k+1:end));
    k;
end
%%
R_x = toeplitz(R_xx(1:blockSize));
[A, dummy] = eig((R_x));

A = flipud(A');

vecIndelad = reshape(soundVec',blockSize,[]);
%tsound


KLT = A *vecIndelad;
%R_teta = A*R_x*A';
%KLT = reshape(KLT,[],1);
%kvantisera, nästa på listan likformig
delta = 0.001;
qKLT = delta* (abs(KLT/delta)+0.5);
k = KLT/delta;
%qKLT = qKLT/delta;


X = (A)\qKLT;


X = reshape(X,[],1);
x2 = abs(X);
%huffman eller nått sånt
x2 = x2*128+128;

H = zeros(500, 1);
for n = 1:size(x2)
    H(round(x2(n)))= H(round(x2(n)))+1;
end

L = 0;

L = huffman(H);
L = L/length(soundVec);



%%

plot(soundVec(1:1000,1),'x')
hold on
sound(X,freq)
plot(X(1:1000,1),'.')
%audiowrite('lol.wav',R_teta,44100);





