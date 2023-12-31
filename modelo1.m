clear

% Matrizes para as três redes neurais
[P_petro,P_vale,P_embr,T_petro,T_vale,T_embr] = matrizes();

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
% Rede Petro
net_petro.trainParam.showWindow = true;
net_petro.layers{1}.dimensions = 15;
net_petro.layers{1}.transferFcn = 'tansig';
net_petro.layers{2}.transferFcn = 'purelin';
net_petro.performFcn = 'mse';
net_petro.trainFcn = 'trainlm';
net_petro.trainParam.epochs = 10000;
net_petro.trainParam.time = 120;
net_petro.trainParam.lr = 0.2;
net_petro.trainParam.min_grad = 10^-8;
net_petro.trainParam.max_fail = 1000;

[net_petro, tr] = train(net_petro,P_petro,T_petro)