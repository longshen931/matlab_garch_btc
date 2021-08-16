%https://ww2.mathworks.cn/help/econ/garch.html?searchHighlight=garch&s_tid=srchtitle#buo5jal-1
%https://ww2.mathworks.cn/help/econ/ssm.forecast.html?searchHighlight=forecast&s_tid=srchtitle#bt_w71w

load data
open_price=CME2020(:,2);
open_price=open_price{:,:};
date = datetime(table2array(CME2020(:,1)));
date=date(2:end,:);
r= price2ret(open_price);


figure;
plot(date,r);
hold on;
plot([date(1) date(end)],[0 0],'r:'); % Plot y = 0
hold off;
title('Stock Returns');
ylabel('Nominal return (%)');
xlabel('Day');

%-----------------------------------------------------------------------
%Create a GARCH(1,1) model with an unknown conditional mean offset. Fit the model to the annual nominal return series.
Mdl = garch('GARCHLags',1,'ARCHLags',1,'Offset',NaN);
EstMdl = estimate(Mdl,r);
%Simulate 100 paths of conditional variances and responses for each period from the estimated GARCH model.
numObs = numel(r); % Sample size (T)
numPaths = 100;     % Number of paths to simulate
rng(1);             % For reproducibility
[VSim,YSim] = simulate(EstMdl,numObs,'NumPaths',numPaths);

%VSim and YSim are T-by- numPaths matrices. Rows correspond to a sample period, and columns correspond to a simulated path.
%Plot the average and the 97.5% and 2.5% percentiles of the simulated paths. Compare the simulation statistics to the original data.
VSimBar = mean(VSim,2);
VSimCI = quantile(VSim,[0.025 0.975],2);
YSimBar = mean(YSim,2);
YSimCI = quantile(YSim,[0.025 0.975],2);

figure;
subplot(2,1,1);
h1 = plot(date,VSim,'Color',0.8*ones(1,3));
hold on;
h2 = plot(date,VSimBar,'k--','LineWidth',2);
h3 = plot(date,VSimCI,'r--','LineWidth',2);
hold off;
title('Simulated Conditional Variances');
ylabel('Cond. var.');
xlabel('Day');

subplot(2,1,2);
h1 = plot(date,YSim,'Color',0.8*ones(1,3));
hold on;
h2 = plot(date,YSimBar,'k--','LineWidth',2);
h3 = plot(date,YSimCI,'r--','LineWidth',2);
hold off;
title('Simulated Nominal Returns');
ylabel('Nominal return (%)');
xlabel('Day');
legend([h1(1) h2 h3(1)],{'Simulated path' 'Mean' 'Confidence bounds'},...
    'FontSize',7,'Location','NorthWest');
