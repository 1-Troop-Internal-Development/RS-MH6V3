_plane = _this select 0;	
_person = _this select 1;

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "EjectionSystem";
private _ejectionSeatClass = getText (_configPath >> "EjectionSeatClass");
private _ejectionSeatForce = getNumber (_configPath >> "EjectionSeatForce");
private _ejectionParachute = getText (_configPath >> "EjectionParachute");

_Ejection_Seat_P =_ejectionSeatClass createvehicle [0,0,1000];
_Ejection_Seat_P attachTo [_plane,[0,1.3,6],"actionarea"];

detach _Ejection_Seat_P;
[_plane,_Ejection_Seat_P] spawn FIR_fnc_AWS_Ejection_FX;

_planeVelocityModelSpace = velocityModelSpace _plane;
_Ejection_Seat_P setVelocityModelSpace (_planeVelocityModelSpace apply {_x/10} vectorAdd [0.5,0.5,_ejectionSeatForce]);

moveOut _person;
[[_person,_Ejection_Seat_P],"moveindriver"] call BIS_fnc_MP;

if (backpack _person == "B_Parachute") then
{
	removeBackpack _person;
};

sleep 3;
_ejection_pb = _Ejection_Seat_P call BIS_fnc_getPitchBank;
_ejection_pitch = _ejection_pb select 0;
_ejection_bank = _ejection_pb select 1;
[[_Ejection_Seat_P,[1,1,1]],"setVelocity"] call BIS_fnc_MP;
sleep 0.03;

moveOut _person;
WaitUntil {vehicle _person != _Ejection_Seat_P};

_Parachute = _ejectionParachute createvehicle getpos _person;
_person assignAsDriver _Parachute;
_Parachute setdir (getdir _person);
_Parachute setpos  (getpos _person);
[_Parachute, _ejection_pitch, _ejection_bank] call BIS_fnc_setPitchBank;
[[_person,_Parachute],"moveindriver"] call BIS_fnc_MP;

sleep 15;

deletevehicle _Ejection_Seat_P;

