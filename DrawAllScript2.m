% This is simple script drawing H and B vectors for simple saturation model
% together with simple draw of relative magnetic permeability mi tensor

% generate versors for H and B vectors
vH = versor(H);
vB1 = versor(B1);
vB2 = versor(B2);

% magnetic permeability components
miT1x = miT1(1);      % simple model
miT1y = miT1(5);
miT1z = miT1(9);

miT2x = miT2(1);      % rotation model
miT2y = miT2(5);
miT2z = miT2(9);

% check saturation state
switch(StateM2)
  case 1
    state = 'Linear state';
  case 2
    state = 'Rotation';
  case 3
    state = 'Full saturation';
end

% adjust mi plot limits
milim = max(mix,miy,miz);

figure(4)

% - VERSORS OF H AND B ON ONE PLOT -
subplot(1,2,1)
q1 = quiver3(0,0,0,vH(1),vH(2),vH(3),'k','LineWidth',4);
set(gca,'fontsize',20);
title('Versors of {\it H} and {\it B} for simple and rotation model');
xlabel('{\it x} (-)');
ylabel('{\it y} (-)');
zlabel('{\it z} (-)');
axis([-1 1 -1 1 -1 1]);
hold on;
q2 = quiver3(0,0,0,vB1(1),vB1(2),vB1(3),'b','LineWidth',4);
q3 = quiver3(0,0,0,vB2(1),vB2(2),vB2(3),':r','LineWidth',4);
hold off;
grid on;
l1 = legend('{\it H} vector','{\it B} simple','{\it B} rotation');
set(l1,'fontsize',18);
text(0.5,-0.8,0.8,state,'fontsize',18,'backgroundcolor','white');

% - MAGNETIC PERMEABILITY TENSOR PLOT -
subplot(1,2,2)
[x1, y1, z1] = ellipsoid(0, 0, 0, miT1x, miT1y, miT1z, 40);
hMesh1 = surf(x1, y1, z1,'FaceColor','b','EdgeColor','k');
set(gca,'fontsize',20);
title('Saturation tensor of {\it \mu} (-)');
xlabel('{\it x} (-)');
ylabel('{\it y} (-)');
zlabel('{\it z} (-)');
axis([-milim milim -milim milim -milim milim]);
grid on;
hold on;
[x2, y2, z2] = ellipsoid(0, 0, 0, miT2x, miT2y, miT2z, 40);
hMesh2 = surf(x2, y2, z2,'FaceColor','r', 'EdgeColor','k');
hold off;
l2 = legend('{\it \mu} simple','{\it \mu} rotation');
set(l2,'fontsize',18);
text(0.6.*mix,-0.9.*miy,0.9.*miz,state,'fontsize',18,'backgroundcolor','white');
drawnow;