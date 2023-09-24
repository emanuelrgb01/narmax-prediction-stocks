clear

% Matrizes para as três redes neurais
[P_petro,P_vale,P_embr,T_petro,T_vale,T_embr] = matrizes_2anos();

% Criando as redes neurais com 15 neuronios na camada interna
net_petro = feedforwardnet(15);
net_vale = feedforwardnet(15);
net_embr = feedforwardnet(15);

% Configurando as três redes neurais
net_petro = configure(net_petro,P_petro,T_petro);
net_vale = configure(net_vale,P_vale,T_vale);
net_embr = configure(net_embr,P_embr,T_embr);

%% Pré processamento dos dados 
% Normalizando os padrões de treinamento de entrada/saida entre 0 e 1
net_petro.inputs{1}.processParams{2}.ymin = 0;
net_petro.inputs{1}.processParams{2}.ymax = 1;
net_petro.outputs{2}.processParams{2}.ymin = 0;
net_petro.outputs{2}.processParams{2}.ymax = 1;

net_vale.inputs{1}.processParams{2}.ymin = 0;
net_vale.inputs{1}.processParams{2}.ymax = 1;
net_vale.outputs{2}.processParams{2}.ymin = 0;
net_vale.outputs{2}.processParams{2}.ymax = 1;

net_embr.inputs{1}.processParams{2}.ymin = 0;
net_embr.inputs{1}.processParams{2}.ymax = 1;
net_embr.outputs{2}.processParams{2}.ymin = 0;
net_embr.outputs{2}.processParams{2}.ymax = 1;

% Usando todos os dados para treinamento
net_petro.divideFcn = 'dividerand';
net_petro.divideParam.trainRatio = 1;
net_petro.divideParam.valRatio = 0;
net_petro.divideParam.testRatio = 0;

net_vale.divideFcn = 'dividerand';
net_vale.divideParam.trainRatio = 1;
net_vale.divideParam.valRatio = 0;
net_vale.divideParam.testRatio = 0;

net_embr.divideFcn = 'dividerand';
net_embr.divideParam.trainRatio = 1;
net_embr.divideParam.valRatio = 0;
net_embr.divideParam.testRatio = 0;

% Iniciando os pesos das redes
net_petro = init(net_petro);
net_vale = init(net_vale);
net_embr = init(net_embr);

%% Treinamento das redes
% Rede petro
net_petro.trainParam.showWindow = true;
net_petro.layers{1}.dimensions = 15;
net_petro.layers{1}.transferFcn = 'tansig';
net_petro.layers{2}.transferFcn = 'purelin';
net_petro.performFcn = 'mse';
net_petro.trainFcn = 'trainlm';
net_petro.trainParam.epochs = 10000;
net_petro.trainParam.time = 1200;
net_petro.trainParam.lr = 0.2;
net_petro.trainParam.min_grad = 10^-15;
net_petro.trainParam.max_fail = 1000;

[net_petro, tr_petro] = train(net_petro,P_petro,T_petro)

%%
% Rede vale
net_vale.trainParam.showWindow = true;
net_vale.layers{1}.dimensions = 15;
net_vale.layers{1}.transferFcn = 'tansig';
net_vale.layers{2}.transferFcn = 'purelin';
net_vale.performFcn = 'mse';
net_vale.trainFcn = 'trainlm';
net_vale.trainParam.epochs = 10000;
net_vale.trainParam.time = 1200;
net_vale.trainParam.lr = 0.2;
net_vale.trainParam.min_grad = 10^-15;
net_vale.trainParam.max_fail = 1000;

[net_vale, tr_vale] = train(net_vale,P_vale,T_vale)

%%
% Rede embr
net_vale.trainParam.showWindow = true;
net_vale.layers{1}.dimensions = 15;
net_vale.layers{1}.transferFcn = 'tansig';
net_vale.layers{2}.transferFcn = 'purelin';
net_vale.performFcn = 'mse';
net_vale.trainFcn = 'trainlm';
net_vale.trainParam.epochs = 10000;
net_vale.trainParam.time = 1200;
net_vale.trainParam.lr = 0.2;
net_vale.trainParam.min_grad = 10^-15;
net_vale.trainParam.max_fail = 1000;

[net_embr, tr_embr] = train(net_embr,P_embr,T_embr)

%% Performance

%plotperf(tr_petro)
%plotperf(tr_vale)
%plotperf(tr_embr)

%% Teste
verificacao_Petro_passado = [];
for i = 1:39
    aux = net_petro(P_petro(:,i));
    verificacao_Petro_passado = [verificacao_Petro_passado; aux];
end

verificacao_Petro_predicao =  [net_petro(P_petro(:,40))];
dados_teste_petro = [T_petro; T_vale; T_embr];

for i = 1:8
    aux = net_petro(dados_teste_petro(:,i));
    verificacao_Petro_predicao = [verificacao_Petro_predicao; aux];
end

[Treino_petro,Teste_petro,Treino_embr,Teste_embr,Treino_vale,Teste_vale] = treino_teste();

hold on
plot(1:1:400, Treino_petro,color='#00498A')
plot(401:1:490,Teste_petro,color='#26A608')
plot(11:1:400, verificacao_Petro_passado,401:1:490, verificacao_Petro_predicao,color='#CD1818')

