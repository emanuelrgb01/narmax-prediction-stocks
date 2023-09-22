% Importando dados
clear

petro = readtable("./data/PETR4.SA.csv","ReadVariableNames",false)
% Filtrando os valores para somente o preço de fechamento
petro = table2array(petro(:,5));


%% Cálculos necessários para o expoente de Hurst
k = length(petro); % Tamanho inicial para calculo da série
expected_ratio = []; % E[Rk/Sk]
used_k = []; % Valores k utilizados para a análise, somente k>=8

while k > 10
    v = [];
    r = [];
    s = [];
    ratio =[];


    for i=1:k
        mean_petro = mean(petro(1:k,1));
        delta_x(i) = petro(i) - mean_petro;
        delta_x_squared(i) = delta_x(i)^2;
    

        % Tratando o inicio do vetor v
        if i > 1
            v(i) = v(i-1) + delta_x(i);
        elseif i == 1
            v(i) = delta_x(i); 
        end

        r(i) = max(v) - min(v);
        s(i) = std(petro(1:i));

        % Tratando divisao por zero
        ratio(1) = 0;
        if i ~= 1
            ratio(i) = r(i)/s(i);
        end
    end

    used_k = [used_k,k];
    expected_ratio = [expected_ratio,mean(ratio)];
    k = ceil(k/2); % Atualizando o valor de k para próximo loop
end

%% Regressão linear com os dados obtidos
Y = log2(expected_ratio);
X = log2(used_k);

linear_model = fitlm(X,Y)

% Gráfico da regressão linear
plot(linear_model)

hold on 
ylabel('Log2(R/S)');
xlabel('Log2(k)');
title('');

hold off

