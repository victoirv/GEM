function dB_ccmc_plot()

load dB_ccmc.mat

for i = 1:length(D1)
    D1{i}
    D2{i+1}
    t = regexprep(D1{i},'.*dB_([0-9])','$1');
    t = regexprep(t,'//','/');
    m = upper(regexprep(t,'.*dB_(.*).txt','$1'));
    %x = [X2{i+1};X1{i}];
    %t = [T2{i+1};T1{i}];
    
    figure(1);clf;
    %plot(t,x(:,1)-300,'r');hold on;
    %plot(t,x(:,2),'g');hold on;
    %plot(t,x(:,3)+300,'b');hold on;
    
    plot(T1{i},X1{i}(:,1)-300,'r');hold on;
    plot(T1{i},X1{i}(:,2),'g');hold on;
    plot(T1{i},X1{i}(:,3)+300,'b');hold on;

    plot(T2{i+1},X2{i+1}(:,1)-300,'r');hold on;
    plot(T2{i+1},X2{i+1}(:,2),'g');hold on;
    plot(T2{i+1},X2{i+1}(:,3)+300,'b');hold on;

    datetick('x','YYYY-mm');
    axis tight;
    ylabel('B [nT]');
    title(sprintf('SWMF BATSRUS real-time model \\Delta B at %s',m));
    legend('B_{vert}-300','B_{east}','B_{north}+300');
    grid on;
    set(gca,'YLim',[-600,800])
    com = sprintf('print -dpng -r100 ./figures/%s.png',m);eval(com);
    com = sprintf('print -dpng -r25 ./figures/thumbs/%s.png',m);eval(com);
end