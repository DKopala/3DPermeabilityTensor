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

figure(5)

% - MAGNETIC PERMEABILITY TENSOR SIMPLE PLOT -
subplot(1,2,1)
[x1, y1, z1] = ellipsoid(0, 0, 0, miT1x, miT1y, miT1z, 40);
hMesh1 = surf(x1, y1, z1,'FaceColor','b', 'EdgeColor','k');
set(gca,'fontsize',20);
title('Saturation tensor of {\it \mu} (-) - simple case');
xlabel('{\it x} (-)');
ylabel('{\it y} (-)');
zlabel('{\it z} (-)');
axis([-milim milim -milim milim -milim milim]);
grid on;
text(0.6.*mix,-0.9.*miy,0.9.*miz,state,'fontsize',18,'backgroundcolor','white');

% - MAGNETIC PERMEABILITY TENSOR ROTATION PLOT -
subplot(1,2,2)
[x2, y2, z2] = ellipsoid(0, 0, 0, miT2x, miT2y, miT2z, 40);
hMesh2 = surf(x2, y2, z2,'FaceColor','r', 'EdgeColor','k');
set(gca,'fontsize',20);
title('Saturation tensor of {\it \mu} (-) - rotation case');
xlabel('{\it x} (-)');
ylabel('{\it y} (-)');
zlabel('{\it z} (-)');
axis([-milim milim -milim milim -milim milim]);
grid on;
text(0.6.*mix,-0.9.*miy,0.9.*miz,state,'fontsize',18,'backgroundcolor','white');

drawnow;