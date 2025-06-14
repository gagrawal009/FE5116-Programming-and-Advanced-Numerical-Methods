clear;

x0=1;
theta=1;
kappa=2;
sigma=0.5;

xmin=x0-0.5;
xmax=x0+0.5;
nelem=50;

nDays=20;
nStepPerDay=24;
ivpAtStep=4;

model=oumk(x0,kappa,theta,sigma);
x=mkXGrid(xmin,xmax,nelem);
[ts,tk]=mkTimeGrid(nDays, nStepPerDay,ivpAtStep);
[v,t,p,s]=fokker(model,x,ts,tk);

plot(v,p(:,end),v,oupdf(v,t(end),model));


