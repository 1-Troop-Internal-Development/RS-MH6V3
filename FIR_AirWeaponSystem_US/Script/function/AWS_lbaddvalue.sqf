private ["_combo","_array","_index","_name","_value"];

_combo = [_this,0,objnull] call BIS_fnc_param;
_array = [_this,1,[]] call BIS_fnc_param;

_index = count _array;
_index = _index - 1;

for "_i" from 0 to _index do
{
	_name = ((_array select _i) select 0);
	_value = ((_array select _i) select 1);
	
	lbAdd[_combo,_name];
	lbSetValue [_combo, _i, _value];		
};
