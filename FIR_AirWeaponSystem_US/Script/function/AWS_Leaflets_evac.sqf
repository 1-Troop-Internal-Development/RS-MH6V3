private _array = _this select 0;
private _obj = _array select 0;
private _weapon = _array select 1;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _projectile = _array select 6;

//check evacuation function enabled. AWS_EVAC_Disable = true is disable this function. false is vice versa. default = false.
private _check = missionNamespace getvariable ["AWS_EVAC_Disable",false];
//determine range of leaflet can be effect for civilians.
private _range = missionNamespace getVariable ["AWS_EVAC_Leaflet_Range",500];

private _type = missionNamespace getVariable ["AWS_EVAC_Type","safepos"];
if (_check) exitWith {hintsilent "evac function disabled.";};

sleep 1.9;

private _pos = getpos _projectile;

sleep 5;

//get list of civilians in leaflet spreading area
private _list = _pos nearEntities [["Man","Car","Motorcycle"], _range];
private _list_c = count _list;

// give some time for civilian read some leaflets and start run.
sleep 15;

//escape from dangerous zone
if (_list_c > 0) then
{
	for "_i" from 0 to (_list_c - 1) do
	{
		private _unit = _list select _i;
		private _grp = group _unit;
		if (side _unit == civilian) then
		{
			_safepos = [_pos, 1000, 2500] call BIS_fnc_findSafePos;
			 while {(count (waypoints _grp)) > 0} do
			{
				deleteWaypoint ((waypoints _grp) select 0);
			};
			_wp =_grp addWaypoint [_safepos, 0];
			_wp setWaypointType "MOVE";
		};	
	};
};

