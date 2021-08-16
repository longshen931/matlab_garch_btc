%https://ww2.mathworks.cn/help/matlab/referencelist.html?type=function&category=tables&s_tid=CRUX_topnav
%https://ww2.mathworks.cn/help/matlab/ref/table.removevars.html
clc;clear all;
load("bananas");
bananas.Origin = categorical(bananas.Origin);
%Use the unique function to determine if all banana prices have the same unit

banana_name=unique(bananas(:,1));
bananas.Date = datetime(bananas.Date);
%*************************************************************************
%1.Question 1
U = unstack(bananas,'Price','Origin');
filename = 'exercise1.xlsx';
writetable(U,filename,'Sheet',1,'Range','A1');

%*************************************************************************
%2.Question 2
t1 = datetime('now');
t2 = t1 - years(5);
%Get data for the last 5 years to date
last_five_price=U(U.Date>=t2,:);

%Calculate the mean value of the data for the last 5 years
last_five_price_1=last_five_price(:,2:end)
last_five_price_mean_1=mean(table2array(last_five_price_1),'omitnan');
%Delete variables that are not useful for statistical purposes and those for which the mean is calculated to obtain na
[Values_1,Indexes_1] = sort(last_five_price_mean_1,'ascend');
last_five_price_2 = removevars(last_five_price_1,[2,Indexes_1(end-3:end)]);
%Calculate the mean value of the data for the last 5 years
last_five_price_mean_2=mean(table2array(last_five_price_2),'omitnan');
%See the top three bananas with the smallest average price
%ignore the ¡®all bananas¡¯ entries
%T2 = removevars(T1,{'Loss','Customers'});
%T3 = removevars(T2,[1 4]);
[Values_2,Indexes_2] = sort(last_five_price_mean_2,'ascend');
%Ranked in the top three from childhood to adulthood
last_five_price_2.Properties.VariableNames{1:3}
Values_2(1:3)
%Ranked in the top three from largest to smallest
last_five_price_2.Properties.VariableNames{end:-1:end-2}
Values_2(end:-1:end-2)

%*************************************************************************
%3.Question 3
%¡®costa_rica¡¯, ¡®windward_isles¡¯ and ¡®ecuador¡¯

U_costa=U(:,{'Date','costa_rica'});
TF1 = isfinite(table2array(U_costa(:,2)));
U_costa=U_costa(TF1,:);


U_windward=U(:,{'Date','windward_isles'});
TF2 = isfinite(table2array(U_windward(:,2)));
U_windward=U_windward(TF2,:);

U_ecuador=U(:,{'Date','ecuador'});
TF3 = isfinite(table2array(U_ecuador(:,2)));
U_ecuador=U_ecuador(TF3,:);

U_all=U(:,{'Date','all_bananas'});
TF4 = isfinite(table2array(U_all(:,2)));
U_all=U_all(TF4,:);

plot(U_costa.Date,U_costa.costa_rica,U_windward.Date,U_windward.windward_isles,U_ecuador.Date,U_ecuador.ecuador,U_all.Date,U_all.all_bananas,'DatetimeTickFormat','yyyy-MM')
xlabel('Time'); ylabel('Price(¡ê/kg)')
%legend('costa_rica','windward_isles','ecuador','all_bananas')
legend('costa rica','windward isles','ecuador','all bananas')
grid on

%*************************************************************************
%4.Question 4
U_costa=U(:,{'Date','costa_rica'});
TF1 = isfinite(table2array(U_costa(:,2)));
U_costa=U_costa(TF1,:);
U_costa=U_costa(U_costa.Date>="2016-01-01"&U_costa.Date<="2020-12-31",:);


U_windward=U(:,{'Date','windward_isles'});
TF2 = isfinite(table2array(U_windward(:,2)));
U_windward=U_windward(TF2,:);
U_windward=U_windward(U_windward.Date>="2016-01-01"&U_windward.Date<="2020-12-31",:);

U_ecuador=U(:,{'Date','ecuador'});
TF3 = isfinite(table2array(U_ecuador(:,2)));
U_ecuador=U_ecuador(TF3,:);
U_ecuador=U_ecuador(U_ecuador.Date>="2016-01-01"&U_ecuador.Date<="2020-12-31",:);

U_all=U(:,{'Date','all_bananas'});
TF4 = isfinite(table2array(U_all(:,2)));
U_all=U_all(TF4,:);
U_all=U_all(U_all.Date>="2016-01-01"&U_all.Date<="2020-12-31",:);

figure;
plot(U_costa.Date,U_costa.costa_rica,U_windward.Date,U_windward.windward_isles,U_ecuador.Date,U_ecuador.ecuador,U_all.Date,U_all.all_bananas,'DatetimeTickFormat','yyyy-MM')
xlabel('Time'); ylabel('Price(¡ê/kg)')
%legend('costa_rica','windward_isles','ecuador','all_bananas')
legend('costa rica','windward isles','ecuador','all bananas')
grid on

%////////////////////////////////////////////////////////////////////////////////
figure;
subplot(2,2,1);
plot(U_costa.Date,U_costa.costa_rica,'LineWidth',2,'color','red');
xlabel('Time'); ylabel('Price(¡ê/kg)')
title('costa rica');
grid on

subplot(2,2,2);
plot(U_windward.Date,U_windward.windward_isles,'LineWidth',2,'color','b');
xlabel('Time'); ylabel('Price(¡ê/kg)')
title('windward isles');
grid on

subplot(2,2,3);
plot(U_ecuador.Date,U_ecuador.ecuador,'LineWidth',2,'color','g');
xlabel('Time'); ylabel('Price(¡ê/kg)')
title('ecuador');
grid on

subplot(2,2,4);
plot(U_all.Date,U_all.all_bananas,'LineWidth',2,'color','y');
xlabel('Time'); ylabel('Price(¡ê/kg)')
title('all bananas');
grid on
%////////////////////////////////////////////////////////////////////////////////
figure;
plot(U_costa.Date,U_costa.costa_rica,'color','red','DatetimeTickFormat','yyyy-MM');
xlabel('Time'); ylabel('Price(¡ê/kg)')
title('costa rica');
grid on

figure;
plot(U_windward.Date,U_windward.windward_isles,'color','b','DatetimeTickFormat','yyyy-MM');
xlabel('Time'); ylabel('Price(¡ê/kg)')
title('windward isles');
grid on

figure;
plot(U_ecuador.Date,U_ecuador.ecuador,'color','magenta','DatetimeTickFormat','yyyy-MM');
xlabel('Time'); ylabel('Price(¡ê/kg)')
title('ecuador');
grid on

figure;
plot(U_all.Date,U_all.all_bananas,'color','cyan','DatetimeTickFormat','yyyy-MM');
xlabel('Time'); ylabel('Price(¡ê/kg)')
title('all bananas');
grid on
