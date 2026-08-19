//[computer,screen] call fir_fnc_aws_bas_enable;

params [["_control",objNull],["_computers",[]],["_screens",[]]];

if (_control isEqualTo objNull) exitWith {};

missionNamespace setVariable ["AWS_BAS_COMP_LIST",_computers,true];
missionNamespace setVariable ["AWS_BAS_SCREEN_LIST",_screens,true];

private _index_c = count _computers;
_index_c = _index_c - 1;
private _index_s = count _screens;
_index_s = _index_s - 1;


for "_i" from 0 to _index_c do
{
	private _computer = _computers select _i;
	_computer setVariable ["AWS_BAS_COMP_ID",_i,true];
	_computer setVariable ["AWS_BAS_SELECTED_SLIDE","",true];
	_computer setVariable ["AWS_BAS_SELECTED_SCREEN","",true];
	_computer setVariable ["AWS_BAS_STATUS","off",true];
	_computer setVariable ["AWS_BAS_COUNT",0,true];
	_computer setVariable ["AWS_BAS_CURRENT",0,true];
	_computer setVariable ["AWS_BAS_ASSIGN_CHECK",false,true];
};

for "_j" from 0 to _index_s do
{
	private _screen = _screens select _j;
	_screen setVariable ["AWS_BAS_SCREEN_ID",_j,true];
};



if (isServer) then
{
	[[_control, [
			"Open BAS Dialog",
			"\FIR_AirWeaponSystem_US\Script\BAS\BAS_Open.sqf",
			[],
			1,
			true,
			true,
			"",
			"true"
		]],"addAction",true,true] call BIS_fnc_MP;	
					
};


		
	// [[_computer, [
			// "Start slideshow",
			// "\FIR_AirWeaponSystem_US\Script\BAS\BAS_Start.sqf",
			// [],
			// 1,
			// true,
			// true,
			// "",
			// "_target getVariable 'AWS_BAS_STATUS' == 'off'"
		// ]],"addAction",true,true] call BIS_fnc_MP;	
		
	// [[_computer, [
			// "Next slideshow",
			// "\FIR_AirWeaponSystem_US\Script\BAS\BAS_next.sqf",
			// [],
			// 1,
			// true,
			// true,
			// "",
			// "_target getVariable 'AWS_BAS_STATUS' == 'on'"
		// ]],"addAction",true,true] call BIS_fnc_MP;	
		
	// [[_computer, [
			// "Prev slideshow",
			// "\FIR_AirWeaponSystem_US\Script\BAS\BAS_prev.sqf",
			// [],
			// 1,
			// true,
			// true,
			// "",
			// "_target getVariable 'AWS_BAS_STATUS' == 'on'"
		// ]],"addAction",true,true] call BIS_fnc_MP;	
		
	// [[_computer, [
			// "End slideshow",
			// "\FIR_AirWeaponSystem_US\Script\BAS\BAS_end.sqf",
			// [],
			// 1,
			// true,
			// true,
			// "",
			// "_target getVariable 'AWS_BAS_STATUS' == 'on'"
		// ]],"addAction",true,true] call BIS_fnc_MP;			