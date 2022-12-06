function angle3Dmod(v1,v2,p0,uS,f)

% number of point for vectors  
ni = 10;

% draw arcs for angles

x1 = linspace(v1(1),v2(1),ni);
y1 = linspace(v1(2),v2(2),ni);
z1 = linspace(v1(3),v2(3),ni);

L1 = sqrt(x1.^2+y1.^2+z1.^2).*f;

plot3(x1./L1,y1./L1,z1./L1,'k','linewidth',3)     % arc

% set text localization
xtxt = abs(v1(1)-v2(1))./3;
ytxt = abs(v1(2)-v2(2)).*1.5;
ztxt = p0(3)-((uS(1).*(xtxt-p0(1))+uS(2).*(ytxt-p0(2)))./uS(3));

%text(xtxt,ytxt,ztxt,'\it{\theta}','FontSize',15);

end