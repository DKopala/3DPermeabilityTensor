switch(StateM2)
  case 1
    state = 'Linear state';
  case 2
    state = 'Rotation';
  case 3
    state = 'Full saturation';
end

x=-2:2;
y=x;

ux = [1;0;0];

p0=[0 0 0];

% generate versors for H and B vectors
uH = versor(H).*Hscale;
uB2 = versor(B2).*Bscale;

% surface vectors
vsH = versor(sH);
vsB = versor(sB2);

% surface unit vector
uS = cross(vsB,vsH);

% calculate angle scale factor
f = 3./fscale;

quiver3(0,0,0,uB2(1),uB2(2),uB2(3),'b','LineWidth',5);
hold on
quiver3(0,0,0,uH(1),uH(2),uH(3),'r','LineWidth',5);
drawSurf(uS,p0,x,y);
angle3Dmod(uH,uB2,p0,uS,f);

annotation ("textbox", [0.65 0.7 0.6 0.6], "string", ...
[state;strcat('{\it H} = ', num2str(absH(i)),' (A/m)');...
strcat('|{\it B} |= ', num2str(norm(B2),2),' (T)');...
strcat('{\it\phi_{rot}} = ', num2str(thetadeg,2),'°')],...
'fontsize',20,'backgroundcolor','white','margin',10,'edgecolor','white');

hold off

axis([-2 2 -2 2 -2 2])
xlabel('\itX')
ylabel('\itY')
zlabel('\itZ')
title('{\itB} and {\itH} vectors in 3D - saturation process')

l = legend('\itB','\itH');
set(gca,'fontsize',20);
set(l,'position',[0.8 0.3 3 3],'fontsize',25);
set(gca,'xticklabel',[], 'yticklabel',[], 'zticklabel',[])

drawnow;