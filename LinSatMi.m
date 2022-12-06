function [Miout,State]=LinSatMi(H,mi,Bs)
  
mi0 = 4.*pi.*1e-7;      % magnetic constant

absH = norm(H);         % length of field strength H vector

B = mi0.*mi*H;          % simple linear calculation of flux density - vector B
absB = norm(B);         % length of vector B

if absB<=Bs
  Miout = mi;
  State = 1;            % This is linear state
else
  Miout = mi.*Bs./absB;
  State = 2;            % This is saturated state - Simply reduce the dimmensions of 
                        % magnetic relative permeability tensor in saturation
end

end