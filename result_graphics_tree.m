load results_tree_rand_1.mat;
load results_tree_rand_001.mat;

mean_train_tree_rand_1 = mean(train_rand_1_psnr);
mean_train_tree_rand_001 = mean(train_rand_001_psnr);
std_train_tree_rand_1 = std(train_rand_1_psnr);
std_train_tree_rand_001 = std(train_rand_001_psnr);
mean_test_tree_rand_1 = mean(test_rand_1_psnr);
mean_test_tree_rand_001 = mean(test_rand_001_psnr);
std_test_tree_rand_1 = std(test_rand_1_psnr);
std_test_tree_rand_001 = std(test_rand_001_psnr);


%%

load results_tree_16_rand_1.mat;
load results_tree_16_rand_001.mat;

mean_train_tree_16_rand_1 = mean(train_rand_1_psnr);
mean_train_tree_16_rand_001 = mean(train_rand_001_psnr);
std_train_tree_16_rand_1 = std(train_rand_1_psnr);
std_train_tree_16_rand_001 = std(train_rand_001_psnr);
mean_test_tree_16_rand_1 = mean(test_rand_1_psnr);
mean_test_tree_16_rand_001 = mean(test_rand_001_psnr);
std_test_tree_16_rand_1 = std(test_rand_1_psnr);
std_test_tree_16_rand_001 = std(test_rand_001_psnr);

%% epsilon = 1

x1 = 1:2;
x2 = 3:4;

y1 = [mean_train_tree_rand_1 mean_test_tree_rand_1];
y2 = [mean_train_tree_16_rand_1 mean_test_tree_16_rand_1];

    
err1 = [1.96*std_train_tree_rand_1/sqrt(length(train_rand_1_psnr)) 1.96*std_test_tree_rand_1/sqrt(length(test_rand_1_psnr))];
err2 = [1.96*std_train_tree_16_rand_1/sqrt(length(train_rand_1_psnr)) 1.96*std_test_tree_16_rand_1/sqrt(length(train_rand_1_psnr))];

figure;
errorbar(x1,y1,err1,'*k','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
axis([0 9 20 36]);
hold on;
grid on;
errorbar(x2,y2,err2,'*r','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');

xticklabels({'','TRAIN','TEST','TRAIN','TEST',''});
ylabel('PSNR','FontSize',12,'FontWeight','bold');
legend({'L=4; random','L=4; split'},'Orientation','horizontal','location','north','FontSize',15);

%% epsilon = 001

x1 = 1:2;
x2 = 3:4;

y1 = [mean_train_tree_rand_001 mean_test_tree_rand_001];
y2 = [mean_train_tree_16_rand_001 mean_test_tree_16_rand_001];

    
err1 = [1.96*std_train_tree_rand_001/sqrt(length(train_rand_001_psnr)) 1.96*std_test_tree_rand_001/sqrt(length(test_rand_001_psnr))];
err2 = [1.96*std_train_tree_16_rand_001/sqrt(length(train_rand_001_psnr)) 1.96*std_test_tree_16_rand_001/sqrt(length(train_rand_001_psnr))];

figure;
errorbar(x1,y1,err1,'*k','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');
axis([0 9 20 36]);
hold on;
grid on;
errorbar(x2,y2,err2,'*r','MarkerSize',10,'LineWidth',1.5,'LineStyle','None');

xticklabels({'','TRAIN','TEST','TRAIN','TEST',''});
ylabel('PSNR','FontSize',12,'FontWeight','bold');
legend({'L=4; random','L=4; split'},'Orientation','horizontal','location','north','FontSize',15);