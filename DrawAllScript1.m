% This is simple script drawing H and B vectors for simple saturation model
% together with simple draw of relative magnetic permeability mi tensor

% check saturation state
switch(StateM2)
  case 1
    state = 'Linear state';
  case 2
    state = 'Rotation';
  case 3
    state = 'Full saturation';
end

% adjust H plot limits
if Hmin>0&&Hmax>0
  Hmn = 0;
  Hmx = Hmax;
elseif Hmin<0&&Hmax<0
  Hmn = Hmin;
  Hmx = 0;
else
  Hmn = Hmin;
  Hmx = Hmax;
end

figure(3)

% - MAGNETIC FIELD STRENGTH H PLOT -
subplot(1,2,1)
q1 = quiver3(0,0,0,H(1),H(2),H(3),'k','LineWidth',4);
set(gca,'fontsize',20);
set(q1,'maxheadsize',0.1);
title('{\it H} (A/m)')
xlabel('{\it H_x} (A/m)');
ylabel('{\it H_y} (A/m)');
zlabel('{\it H_z} (A/m)');
axis([Hmn Hmx Hmn Hmx Hmn Hmx]);
grid on;
text(Hmx-0.19.*abs(Hmx-Hmn),Hmn+0.19.*abs(Hmx-Hmn),...
  Hmx-0.19.*abs(Hmx-Hmn),state,'fontsize',18,'backgroundcolor','white');

% - MAGNETIC FLUX DENSITY B PLOT -
subplot(1,2,2)
q2 = quiver3(0,0,0,B1(1),B1(2),B1(3),'b','LineWidth',4);
set(gca,'fontsize',20);
title('{\it B_{sat}} simple and rotation model (T)');
xlabel('{\it B_x} (T)');
ylabel('{\it B_y} (T)');
zlabel('{\it B_z} (T)');
axis([-Bs Bs -Bs Bs -Bs Bs]);
grid on;
hold on;
q3 = quiver3(0,0,0,B2(1),B2(2),B2(3),':r','LineWidth',4);
hold off;
l = legend('{\it B} simple','{\it B} rotation');
set(l,'fontsize',18);
text(0.5.*Bs,-0.8.*Bs,0.8.*Bs,state,'fontsize',18,'backgroundcolor','white');

drawnow;