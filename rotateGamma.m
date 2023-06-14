function dirH = rotateGamma(gamma,mux,muy,muz)
  
  uX = [1;0;0];
  uY = [0;1;0];
  uZ = [0;0;1];
  
  mu = [mux,muy,muz];
  muMax = max(mu);
  
  % rotation matrix around X axis
  rotX = [1, 0, 0;...
          0, cos(gamma), -sin(gamma);...
          0, sin(gamma), cos(gamma)];  
  
  % rotation matrix around Y axis
  rotY = [cos(gamma), 0, sin(gamma);...
          0, 1, 0;...
          -sin(gamma), 0, cos(gamma)];
  
  % rotation matrix around X axis  
  rotZ = [cos(gamma), -sin(gamma), 0;...
          sin(gamma), cos(gamma) 0;...
          0, 0, 1];
   
          
  switch(muMax)
  
    case mux
      % rotate of X unit vector around Z axis
      dirH = rotZ*uX;
      
    case muy
      % rotate of Y unit vector around Z axis
      dirH = rotZ*uY;
      
    case muz
      % rotate of Z unit vector around Y axis
      dirH = rotY*uZ;
    
  end
  
end