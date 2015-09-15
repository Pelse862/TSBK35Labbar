
%% Entropi ljud
frequenzy = 44100;

[audioVec, f] = audioread('speech.wav');

audioVec = 128*audioVec+128;
[k, j] = size(audioVec);


%%
H = zeros(256, 1);
for n = 1:size(audioVec)
    H(audioVec(n))= H(audioVec(n))+1;
end
%prob = zeros(256,1);
prob = H./65600;

logVec = zeros(256,1);
for i = 1:256
   if prob(i) ~= 0
        logVec(i) = -sum(prob(i)).*log2(prob(i));
   else
        logVec(i) = 0;
   end
end

if(f == 44100)
    
    entro = sum(logVec)/(44100/8000);
else
    entro = sum(logVec);
end

%%  kolla på hur ofta paren uppstår i signalen istället för hur ofta karaktär speciell uppstår

H = zeros(256,256);
l = 12;
%kollar alla möjliga kombinationer av värdena, ex (0,0) mot hela vektorn
for i = 1:256
    for l2 = 1:256 
        if(ismember([i-1,l2-1],audioVec(:,1)))
          H(i,l2) = H(i,l2) +1; 
        end
    end

end

prob2 = H./k;

logVec2 = zeros(256,1);
for i = 1:256
    for l3 = 1:256
       if prob2(i,l3) ~= 0
            logVec2(i,l3) = -sum(prob2(i,l3)).*log2(prob2(i,l3));
       else
            logVec2(i,l3) = 0;
       end
    end
end

if(f == 44100)
    
    entro = sum(sum(logVec2))/(44100/8000);
else
    entro = sum(sum(logVec2));
end


%%






