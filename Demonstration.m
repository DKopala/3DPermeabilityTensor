% MIT License
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

% DESCRIPTION:
% Script generating .msz file connected with the paper:
% D. Kopala, A. Ostaszewska-Lizewska, P. Raback, R. Szewczyk
% "The model of 3D magnetic permeability tensor considering rotation
% and saturation states in materials with axial anisotropy"
%

% Demonstration of models of linear relative magnetic permeability tensor

clear all
close all
clc

graphics_toolkit ("qt")

% MATERIAL PARAMETERS
% Bs [T] saturation induction
Bs = 1;
% mi [-] magnetic permeability tensor
mix = 5000;       % X direction
miy = 1000;       % Y direction
miz = 1000;       % Z direction
mi = [mix,0,0;... % magnetic permeability
      0,miy,0;... % tensor
      0,0,miz];

% H [A/m] - MAGNETIC FIELD STRENGTH

% uncomment when magnetization angle g not used!
% dirH = [1;1;1];   % H vector direction

Hmin = -1000;      % minimum H value
Hmax = 1000;       % maximum H value
dH = 1;            % increase of H

% Tab of H abs values (not including direction yet)
absH = Hmin:dH:Hmax;

% H vectors lenght for animation
Hscale = 0;
Hlmax = 0;
maxH = max(abs(absH));

% check highest number
switch(maxH)
  case abs(Hmin)
    Hlmax = abs(Hmin);
  case abs(Hmax)
    Hlmax = abs(Hmax);
end

% adjust vectors scale
Hmat = absH./Hlmax;

% flags for surface vectors
% tells whether surface vector has been calculated
sf = 0;
sH = [0 0 0];
sB2 = [0 0 0];

% rotation of magnetization direction
% gamma angle in degrees
% set more than 1 to obtain multiple plots
% 0 deg - magnetization dir paralell to easy magnetization axis
% 90 deg - magnetization dir transverse to easy magnetization axis
g = 0:15:90;

% values for BH plots
tabH = absH;
tabB = zeros(numel(g),numel(absH));

% change gamma magnetization direction angle
for j = 1:numel(g)

% create magnetization direction vector
% based on given gamma angle
gamma = deg2rad(g(j));
dirH = rotateGamma(gamma,mix,miy,miz);

  % change H amplitude
  for i = 1:numel(absH)

    H = absH(i).*dirH; % calculate H vector

    % magnetic flux density B saturation with no rotation
    B1 = LinSatB(H,mi,Bs);
    [miT1,StateM1] = LinSatMi(H,mi,Bs);

    % magnetic flux density B saturation with rotation
    B2 = LinSatRotB(H,mi,Bs);
    [miT2,StateM2] = LinSatRotMi(H,mi,Bs);

    Hscale = abs(Hmat(i)).*2;     % calculate H vector for animation
    Bscale = (norm(B2).*1)./Bs;   % calculate B vector for animation
    fscale = abs(Hmat(i)).*3;     % calculate angle scale for animation

    % angle between H and B2 vectors
    theta = atan2(norm(cross(B2,H)),dot(B2,H));
    thetadeg = rad2deg(theta);
    if(StateM2 == 3) thetadeg = 0;
    end

    % take B and H vectors for surface vector calculation
    if (norm(H)!=0 && sf==0)
     sH = H;
     sB2 = B2;
     sf = 1;
    end

    % calculate B projection on H dir for BH plot
    %tabB(i) = Bplot(B2,H,absH(i));

    % case with no rotation, when dirH || easy magnetization axis
    if(g(j) == 0)
      tabB(j,i) = Bplot(B1,H,absH(i));
    else
      % calculate B projection on H dir for BH plot
      tabB(j,i) = Bplot(B2,H,absH(i));
    end

  % ------- WARNING! -------
  % Run ONLY ONE drawing script AT ONCE!
  % Otherwise figures generation process will proceed
  % very slowly or in the worst case crash!
  % ------------------------

  % - Draws plots for linear saturation case
  %  DrawSimpleScript;

  % - Draws plots for rotation saturation case
  %  DrawRotationScript;

  % - Comparison of H and B vectors
  %   linear vs rotation case
  %  DrawAllScript1;

  % - Comparison of H,B versors and permeability values
  %   linear vs rotation case
  %  DrawAllScript2;

  % - H,B vectors animation for rotation case
  %  Animation;

  % - Comparison of permeability values
  %   linear vs rotation case cases
  %  DrawMiScript;

  end

end

% Save plots to .dat file for gamma angles
  DataSave;

% - Draw B(H) plot
  BHplotDraw;
