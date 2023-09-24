function [Treino_petro,Teste_petro,Treino_embr,Teste_embr,Treino_vale,Teste_vale] = treino_teste()
    % Importando dados 
    petro = readtable("./data/PETR4.SA.csv","ReadVariableNames",false);
    vale = readtable("./data/VALE3.SA.csv","ReadVariableNames",false);
    embr = readtable("./data/EMBR3.SA.csv","ReadVariableNames",false);

    % Filtrando os valores para somente o preço de fechamento
    % Filtrando também somente para os dois ultimos anos
    petro = table2array(petro(501:990,5));
    vale = table2array(vale(501:990,5));
    embr = table2array(embr(501:990,5));

    Treino_petro = petro(1:400);
    Teste_petro = petro(401:end);
    Treino_embr = embr(1:400);
    Teste_embr = embr(401:end);
    Treino_vale = vale(1:400);
    Teste_vale = vale(401:end);
end