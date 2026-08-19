private ["_combo","_array","_index","_name","_value"];

private _display = [_this,0,objnull] call BIS_fnc_param;
private _combo = [_this,1,objnull] call BIS_fnc_param;
private _array = [_this,2,[]] call BIS_fnc_param;
private _type = [_this,3,"data"] call BIS_fnc_param;

_index = (count _array)-1;

_ctrl = (findDisplay _display) displayCtrl _combo;
private _name = "";
private _value = "";
	
for "_i" from 0 to _index do
{
	_name = ((_array select _i) select 0);
	_value = ((_array select _i) select 1);
	
	// lbAdd[_combo,_name];
	
	_ctrl lbAdd _name;
	
	if (_type isEqualTo "data") then
	{
		// lbSetData [_combo, _i, _value];			
		_ctrl lbSetData [_i,_value];
	};
	if (_type isEqualTo "value") then
	{
		// lbSetValue [_combo, _i, _value];			
		_ctrl lbSetValue [_i, _value];		
	};
};
