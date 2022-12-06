function Bdata = Bplot(B,H,absH)

  % B vector projection on H vector
  Bp = dot(B,H)*(H./(norm(H).^2));
  % for H = 0, B = 0
  if(isnan(Bp)) Bp = 0;
  end

  if(absH<0)
    Bdata = -norm(Bp);
  else
    Bdata = norm(Bp);
  end

end