% This is simple script drawing H and B vectors for simple saturation model
% together with simple draw of relative magnetic permeability mi tensor

% generate versors for H and B vectors
vH = versor(H);
vB1 = versor(B1);

% magnetic permeability components
miT1x = miT1(1);
miT1y = miT1(5);
miT1z = miT1(9);

% check saturation state
switch(StateM1)
  case 1
    state = 'Linear state';
  case 2
    state = 'Saturation state';
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

% adjust mi plot limits
milim = max(mix,miy,miz);

figure(1)

% - MAGNETIC FIELD STRENGTH H PLOT -
subplot(2,2,1)
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
subplot(2,2,2)
q2 = quiver3(0,0,0,B1(1),B1(2),B1(3),'b','LineWidth',4);
set(gca,'fontsize',20);
title('Simple {\it B_{sat}} model (T)');
xlabel('{\it B_x} (T)');
ylabel('{\it B_y} (T)');
zlabel('{\it B_z} (T)');
axis([-Bs Bs -Bs Bs -Bs Bs]);
grid on;
text(0.5.*Bs,-0.8.*Bs,0.8.*Bs,state,'fontsize',18,'backgroundcolor','white');

% - VERSORS OF H AND B ON ONE PLOT -
subplot(2,2,3)
q3 = quiver3(0,0,0,vH(1),vH(2),vH(3),'k','LineWidth',4);
set(gca,'fontsize',20);
title('Versors of {\it H} and {\it B}');
xlabel('{\it x} (-)');
ylabel('{\it y} (-)');
zlabel('{\it z} (-)');
axis([-1 1 -1 1 -1 1]);
hold on
q4 = quiver3(0,0,0,vB1(1),vB1(2),vB1(3),'b','LineWidth',4);
hold off;
grid on;
l = legend('{\it H} versor','{\it B} versor');
set(l,'fontsize',18);
text(0.5,-0.8,0.8,state,'fontsize',18,'backgroundcolor','white');

% - MAGNETIC PERMEABILITY TENSOR PLOT -
subplot(2,2,4)
[x1, y1, z1] = ellipsoid(0, 0, 0, miT1x, miT1y, miT1z, 40);
hMesh1 = surf(x1, y1, z1,'FaceColor','b', 'EdgeColor','k');
set(gca,'fontsize',20);
title('Simple saturation tensor of {\it \mu} (-)');
xlabel('{\it x} (-)');
ylabel('{\it y} (-)');
zlabel('{\it z} (-)');
axis([-milim milim -milim milim -milim milim]);
grid on;
text(0.6.*mix,-0.9.*miy,0.9.*miz,state,'fontsize',18,'backgroundcolor','white');

drawnow;