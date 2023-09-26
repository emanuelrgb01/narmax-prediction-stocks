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
net_embr.trainParam.showWindow = true;
net_embr.layers{1}.dimensions = 15;
net_embr.layers{1}.transferFcn = 'tansig';
net_embr.layers{2}.transferFcn = 'purelin';
net_embr.performFcn = 'mse';
net_embr.trainFcn = 'trainlm';
net_embr.trainParam.epochs = 10000;
net_embr.trainParam.time = 1200;
net_embr.trainParam.lr = 0.2;
net_embr.trainParam.min_grad = 10^-15;
net_embr.trainParam.max_fail = 1000;

[net_embr, tr_embr] = train(net_embr,P_embr,T_embr)

%% Performance

%plotperf(tr_petro)
%plotperf(tr_vale)
%plotperf(tr_embr)

%% Teste
% Valores das cotacoes reais para serem comparados
[Treino_petro,Teste_petro,Treino_embr,Teste_embr,Treino_vale,Teste_vale] = treino_teste();

% Previsão dos precos de todas as acoes usando as tres redes neurais
precos_previsao = [];
petro_previsao = [];

% Inicio da previsao
% O valor final da previsao deve ser no máximo o limite de colunas dos
% precos. Para 2 anos é de 49
fim_previsao = 49-7;

% Iniciando a simulacao com os precos iniciais
precos_previsao = [precos_previsao,P_petro(:,40)];
petro_previsao = [petro_previsao;P_petro(1:10,40)];

% Precos previstos
for i=1:fim_previsao-41

    % Previsao dos precos usando as tres redes neurais
    precos_previsao(1:10,i+1) = net_petro(precos_previsao(:,i));
    precos_previsao(11:20,i+1) = net_vale(precos_previsao(:,i));
    precos_previsao(21:30,i+1) = net_embr(precos_previsao(:,i));

    % Previsao do preco da petro
    petro_previsao = [petro_previsao;precos_previsao(1:10,i+1)];
end

% Gráfico teste
plot(401:1:10*fim_previsao,petro_previsao,'r') % Precos previstos pretro

hold on
plot(1:1:400, Treino_petro,color='#00498A') % Precos reais da petro
plot(401:1:10*fim_previsao,Teste_petro(1:(fim_previsao-40)*10),color='black') % Precos reais da petro
hold off