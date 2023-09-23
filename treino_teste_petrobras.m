function [Treino_petro,Teste_petro] = treino_teste_petrobras()
    % Importando dados 
    petro = readtable("./data/PETR4.SA.csv","ReadVariableNames",false);
    
    % Filtrando os valores para somente o preço de fechamento
    % Filtrando também somente para os dois ultimos anos
    petro = table2array(petro(501:990,5));

    Treino_petro = petro(1:400);
    Teste_petro = petro(401:end);
end