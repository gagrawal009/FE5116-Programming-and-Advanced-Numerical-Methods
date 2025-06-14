clear;

x0=1;
mu=0.8;
sigma=0.5;

xmin=0.5;
xmax=2.0;
nelem=80;

nDays=10;
nStepPerDay=24;
ivpAtStep=4;

model=gbmmk(x0,mu,sigma);
x=mkXGrid(xmin,xmax,nelem);
[ts,tk]=mkTimeGrid(nDays, nStepPerDay,ivpAtStep);
[v,t,p,s]=fokker(model,x,ts,tk);

plot(v,p(:,end),v,gbmpdf(v,t(end),model));