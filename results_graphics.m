clc;

load results_rand_1.mat;
load results_rand_01.mat;
load results_rand_001.mat;
load results_split_1.mat;
load results_split_01.mat;
load results_split_001.mat;
%
load results_16_rand_1.mat;
load results_16_rand_01.mat;
load results_16_rand_001.mat;
load results_16_split_1.mat;
load results_16_split_01.mat;
load results_16_split_001.mat;

mean_train_16_split_1 = mean(train_16_split_1_psnr);
mean_train_16_split_01 = mean(train_16_split_01_psnr);
mean_train_16_split_001 = mean(train_16_split_001_psnr);
std_train_16_split_1 = std(train_16_split_1_psnr);
std_train_16_split_01 = std(train_16_split_01_psnr);
std_train_16_split_001 = std(train_16_split_001_psnr);

mean_test_16_split_1 = mean(test_16_split_1_psnr);
mean_test_16_split_01 = mean(test_16_split_01_psnr);
mean_test_16_split_001 = mean(test_16_split_001_psnr);
std_test_16_split_1 = std(test_16_split_1_psnr);
std_test_16_split_01 = std(test_16_split_01_psnr);
std_test_16_split_001 = std(test_16_split_001_psnr);

mean_train_split_1 = mean(train_split_1_psnr);
mean_train_split_01 = mean(train_split_01_psnr);
mean_train_split_001 = mean(train_split_001_psnr);
std_train_split_1 = std(train_split_1_psnr);
std_train_split_01 = std(train_split_01_psnr);
std_train_split_001 = std(train_split_001_psnr);

mean_test_split_1 = mean(test_split_1_psnr);
mean_test_split_01 = mean(test_split_01_psnr);
mean_test_split_001 = mean(test_split_001_psnr);
std_test_split_1 = std(test_split_1_psnr);
std_test_split_01 = std(test_split_01_psnr);
std_test_split_001 = std(test_split_001_psnr);

%%

mean_train_16_rand_1 = mean(train_16_rand_1_psnr);
mean_train_16_rand_01 = mean(train_16_rand_01_psnr);
mean_train_16_rand_001 = mean(train_16_rand_001_psnr);
std_train_16_rand_1 = std(train_16_rand_1_psnr);
std_train_16_rand_01 = std(train_16_rand_01_psnr);
std_train_16_rand_001 = std(train_16_rand_001_psnr);

mean_test_16_rand_1 = mean(test_16_rand_1_psnr);
mean_test_16_rand_01 = mean(test_16_rand_01_psnr);
mean_test_16_rand_001 = mean(test_16_rand_001_psnr);
std_test_16_rand_1 = std(test_16_rand_1_psnr);
std_test_16_rand_01 = std(test_16_rand_01_psnr);
std_test_16_rand_001 = std(test_16_rand_001_psnr);

mean_train_rand_1 = mean(train_rand_1_psnr);
mean_train_rand_01 = mean(train_rand_01_psnr);
mean_train_rand_001 = mean(train_rand_001_psnr);
std_train_rand_1 = std(train_rand_1_psnr);
std_train_rand_01 = std(train_rand_01_psnr);
std_train_rand_001 = std(train_rand_001_psnr);

mean_test_rand_1 = mean(test_rand_1_psnr);
mean_test_rand_01 = mean(test_rand_01_psnr);
mean_test_rand_001 = mean(test_rand_001_psnr);
std_test_rand_1 = std(test_rand_1_psnr);
std_test_rand_01 = std(test_rand_01_psnr);
std_test_rand_001 = std(test_rand_001_psnr);

%% epsilon = 0.1

x1 = 1:2;
x2 = 3:4;
x3 = 5:6;
x4 = 7:8;
y1 = [mean_train_rand_1 mean_test_rand_1];
y2 = [mean_train_split_1 mean_test_split_1];
y3 = [mean_train_16_rand_1 mean_test_16_rand_1];
y4 = [mean_train_16_split_1 mean_test_16_split_1];
    
