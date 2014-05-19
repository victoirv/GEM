%function dB_compare()
clear;
load dB_usgs.mat

pex = pe_nonflag(BdXi,Bm(:,2))
ccx = corrcoef_nonflag(BdXi,Bm(:,2))

pey = pe_nonflag(BdYi,Bm(:,3))
ccy = corrcoef_nonflag(BdYi,Bm(:,3))

figure(1);clf;
subplot(2,1,1)
 plot(Tm,BdXi,'b');hold on;grid on;
 plot(Tm,Bm(:,2),'g');
 title(sprintf('PE = %.2f, CC = %.2f',pex,ccx(2)));
 legend('Data CMO B_X','Model CMO B_X','Location','SouthWest');
 ylabel('nT');
 xlabel('Month/Year');
 datetick('x','mm/yy')
 
subplot(2,1,2)
 plot(Tm,BdYi,'b');hold on;grid on;
 plot(Tm,Bm(:,3),'g');
 title(sprintf('PE = %.2f, CC = %.2f',pey,ccy(2)));
 legend('Data CMO B_Y','Model CMO B_Y','Location','NorthWest');
 axis tight;
 datetick('x','mm/yy');
 ylabel('nT');
 xlabel('Month/Year')
print -depsc ./figures/CMO_timeseries.eps
 
figure(2);clf;
subplot(2,1,1)
 plot(Tm,BdXi,'b');hold on;grid on;
 plot(Tm,Bm(:,2),'g');
 %title(sprintf('PE = %.2f, CC = %.2f',pex,ccx(2)));
 legend('Data CMO B_X','Model CMO B_X','Location','SouthWest');
 %axis tight;
 ylabel('nT');
 xlabel('Month/Year');
 datetick('x','mm/yy')
 set(gca,'XLim',[Tm(1),Tm(10000)])
 
subplot(2,1,2)
 plot(Tm,BdYi,'b');hold on;grid on;
 plot(Tm,Bm(:,3),'g');
 %title(sprintf('PE = %.2f, CC = %.2f',pey,ccy(2)));
 legend('Data CMO B_Y','Model CMO B_Y','Location','NorthWest');
 %axis tight;
 datetick('x','mm/yy');
 set(gca,'XLim',[Tm(1),Tm(10000)])
 ylabel('nT');
 xlabel('Month/Year')
print -depsc ./figures/CMO_timeseries_zoom.eps
break
figure(3);clf;
subplot(2,1,1);grid on;
 plot(BdXi,Bm(:,2),'k.');hold on;grid on;
 title(sprintf('PE = %.2f, CC = %.2f',pex,ccx(2)));
 xlabel('Data CMO B_X [nT]');%set(get(gca,'XLabel'),'Color',[0 0 1]);
 ylabel('Model CMO B_X [nT]');%set(get(gca,'YLabel'),'Color',[0 1 0]);
 set(gca,'YLim',[-1000,500])
 set(gca,'XLim',[-1000,500])
 plot([-1000,500],[-1000,500],'b');
 axis square;
 
subplot(2,1,2);grid on;
 plot(BdYi,Bm(:,3),'k.');hold on;grid on;
 title(sprintf('PE = %.2f, CC = %.2f',pey,ccy(2)));
 xlabel('Data CMO B_Y [nT]');%set(get(gca,'XLabel'),'Color',[0 0 1]);
 ylabel('Model CMO B_Y [nT]');%set(get(gca,'YLabel'),'Color',[0 1 0]);
 set(gca,'YLim',[-500,500])
 set(gca,'XLim',[-500,500])
 plot([-500,500],[-500,500],'k');
 axis square;
print -depsc ./figures/CMO_scatter.eps