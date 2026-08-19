/*Afterburner system*/


private ["_plane"];

_plane = _this select 0;

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "ABSystem";
private _AfterburnerEnabled = getNumber (_configPath >> "AfterburnerEnabled"); if (_AfterburnerEnabled == 0) exitWith {};
private _abswitch = getText (_configPath >> "ABSwitchName");
private _throttle = getText (_configPath >> "throttle_name");
private _startscript = getText (_configPath >> "ab_start_script");
private _endscript = getText (_configPath >> "ab_end_script");
private _maxspeed = getNumber (_configPath >> "maxspeed");
private _fuelconsumed = getNumber (_configPath >> "fuelconsume_ratio");

_velIncrease = 0.075;
_simulationStep = 0.07;

_plane animate [_abswitch,1];

[_plane] execVM _startscript;

_absound = _plane getVariable "AWS_ABSound";

if (_absound == "yes") then 
{
	[_plane,_abswitch] spawn FIR_fnc_AWS_Afterburner_Snd;
};


sleep 0.5;

while {(alive _plane) and (_plane animationphase _abswitch >= 0.1) and (isengineon _plane) and (_plane animationphase _throttle == 1)} do 
{
	if (isengineon _plane) then
	{
		_velInitial = velocity _plane;
		_dirPlane = direction _plane;
		if ((speed _plane) < _maxspeed) then
		{
			
			_plane setVelocity [
					(_velInitial select 0) + (sin _dirPlane * _velIncrease), 
					(_velInitial select 1) + (cos _dirPlane * _velIncrease), 
					(_velInitial select 2)
				   ];

			sleep _simulationStep;
			if (_velIncrease >= 3) then {_velIncrease = 3;} else {_velIncrease = _velIncrease+ 0.15;};
			if (_simulationStep >=0.5) then {_simulationStep = 0.5;} else {_simulationStep = _simulationStep + 0.1;};			
		};
	};
};

sleep 0.01;

_plane animate [_abswitch,0];

sleep 0.5;

[_plane] execVM _endscript;



