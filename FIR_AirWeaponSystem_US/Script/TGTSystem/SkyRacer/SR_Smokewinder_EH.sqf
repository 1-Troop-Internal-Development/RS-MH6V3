/*
Smokewinder for aircraft
need to input "FIR_AWS_Smokewinder_Pos" with setvariable command for custom position.
 [[-5,-3,0],[5,-3,0]] position is will be used if no FIR_AWS_Smokewinder_Pos variable in aircraft.
*/

private _array = _this select 0;
private _plane = _array select 0;
private _mode = _array select 3;
private _magname = _array select 5;

private _delay = 0;
private _smoketype = (configFile >> "CfgMagazines" >> _magname >> "FIR_AWS_SmokeType") call BIS_fnc_getCfgData;
private _var = _plane getVariable ["FIR_AWS_Smokewinder_Pos","none"];
private _default_pos = [[-5,-3,0],[5,-3,0]];
private _default_num = 1;
private _pylonlist = GetPylonMagazines _plane;
private _sw_count = 0;
private _smoke_array = [];
private _var_c = 0;
private _sw_type = 0;

for "_i" from 0 to ((count _pylonlist )- 1) do
{
	private _equip = _pylonlist select _i;
	_sw_type = getNumber (configFile >> "CfgMagazines" >> _equip >> "FIR_AWS_isSmokewinder");
	if (_sw_type == 1) then
	{
		_sw_count = _sw_count + 1;
	};
};

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

if (_var isEqualTo "none") then
{
	if (_sw_count == 1) then
	{
		_default_num = 0;
	};
	for "_i" from 0 to _default_num do
	{	
		_smoke_pos = _default_pos select _i;
		_smoke = createVehicle [_smoketype, [0,0,0], [], 0 , ""];	
		_smoke_array pushBack _smoke;
		_smoke attachTo [_plane,_smoke_pos];			
	};
}
else
{
	_var_c = count _var;
	if (_sw_count > _var_c) then
	{
		_default_num = (_var_c-1);
	}
	else
	{
		if (_sw_count < _var_c) then
		{
			_default_num = (_sw_count-1);
		}
		else
		{
			_default_num = (_var_c-1);
		};
	};
	for "_i" from 0 to _default_num do
	{	
		_smoke_pos = _var select _i;
		_smoke = createVehicle [_smoketype, [0,0,0], [], 0 , ""];	
		_smoke_array pushBack _smoke;
		
		if ((typeName _smoke_pos) isEqualTo "ARRAY") then
		{
			_smoke attachTo [_plane,_smoke_pos];		
		}
		else
		{
			_smoke attachTo [_plane, (_plane selectionPosition _smoke_pos)];					
		};
	};
};


sleep _delay;

{detach _x;deleteVehicle _x;} foreach _smoke_array;



