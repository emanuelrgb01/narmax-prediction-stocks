function [P_petro,P_vale,P_embr,T_petro,T_vale,T_embr] = matrizes()
    % Importando dados
    
    petro = readtable("PETR4.SA.csv","ReadVariableNames",false);
    vale = readtable("VALE3.SA.csv","ReadVariableNames",false);
    embr = readtable("EMBR3.SA.csv","ReadVariableNames",false);
    
    % Filtrando os valores para somente o preço de fechamento
    petro = table2array(petro(:,5));
    vale = table2array(vale(:,5));
    embr = table2array(embr(:,5));
    
    % Matrizes de entrada e treinamento
    P_petro = zeros(30,89);
    P_vale = zeros(30,89);
    P_embr = zeros(30,89);
    
    T_petro = zeros(10,89);
    T_vale = zeros(10,89);
    T_embr = zeros(10,89);
    
    
    %% Matrizes de entrada e treinamento para as tres redes neurais
    % Sao usados somente os 900 primeiros precos das acoes
    for i = 1:89
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



