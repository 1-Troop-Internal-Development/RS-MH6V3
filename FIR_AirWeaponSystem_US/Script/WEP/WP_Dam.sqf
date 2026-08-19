
_victim = _this select 0;

if (not alive _victim) ExitWith{};

_FX_smoketrail_source = "#particlesource" createVehicle (getpos _victim);
_FX_smoketrail_source setParticleClass "FIR_ContrailEffect";
_FX_smoketrail_source attachto [_victim,[0,0,0]];

[[_victim,"UnconsciousReviveHead_B"],"switchMove",true,true] call BIS_fnc_MP;			
while {alive _victim} do
{
	_dam = damage _victim;
	_victim setdamage _dam + 0.1;
	sleep 0.3;	
};

sleep 10;

deleteVehicle _FX_smoketrail_source;