function [ts,tk]=mkTimeGrid(nDays, nStepPerDay,ivpAtStep)

	% example:
	% nStepPerDay=2
	% ivpAfterStep=1;
	% nDays=2;

	day=1/365;
	dt = day/nStepPerDay;

	ts=[0:nStepPerDay*nDays]' * dt; % ts=[0,1,2,3,4]*dt

	ivpIndex=ivpAtStep+1;   % ivpIndex=2

	ts=ts(ivpIndex:end);       % ts=[1,2,3,4]*dt

	fullDayInd=1+[1:nDays]*nStepPerDay; % [3,5]
	tk=fullDayInd(find(fullDayInd>ivpIndex))-ivpAtStep; %[2,4]


	if(tk(1)>1)
	  tk=[1,tk]; %[1,2,4]
	end
