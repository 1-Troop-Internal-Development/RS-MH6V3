private _plane = "";
private _planetype = "";

private _UAV = getConnectedUAV player;

//if not UAV
if (_UAV isEqualTo objNull) then
{
	_plane = vehicle player;
	_plane_pilot = driver _plane;
}
else
{
// if UAV and MQ-81U only

		_plane = _UAV;	
		_plane_pilot = player;		
};

private _emblem_data = lbData [2101, (lbCurSel 2101)];
private _emblem_point_data = lbData [2102,(lbCurSel 2102)];

_planetype = typeof _plane;

private ["_index"];
_index = -1;
{
	if (_x == _emblem_point_data) exitwith {_index = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

if (_index < 0) then 
{
	_plane vehiclechat "you don't have this Selection!";
}
 else 
 {
	_plane setobjecttextureglobal [_index,_emblem_data];
};

_plane vehiclechat format ["emblem placed on %1",_emblem_point_data];