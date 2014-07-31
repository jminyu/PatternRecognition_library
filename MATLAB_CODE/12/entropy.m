function result=entropy(classVec)
	totLen=length(classVec);
	ithEle=1;
	subLen=length(find(classVec==ithEle));
	while(subLen~=0)
		logVal(ithEle)=-(subLen/totLen)*log2(subLen/totLen);
		ithEle=ithEle+1;
		subLen=length(find(classVec==ithEle));
	end
result=sum(logVal);
