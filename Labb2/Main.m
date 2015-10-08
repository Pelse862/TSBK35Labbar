%samplad med 16 bitar/sampel
[soundVec, freq] = audioread('hey01.wav');
%sound(soundVec,freq);
rng(0,'twister');
soundVec2 = soundVec;
soundVec = soundVec;
%Random start codebook
blockSize = 256;

%%
R_xx = zeros(blockSize);
for k = 0:(blockSize-1)
    R_xx(k+1) = mean(soundVec(1:end-k).*soundVec(k+1:end));
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
delta = 0.1;
Y = sign(KLT);
qKLT1 =  (round(KLT/delta));
qKLT = delta *qKLT1;
%qKLT = qKLT/delta;

X = (A')*qKLT;


X = reshape(X,[],1);


x2 = (round(qKLT1));
%huffman eller nått sånt
x2 = x2- min(min(x2))+1;

H = zeros( round(max(max((x2))))+1, 1);
for n = 1:size(x2)
    H(round(x2(n))+1)= H(round(x2(n))+1)+1;    
end

L = 0;

L = huffman(H);
L = L/length(H);



%%
grid on
plot(soundVec(5120:6000,1))
hold on
sound(X,freq)
plot(X(5120:6000))
%audiowrite('lol.wav',R_teta,44100);

%%





