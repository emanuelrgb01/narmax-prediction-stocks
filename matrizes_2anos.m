function [P_petro,P_vale,P_embr,T_petro,T_vale,T_embr] = matriz_2anos()
    % Importando dados 
    petro = readtable("./data/PETR4.SA.csv","ReadVariableNames",false);
    vale = readtable("./data/VALE3.SA.csv","ReadVariableNames",false);
    embr = readtable("./data/EMBR3.SA.csv","ReadVariableNames",false);
    
    % Filtrando os valores para somente o preço de fechamento
    % Filtrando também somente para os dois ultimos anos
    petro = table2array(petro(481:990,5));
    vale = table2array(vale(481:990,5));
    embr = table2array(embr(481:990,5));
    
    % Matrizes de entrada e treinamento
    P_petro = zeros(30,42);
    P_vale = zeros(30,42);
    P_embr = zeros(30,42);
    
    T_petro = zeros(10,42);
    T_vale = zeros(10,42);
    T_embr = zeros(10,42);
    
    %% Matrizes de entrada e treinamento para as tres redes neurais
    % Sao usados somente os 900 primeiros precos das acoes
    for i = 1:42
        % Matriz de entrada rede PETRO
        % Dez primeiras linhas com precos de petro
        % Linhas 11-20 com precos vale
        % Linhas 21-30 com precos embr
        % O mesmo padrao se repete para as outras matrizes de entrada
    
        P_petro(1:10,i) = petro(10*(i-1)+1:10*i,1);
        P_petro(11:20,i) = vale(10*(i-1)+1:10*i,1);
        P_petro(21:30,i) = embr(10*(i-1)+1:10*i,1); 
    
    
        % Matriz de treinamento PETRO
        T_petro(1:10,i) = petro(10*i+1:10*(i+1),1);
    
        % Matriz de entrada rede VALE
        P_vale(1:10,i) = petro(10*(i-1)+1:10*i,1);
        P_vale(11:20,i) = vale(10*(i-1)+1:10*i,1);
        P_vale(21:30,i) = embr(10*(i-1)+1:10*i,1); 
    
        % Matriz de treinamento rede VALE
        T_vale(1:10,i) = vale(10*i+1:10*(i+1),1);
    
        % Matriz de entrada rede EMBR
        P_embr(1:10,i) = petro(10*(i-1)+1:10*i,1);
        P_embr(11:20,i) = vale(10*(i-1)+1:10*i,1);
        P_embr(21:30,i) = embr(10*(i-1)+1:10*i,1); 
    
    
        % Matriz de treinamento rede EMBR
        T_embr(1:10,i) = embr(10*i+1:10*(i+1),1);
    end
end