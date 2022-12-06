function R = rotation(vers, alpha)

  % vers - unit vector, axis of Ration
  % alpha - alpha of Ration

  % initialize an empty array
  R = zeros(3,3);
  
  % generate rotation matrix around unit vector
  R(1,1) = cos(alpha)+vers(1).^2*(1-cos(alpha));
  R(1,2) = vers(1).*vers(2)*(1-cos(alpha))-vers(3).*sin(alpha);
  R(1,3) = vers(1).*vers(3)*(1-cos(alpha))+vers(2).*sin(alpha);
  
  R(2,1) = vers(2).*vers(1)*(1-cos(alpha))+vers(3).*sin(alpha);
  R(2,2) = cos(alpha)+vers(2).^2*(1-cos(alpha));
  R(2,3) = vers(2).*vers(3)*(1-cos(alpha))-vers(1).*sin(alpha);
  
  R(3,1) = vers(3).*vers(1)*(1-cos(alpha))-vers(2).*sin(alpha);
  R(3,2) = vers(3).*vers(2)*(1-cos(alpha))+vers(1).*sin(alpha);
  R(3,3) = cos(alpha)+vers(3).^2*(1-cos(alpha));

end