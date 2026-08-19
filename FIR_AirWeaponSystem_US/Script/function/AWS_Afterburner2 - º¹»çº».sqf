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

_plane setVariable ["AWS_AB","on"];

[_plane] execVM _startscript;

_absound = _plane getVariable "AWS_ABSound";

if (_absound == "yes") then 
{
	[_plane] spawn FIR_fnc_AWS_Afterburner_Snd2;
};


sleep 0.5;

while {(alive _plane) and (_plane getVariable "AWS_AB" == "on") and (isengineon _plane) and (airplaneThrottle _plane == 1)} do 
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

_plane setVariable ["AWS_AB","off"];

sleep 0.5;

[_plane] execVM _endscript;





/* Afterburner system with realistic acceleration */

private ["_plane"];
_plane = _this select 0;

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "ABSystem";
private _AfterburnerEnabled = getNumber (_configPath >> "AfterburnerEnabled");
if (_AfterburnerEnabled == 0) exitWith {};

private _abswitch = getText (_configPath >> "ABSwitchName");
private _throttle = getText (_configPath >> "throttle_name");
private _startscript = getText (_configPath >> "ab_start_script");
private _endscript = getText (_configPath >> "ab_end_script");
private _maxspeed = getNumber (_configPath >> "maxspeed");
private _fuelconsumed = getNumber (_configPath >> "fuelconsume_ratio");

private _velIncrease = 0.1;  // Initial velocity increase (realistic for gradual acceleration)
private _simulationStep = 0.08;  // Simulation step for smooth operation

_plane setVariable ["AWS_AB","on"];
[_plane] execVM _startscript;

private _absound = _plane getVariable "AWS_ABSound";
if (_absound == "yes") then {
    [_plane, _abswitch] spawn FIR_fnc_AWS_Afterburner_Snd;
};

sleep 0.5;

while {
    (alive _plane) and 
    (_plane animationPhase _abswitch >= 0.1) and 
    (isEngineOn _plane) and 
    (_plane animationPhase _throttle == 1)
} do {
    if (isEngineOn _plane) then {
        private _velInitial = velocity _plane;
        private _dirPlane = direction _plane;
        private _currentSpeed = speed _plane;

        // Adjust velocity increase based on current speed
        if (_currentSpeed < 200) then {
            _velIncrease = 0.1;  // Lower acceleration at low speed
        } else {
            _velIncrease = 0.15;  // Faster acceleration above 200 km/h
        };

        if (_currentSpeed < _maxspeed) then {
            // Calculate new velocity vector based on direction and velocity increase
            private _newVelocity = [
                (_velInitial select 0) + (sin _dirPlane * _velIncrease), 
                (_velInitial select 1) + (cos _dirPlane * _velIncrease),
                (_velInitial select 2)
            ];

            // Set the direction and up vectors for 3D maneuvering
            _plane setVectorDirAndUp [
                sin _dirPlane, 
                cos _dirPlane, 
                0
            ];

            // Set the new velocity considering the direction and current velocity
            _plane setVelocity _newVelocity;

            // Gradually increase the velocity increase and simulation step
            _simulationStep = min [_simulationStep + 0.05, 0.1];  // Increase step slightly over time

            sleep _simulationStep;
        };
    };

    // Check if engine is off or plane is dead, break the loop early
    if (!(isEngineOn _plane) or !alive _plane) then {
        exitWith {};
    };
};

sleep 0.01;

_plane setVariable ["AWS_AB","off"];

sleep 0.5;

[_plane] execVM _endscript;

