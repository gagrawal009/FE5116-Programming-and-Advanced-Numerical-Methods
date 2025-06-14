clear;

x0=0;
mu=0.4;
sigma=0.5;

xmin=-0.5;
xmax=0.5;
nelem=50;

nDays=20;
nStepPerDay=24;
ivpAtStep=4;

model=abmmk(x0,mu,sigma);
x=mkXGrid(xmin,xmax,nelem);
[ts,tk]=mkTimeGrid(nDays, nStepPerDay,ivpAtStep);
[v,t,p,s]=fokker(model,x,ts,tk);

plot(v,p(:,end),v,abmpdf(v,t(end),model));


