clear;

x0=0.1;
theta=1;
kappa=2;
sigma=3;

xmin=0.0;
xmax=x0+2;
nelem=100;

nDays=20;
nStepPerDay=24;
ivpAtStep=4;

model=cirmk(x0,kappa,theta,sigma);
x=mkXGrid(xmin,xmax,nelem);
[ts,tk]=mkTimeGrid(nDays, nStepPerDay,ivpAtStep);
[v,t,p,s]=fokker(model,x,ts,tk);

plot(v,p(:,end),v,cirpdf(v,t(end),model));


