/*
AWS Ejection System by Firewill
modified Arma3 Ejection system
zero-zero ejection and two seat ejection supported
*/

private ["_plane","_pilot","_Wizzo","_canopy"];

private _plane = param [0,objNull];

if (_plane getVariable ["bis_ejected",false]) exitWith {};
_plane setVariable ["bis_ejected",true];

_plane spawn
{
	private _plane = _this;
	
	private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "EjectionSystem";
	private _ejectionSeatEnabled = getNumber (_configPath >> "EjectionSeatEnabled"); if (_ejectionSeatEnabled == 0) exitWith {};
	private _dual_ejection = getNumber (_configPath >> "EjectionDual");
	private _canopyHideAnim = getText (_configPath >> "CanopyHideAnim"); if (_plane animationPhase _canopyHideAnim > 0.01) exitWith {};
	private _ejectionSeatClass = getText (_configPath >> "EjectionSeatClass");
	private _ejectionSeatHideAnim = getText (_configPath >> "EjectionSeatHideAnim");
	private _ejectionSeatRailAnim = getText (_configPath >> "EjectionSeatRailAnim");
	private _ejectionSeatForce = getNumber (_configPath >> "EjectionSeatForce");
	private _canopyForce = getNumber (_configPath >> "canopyForce");
	private _canopyClass = getText (_configPath >> "canopyClass");
	private _canopyExplodes = getNumber (_configPath >> "canopyExplodes") == 1;
	private _ejectionParachute = getText (_configPath >> "EjectionParachute");	
	private _ejectionrear = getText (_configPath >> "EjectionRear");	
	
	private _Pilot = driver _plane;
	private _Wizzo = "";
	
	if (_ejectionrear == "gunner") then
	{
		_Wizzo = gunner _plane;	
	}
	else
	{
		_Wizzo = commander _plane;		
	};



	private _memoryPointEjectionSeat = getText (_configPath >> "EjectionSeatPos");
	private _memoryPointCanopy = getText (_configPath >> "CanopyPos");

	_plane animate [_canopyHideAnim,1];

	_Canopy = createVehicle [_canopyClass, [100,100,100],[],0,"CAN_COLLIDE"];
	_Canopy allowDamage false;
	_plane disableCollisionWith _Canopy;

	private _canopyPos = _plane modelToWorldWorld ((_plane selectionPosition _memoryPointCanopy) vectorAdd [0,0,2]);
	_canopy setPosWorld _canopyPos;
	_canopy setVectorDirAndUp [vectorDir _plane, vectorUp _plane];

	private _planeVelocityModelSpace = velocityModelSpace _plane;
	_canopy setVelocityModelSpace ((_planeVelocityModelSpace apply {_x/10}) vectorAdd [0,-0.2 * _canopyForce,_canopyForce]);
	_canopy addTorque (_canopy vectorModelToWorld [-1000,0,0]);

	sleep 0.5;

	_plane animate [_ejectionSeatHideAnim,1];

	if ((isServer) and (!isMultiplayer) and (!isDedicated)) then
	{
		if (_dual_ejection == 0) then
		{
			[_plane,_Pilot] spawn FIR_fnc_AWS_Ejection_Person;
			sleep 3;	
		};
		if (_dual_ejection == 1) then
		{
			[_plane,_Wizzo] spawn FIR_fnc_AWS_Ejection_Person;
			sleep 0.4;
			[_plane,_Pilot] spawn FIR_fnc_AWS_Ejection_Person;
			sleep 3;
		};
	}
	else
	{
		if (_dual_ejection == 1) then
		{
			if (player == _Wizzo) then
			{
				[_plane,player] spawn FIR_fnc_AWS_Ejection_Person;
			}
			else
			{
				[_plane,_Wizzo] spawn FIR_fnc_AWS_Ejection_Person;
			};
			sleep 0.4;
			if (player == _Pilot) then
			{
				[_plane,player] spawn FIR_fnc_AWS_Ejection_Person;
			}
			else
			{
				[_plane,_pilot] spawn FIR_fnc_AWS_Ejection_Person;
			};
			sleep 3;
		};
		if (_dual_ejection == 0) then
		{
			if (player == _Pilot) then
			{
				[_plane,player] spawn FIR_fnc_AWS_Ejection_Person;
			}
			else
			{
				[_plane,_pilot] spawn FIR_fnc_AWS_Ejection_Person;
			};	
		};
	};

	_plane lock 2;
	_plane setfuel 0;

	sleep 15;

	deletevehicle _Canopy;

};
