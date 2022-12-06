function Bout=LinSatB(H,mi,Bs)

mi0 = 4.*pi.*1e-7;      % magnetic constant

B = mi0.*mi*H;          % simple linear calculation of flux density - vector B
absB = norm(B);         % length of vector B

if absB<=Bs             % if length of this vector is below saturation - just return it, do nothing 
  Bout = B;
else
  Bout = B.*Bs./absB;   % Simply reduce the length of B vector in saturation
end

end