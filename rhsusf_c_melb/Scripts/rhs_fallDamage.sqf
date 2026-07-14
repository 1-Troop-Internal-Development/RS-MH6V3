/*
	reduce helicopter falling damage
	a: reyhard
*/

params["_v","_s","_d","_src","_p","_hi"];

//EH handledamage returns "" for fall damage
if(_p isEqualTo "" )then{
	// total damage modifier is 50 & hitpoint coef is at 10
	if(_s isEqualTo "")then{
		_d = (getDammage _v) +  _d / 150;
	}else{
		_d = (_v getHitIndex _hi) +  _d / 2;
	};
	//systemChat "fall dammage detected";
};

//return damage
_d