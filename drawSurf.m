% Function that allows drawing surfaces in 3D

function drawSurf(uS,p0,xlm,ylm)

[X,Y] = meshgrid(xlm,ylm);
Z = p0(3)-((uS(1).*(X-p0(1))+uS(2).*(Y-p0(2)))./uS(3));

mesh(X,Y,Z,'facecolor','b','edgecolor', 'none','FaceAlpha',0.1);

end