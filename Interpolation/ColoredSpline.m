function ColoredSpline

% Cubic Spline for 12 nodes and 1st Condition:S1=0 and S12=0.
x=[0.1 1.1  1.6  2.4  2.5  4.1  5.2  6.1  6.6  7.1  8.2  9.1];
y=[1.9 7.9 24.9 24.9 34.9 42.7 29.7 49.8 36.1 23.7 13.0 20.5];
N=length(x);                %Number of given Nodes
Ny=length(y);
if(N~=Ny)
   errordlg('Size of x and y must be the same');
   return;
end
if(N<4)
	errordlg('Number of Nodes must not be less than 4');
	return;
end

% different Colors for 11 spline curves
colors=zeros(11,3);
colors(1,:)=[1 0 0];
colors(2,:)=[0,1,0];
colors(3,:)=[0,0,1];
colors(4,:)=[0.8,0.0,0];
colors(5,:)=[0,0.8,0];
colors(6,:)=[0,0,0.8];
colors(7,:)=[0.9,0.9,0];
colors(8,:)=[0,0.9,0.9];
colors(9,:)=[0.9,0,0.9];
colors(10,:)=0.7;
colors(11,:)=[0,0,0];

% Data Definitions and initionalization
sh=diff(x);
hMat=zeros(N-2);            %Coefficient Matrix for Linear Combination of....
							%second order derivatives (S1, S1, S2 ,..... S12)
							%Second derivatives of first and the last nodes(S1 and S12)
							%are assumed zero. So We have to calculate (N-2), 10 nodes
							%(S2,S3,........S11) only
S=zeros(N,1);               %S contains Second order Derivative values at 12 Nodes
M=50;                       %Points on a single Spline

% Calculation of 10x10 Coefficient Matrix and the Column Matrix consisting of divided differences
h=diff(x);
hMat(1,1)=2*(h(1)+h(2));hMat(1,2)=h(2);
for n=2:N-3
	hMat(n,n-1)=h(n);hMat(n,n)=2*(h(n)+h(n+1));hMat(n,n+1)=h(n+1);
end
hMat(n+1,n-1)=h(n+1);hMat(n+1,n+1)=2*(h(n+1)+h(n+2));
	%Calculates divided Differences in a Column Matrix 'S'
divdif=diff(y)./diff(x);
dMat=6*(diff(divdif))';
S(2:N-1)=hMat\dMat;

%Calculation of 11 (N-1) Cubic curves' Coefficients
a=zeros(1,N-1);
b=zeros(1,N-1);
c=zeros(1,N-1);
d=zeros(1,N-1);
for n=1:N-1
	a(n)=(S(n+1)-S(n))/(6*h(n));
	b(n)=S(n)/2;
	c(n)=(y(n+1)-y(n))/h(n)-(2*h(n)*S(n)+h(n)*S(n+1))/6;
	d(n)=y(n);
end

% Calculation of points for each of 11(N-1) cubic curves.
%M is the number of points in one curve
X=zeros(N-1,M);
Y=zeros(N-1,M);
for n=1:N-1
	X(n,:)=linspace(x(n),x(n+1),M);
	Y(n,:)=a(n)*(X(n,:)-x(n)).^3+b(n)*(X(n,:)-x(n)).^2+c(n)*(X(n,:)-x(n))+d(n);
end

% Graph of cubic spline (N-1 cubic curves)
hold on;
k=1;
for n=1:N-1
	if k==12     %Colors repeat after every multiple of 11 colors
		k=1;
	end;
	plot(X(n,:),Y(n,:),'LineWidth',3,'Color',colors(k,:));
	k=k+1;
end;
plot(x,y,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',8);
text(4,65,'Cubic Spline','FontName','Times New Roman','FontSize',18,'Color',[1 1 1]);
set(gca,'Color',[.3,0.5,.7],'FontSize',12); % graph's background color
box on;
hold off;

