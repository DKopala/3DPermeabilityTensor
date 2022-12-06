function [miTout,State]=LinSatRotMi(H1,mi,Bs)
  
mi0 = 4.*pi.*1e-7;  % magnetic constant

absH1 = norm(H1);   % length of field strength H vector

B1 = mi0.*mi*H1;    % simple linear calculation of flux density - vector B1
absB1 = norm(B1);   % length of vector B1

% BELOW SATURATION CASE

if absB1<=Bs        % B value below saturation 
  miTout = mi;      % return the calculated value
  State = 1;        % linear state
  return;
end

% SATURATION CASE

B2 = B1.*Bs./absB1;         % reduce the length flux density vector of B2 to Bs
absB2 = norm(B2);           % in saturation equals Bs

H2 = H1.*(Bs./absB1);       % reduce the length of magnetic field strength H 
absH2 = norm(H2);           % length of H2 requred to reach saturation

B3 = mi0.*mi*H2;            % flux density B for linear saturation point
absB3 = norm(B3);           % in saturation equals Bs

Erot = 0.5*Bs.*(absH1-absH2);   % energy necessary for B vector rotation
                                % to parallelize B with H vector
                                % explanation in the paper doi: 10.1007/978-3-030-40971-5_28

Ean = Bs.^2./(2.*mi0).*(1./mi(5)-1./mi(1));   % anisotropic energy necessary to turn the
                                              % flux density vector B from easy to
                                              % hard magnetization direction

% unit vectors
vx = [1;0;0];       % X axis versor
vB1 = versor(B1);   % B1 versor
vH1 = versor(H1);   % H1 versor

% check whether all of the unit vectors
% share common plane - they do if sameplane = 0
sameplane = dot(cross(vx,vB1),vH1);

  % calculate angle between B and H vectors in given plane
  eps = acos(dot(H1,B1)./(norm(H1).*norm(B1)));
  % common plane unit vector
  vsurf = versor(cross(vH1,vB1));
  
  % theta angle
  theta = asin((absB1.*absH1.*sin(eps))./Ean)./2;
  
  % fraction of anisotropic energy necessery for rotation
  
  % in reality, the energy is different - it depends on the specific angle
  % theta, which defines the angle between easy magnetization axis c
  % and H or Ms, when H || Ms
  EanE=(eps./(pi./2)).*Ean;

  if Erot>=EanE         % if we have too much energy for rotation, vector B is rotated only
                        % to the direction of vector H
     Erot = EanE;
     State = 3;        % fully rotated state
   else
     State = 2;        % still rotating
  end
  
  if EanE==0                    % no more energy necessary for rotation
     epsR = 0;                  % no rotation
   else
     epsR = -eps.*Erot./EanE;   % rotation angle
  end
  
  % calculate rotation matrix around surface versor
  Rot = rotation(vsurf,epsR);
  
  miT_ = Rot*mi*Rot';           % tensor rotation
  BT = mi0.*miT_*H1;            % simple linear calculation of flux density - vector BT
  absBT = norm(BT);             % shorten BT vector to Bs
  miTout = miT_.*(Bs./absBT);   % calculate the final relative magnetic permeability tensor

end
