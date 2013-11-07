function IG = getsymintgraph(M) %TODO:
%GETSYMINTGRAPH Get the symmetric interference graph matrix
%
%   IG = GETSYMINTGRAPH(M) returns the symmetric interference graph matrix
%   from the maximal schedule matrix M. 

% IG = [1 1 0 0 0; % five line
%       1 1 1 0 0;
%       0 1 1 1 0;
%       0 0 1 1 1;
%       0 0 0 1 1];
% IG = [1 1 0 0 0 1; % six cycle
%       1 1 1 0 0 0;
%       0 1 1 1 0 0;
%       0 0 1 1 1 0;
%       0 0 0 1 1 1;
%       1 0 0 0 1 1];
IG = [1 1 0 0 0 1; % six grid
      1 1 1 0 1 0;
      0 1 1 1 0 0;
      0 0 1 1 1 0;
      0 1 0 1 1 1;
      1 0 0 0 1 1];