err1 = [1.96*std_train_rand_1/sqrt(length(train_rand_1_psnr)) 1.96*std_test_rand_1/sqrt(length(test_rand_1_psnr))];
err2 = [1.96*std_train_split_1/sqrt(length(train_split_1_psnr)) 1.96*std_test_split_1/sqrt(length(test_split_1_psnr))];
err3 = [1.96*std_train_16_rand_1/sqrt(length(train_16_rand_1_psnr)) 1.96*std_test_16_rand_1/sqrt(length(test_16_rand_1_psnr))];
err4 = [1.96*std_train_16_split_1/sqrt(length(train_16_split_1_psnr)) 1.96*std_test_16_split_1/sqrt(length(test_16_split_1_psnr))];  

figure;
errorbar(x1,y1,err1,'*k','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
axis([0 9 20 36]);
hold on;
grid on;
errorbar(x2,y2,err2,'*r','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
errorbar(x3,y3,err3,'ok','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
errorbar(x4,y4,err4,'or','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
xticklabels({'','TRAIN','TEST','TRAIN','TEST','TRAIN','TEST','TRAIN','TEST',''});
ylabel('PSNR','FontSize',12,'FontWeight','bold');
legend({'L=4; random','L=4; split','L=16; random','L=16; split'},'Orientation','horizontal','location','north','FontSize',15);

%% epsilon = 0.01

y1 = [mean_train_rand_01 mean_test_rand_01];
y2 = [mean_train_split_01 mean_test_split_01];
y3 = [mean_train_16_rand_01 mean_test_16_rand_01];
y4 = [mean_train_16_split_01 mean_test_16_split_01];
    
err1 = [1.96*std_train_rand_01/sqrt(length(train_rand_01_psnr)) 1.96*std_test_rand_01/sqrt(length(test_rand_01_psnr))];
err2 = [1.96*std_train_split_01/sqrt(length(train_split_01_psnr)) 1.96*std_test_split_01/sqrt(length(test_split_01_psnr))];
err3 = [1.96*std_train_16_rand_01/sqrt(length(train_16_rand_01_psnr)) 1.96*std_test_16_rand_01/sqrt(length(test_16_rand_01_psnr))];
err4 = [1.96*std_train_16_split_01/sqrt(length(train_16_split_01_psnr)) 1.96*std_test_16_split_01/sqrt(length(test_16_split_01_psnr))];  

figure;
errorbar(x1,y1,err1,'*k','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
axis([0 9 20 36]);
hold on;
grid on;
errorbar(x2,y2,err2,'*r','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
errorbar(x3,y3,err3,'ok','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
errorbar(x4,y4,err4,'or','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
xticklabels({'','TRAIN','TEST','TRAIN','TEST','TRAIN','TEST','TRAIN','TEST',''});
ylabel('PSNR','FontSize',12,'FontWeight','bold');
legend({'L=4; random','L=4; split','L=16; random','L=16; split'},'Orientation','horizontal','location','north','FontSize',15);

%% epsilon = 0.001

y1 = [mean_train_rand_001 mean_test_rand_001];
y2 = [mean_train_split_001 mean_test_split_001];
y3 = [mean_train_16_rand_001 mean_test_16_rand_001];
y4 = [mean_train_16_split_001 mean_test_16_split_001];
    
err1 = [1.96*std_train_rand_001/sqrt(length(train_rand_001_psnr)) 1.96*std_test_rand_001/sqrt(length(test_rand_001_psnr))];
err2 = [1.96*std_train_split_001/sqrt(length(train_split_001_psnr)) 1.96*std_test_split_001/sqrt(length(test_split_001_psnr))];
err3 = [1.96*std_train_16_rand_001/sqrt(length(train_16_rand_001_psnr)) 1.96*std_test_16_rand_001/sqrt(length(test_16_rand_001_psnr))];
err4 = [1.96*std_train_16_split_001/sqrt(length(train_16_split_001_psnr)) 1.96*std_test_16_split_001/sqrt(length(test_16_split_001_psnr))];  

figure;
errorbar(x1,y1,err1,'*k','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
axis([0 9 20 36]);
hold on;
grid on;
errorbar(x2,y2,err2,'*r','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
errorbar(x3,y3,err3,'ok','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
errorbar(x4,y4,err4,'or','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
xticklabels({'','TRAIN','TEST','TRAIN','TEST','TRAIN','TEST','TRAIN','TEST',''});
ylabel('PSNR','FontSize',12,'FontWeight','bold');
legend({'L=4; random','L=4; split','L=16; random','L=16; split'},'Orientation','horizontal','location','north','FontSize',15);