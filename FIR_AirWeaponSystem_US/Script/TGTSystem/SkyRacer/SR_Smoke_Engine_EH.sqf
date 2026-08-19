/*
Aerobatic smoke generator EH for aircraft engine
need to define FIR_AWS_smoke_engine in aircraft config OR input "FIR_AWS_Smoke_Engine_Pos" with setvariable command for custom position.
[0,0,0] position is will be used if no FIR_AWS_smoke_engine value and no FIR_AWS_Smoke_Engine_Pos variable in aircraft.
*/

private _array = _this select 0;
private _plane = _array select 0;
private _mode = _array select 3;
private _magname = _array select 5;

private _delay = 0;
private _pos = (configFile >> "CfgVehicles" >> typeOf _plane >> "FIR_AWS_smoke_engine") call BIS_fnc_getCfgData;
private _smoketype = (configFile >> "CfgMagazines" >> _magname >> "FIR_AWS_SmokeType") call BIS_fnc_getCfgData;
private _var = _plane getVariable ["FIR_AWS_Smoke_Engine_Pos","none"];


switch (_mode) do
{
    case "10s":
    {
		_delay = 10;
    };
    case "20s":
    {
		_delay = 20;
    };
    case "30s":
    {
		_delay = 30;
    };
};

private _smoke = createVehicle [_smoketype, [0,0,0], [], 0 , ""];

if (isNil "_pos") then
{
	if (_var isEqualTo "none") then
	{
		_smoke attachTo [_plane, [0,0,0]];
	}
	else
	{
		if ((typeName _var) isEqualTo "ARRAY") then
		{
			_smoke attachTo [_plane,_var];
		}
		else
		{
			if (_var isEqualTo [0,0,0]) then
			{
				_smoke attachTo [_plane, [0,0,0]];
			}
			else
			{
				_smoke attachTo [_plane, (_plane selectionPosition _var)];
			};
		};
	};
}
else
{
	_smoke attachTo [_plane, (_plane selectionPosition _pos)];
};

sleep _delay;

detach _smoke;
deleteVehicle _smoke;
