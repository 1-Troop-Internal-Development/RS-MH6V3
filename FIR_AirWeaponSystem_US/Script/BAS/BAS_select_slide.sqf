
private _computer_data = lbValue [1500,(lbCurSel 1500)];
private _screen_data = lbValue [1501,(lbCurSel 1501)];
private _slide_data = lbData [1502,(lbCurSel 1502)];
private _slide_num = lbValue [1502,(lbCurSel 1502)];

private _computers = missionNamespace getVariable "AWS_BAS_COMP_LIST";
private _screens = missionNamespace getVariable "AWS_BAS_SCREEN_LIST";

private _computer = "";
private _screen = "";
private _slide = "";

for "_i" from 0 to (count _computers) - 1 do
{
	private _computer_can = _computers select _i;	
	private _computer_id = _computer_can getVariable "AWS_BAS_COMP_ID";

	if (_computer_id isEqualTo _computer_data) then
	{
		_computer = _computer_can;
	};
}; 

sleep 0.0001;

for "_i" from 0 to (count _screens) - 1 do
{
	private _screen_can = _screens select _i;	
	private _screen_id = _screen_can getVariable "AWS_BAS_SCREEN_ID";

	if (_screen_id isEqualTo _screen_data) then
	{
		_screen = _screen_can;
		_computer setVariable ["AWS_BAS_SELECTED_SCREEN",_screen,true];		
	};
}; 

sleep 0.0001;

_computer setVariable ["AWS_BAS_SELECTED_SLIDE",_slide_data,true];
_computer setVariable ["AWS_BAS_COUNT",_slide_num,true];

_check = _computer getVariable ["AWS_BAS_ASSIGN_CHECK",false];

if (_check) then
{

}
else
{
	_computer setVariable ["AWS_BAS_ASSIGN_CHECK",true,true];

					[[_computer, [
				"Start slideshow",
				"\FIR_AirWeaponSystem_US\Script\BAS\BAS_Start.sqf",
				[],
				1,
				true,
				true,
				"",
				"_target getVariable 'AWS_BAS_STATUS' == 'off'"
			]],"addAction",true,true] call BIS_fnc_MP;	
			
		[[_computer, [
				"Next slideshow",
				"\FIR_AirWeaponSystem_US\Script\BAS\BAS_next.sqf",
				[],
				1,
				true,
				true,
				"",
				"_target getVariable 'AWS_BAS_STATUS' == 'on'"
			]],"addAction",true,true] call BIS_fnc_MP;	
			
		[[_computer, [
				"Prev slideshow",
				"\FIR_AirWeaponSystem_US\Script\BAS\BAS_prev.sqf",
				[],
				1,
				true,
				true,
				"",
				"_target getVariable 'AWS_BAS_STATUS' == 'on'"
			]],"addAction",true,true] call BIS_fnc_MP;	
			
		[[_computer, [
				"End slideshow",
				"\FIR_AirWeaponSystem_US\Script\BAS\BAS_end.sqf",
				[],
				1,
				true,
				true,
				"",
				"_target getVariable 'AWS_BAS_STATUS' == 'on'"
			]],"addAction",true,true] call BIS_fnc_MP;			
				

};


systemChat "slide assigned";
