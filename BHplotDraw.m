plot(tabH,tabB,'linewidth',4);
title('{\itB(H)} plot')
xlabel('{\it H} (A/m)','fontweight','bold')
ylabel('{\it B} (T)','fontweight','bold')
% set y axis limits
yleft = -1.3.*Bs;
yright = 1.3.*Bs;
ylim([yleft yright])
grid
set(gca,'fontsize',17)
