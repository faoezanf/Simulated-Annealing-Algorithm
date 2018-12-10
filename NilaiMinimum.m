SuhuAwal = 10000;                                                          % menge-set suhu sebesar 10000
SuhuAkhir = 1;                                                             % menge-set suhu akhir menjadi 1
CoolingRate = 0.8;                                                         % menge-set penurunan suhu sebesar 80 dari suhu awal%
index = 1;                                                                 % index untuk perulangan 
indexBSF = 1;                                                              % index array best so far
phi = 22/7;                                                                % nilai phi
batasBawah = -10;                                                          % range bilangan x1 random terkecil
batasAtas = 10;                                                            % range bilangan x2 random terbesar

x1current = (batasAtas-batasBawah).*rand(1,1) + batasBawah;                % menggenerate bilangan random untuk x1
x2current = (batasAtas-batasBawah).*rand(1,1) + batasBawah;                % menggenerate bilangan random untuk x2

fxCurrent = sin(x1current)*cos(x2current);                                                      % perkalian sin(x1) x cos(x2) disimpan di variable fx
fxCurrent = fxCurrent * exp(abs(1-((sqrt((x1current*x1current)+(x2current*x2current)))/phi)));  % perkalian fx dengan eksponen
fxCurrent = abs(fxCurrent) * -1;                                                                % memutlakkan fx lalu dikali negatif 1

while(SuhuAwal>SuhuAkhir)                                                  % perulangan berdasarkan suhu
    while(index<1000)                                                      % perulangan berdasarkan index

        x1new = (batasAtas-batasBawah).*rand(1,1) + batasBawah;            % menge-set interval -> a<x1<b
        x2new = (batasAtas-batasBawah).*rand(1,1) + batasBawah;            % menge-set interval -> a<x2<b
          
        fxNew = sin(x1new)*cos(x2new);                                        
        fxNew = fxNew * exp(abs(1-((sqrt((x1new*x1new)+(x2new*x2new)))/phi)));
        fxNew = abs(fxNew) * -1;
        
        delta_E = fxNew - fxCurrent;                                       % memasukkan nilai next dari fx dikurang nilai current dari fx dan disimpan di variabel delta_E
        
        if delta_E<0                                                       % mengondisikan 'if' jika delta_E bernilai negatif                    
            bestSoFar(indexBSF) = fxNew;                                   % mengeset hasil next fx dan disimpan ke array bestSoFar
            bestSoFarX1(indexBSF) = x1new;                                 % mengeset hasil next x1 dan disimpan ke array bestSoFarX1
            bestSoFarX2(indexBSF) = x2new;                                 % mengeset hasil next x2 dan disimpan ke array bestSoFarX2
            indexBSF = indexBSF + 1;                                       % iterasi indexBSF
        else
            randomProb = rand;                                             % bilangan random dari 0 sampai 1

            P = exp( (-1 * (delta_E)) / SuhuAwal);                         % rumus probabilistik

            if randomProb<P                                                % pengondisian jika randomProb lebih kecil dari P, maka fxNew dan x nya dimasukkan ke kumpulan solusi
                bestSoFar(indexBSF) = fxNew;
                bestSoFarX1(indexBSF) = x1new;
                bestSoFarX2(indexBSF) = x2new;
                indexBSF = indexBSF + 1;
            end
        end
        index = index + 1;
    end
    
    fxCurrent = fxNew;                                                     % mengeset fxCurrent dengan fxNew agar dibandingkann di iterasi selanjutnya.
    SuhuAwal = SuhuAwal * CoolingRate;                                     % penurunan suhu awal sebanyak 20% (80% dari suhu sebelumnya)
    index = 1;                                                             % mengeset ulang index = 1
end

solusi = min(bestSoFar);                                                   % mencari nilai minimum dari array bestSoFar dan di isi ke variabel solusi

x=find(bestSoFar==solusi);                                                 % mencari indeks dari solusi berada

solusiX1 = bestSoFarX1(x);                                                 % mengeset nilai x1 sesuai best so far
solusiX2 = bestSoFarX2(x);                                                 % mengeset nilai x2 sesuai best so far

disp(['Nilai x1 yang memenuhi adalah : ',num2str(solusiX1)]);
disp(['Nilai x2 yang memenuhi adalah : ',num2str(solusiX2)]);
disp(['Jadi nilai minimum dari fungsi tersebut adalah :',num2str(solusi)]);

                                                                                                                                                                                                                                                                                                                                                                                                            