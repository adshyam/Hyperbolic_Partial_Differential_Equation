%*****************************************************************
% MATLAB code for example 3.2 on one-dimensional wave equation solved 
% using an explicit finite difference scheme
%*****************************************************************
clear all; format compact; tic

%Explicit Method
delx = 0.1;			% resolution size
r = 1;				% 'aspect ratio'
u = 1;				% Constant of given wave equation
delt = r^2*delx/u; 	% time step size
Tsteps = round(1/delt); % Number of time steps

% X1 is the potential grid of the simulation, due to symmetry only half 
% of the field is calculated.
X1 = zeros(Tsteps,1/(2*delx)+2);	% Initilize X1

%Initial conditions and reflection line defined 
x = 0:delx:.5+delx;
X1(1,:) = sin(pi*x);
X1(2,2:end-1) = .5*(X1(1,1:end-2)+X1(1,3:end)); 
X1(2,end) = X1(2,end-2); %reflection line

for row = 3:size(X1,1)
	for col = 2:size(X1,2)-1
		X1(row,col) = X1(row-1,col-1)+X1(row-1,col+1)-X1(row-2,col); % eqn. (3.26)
	end
	X1(row,end) = X1(row,end-2);	%reflected line
end

%Use symmetry condition to create entire field
X2 = [X1,fliplr(X1(:,1:end-3))];

figure(1),imagesc(0:delx:1,(0:delt:Tsteps*delt),X2),colorbar 
	ylabel('\leftarrow time (sec)')
	xlabel('x')
	title('Hyperbolic PDE')
	
if (delx==.1)
	dispmat = (X1(1:8,1:7));
	fprintf('\nCompare to Table 3.5, Solution of the Wave Equation in Exam¬ple 3.2\n')
	disp(num2str(dispmat))
end
