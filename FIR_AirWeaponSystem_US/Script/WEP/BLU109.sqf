/* 
BLU-109 BunkerBuster script by firewill
eliminate the personnels in building, doesn't matter building is can be destructible or not.
 */

private _blu109 = _this select 0;
private _blu109zpos = getpos _blu109 select 2;
private _blu109speed = velocity _blu109;
private _blu109pos = getpos _blu109;
private _blu109dir = getdir _blu109;
private _deadlist = [];
private _ignorelist = getArray (configFile >> "CfgAWS_IgnoranceList" >> "aws_ignorelist");


while {alive _blu109} do
{
	_blu109zpos = getpos _blu109 select 2;
	_blu109speed = velocity _blu109;
	_blu109pos = getpos _blu109;
	_blu109dir = getdir _blu109;
		
	sleep 0.03;
};

sleep 1;

_building = "";
//only House classname because toooooo many building parent class in arma3 object.
private _building_ary = nearestObjects [_blu109pos, ["House"], 22];
if (count _building_ary >= 1) then
{
	_building = _building_ary select 0;
};

if (_building isEqualTo "") exitWith {
	_sub_ex = "FIR_BLU109_EX_Outside" createvehicle _blu109pos;
	_sub_ex setposASL [(getposASL _sub_ex select 0),(getposASL _sub_ex select 1),6];
	_sub_ex setdamage 1;
};

private _building_check = _ignorelist find (typeof _building);
if (_building isKindOf "House" and _building_check == -1) then
{
//is a building. explode and kill everybody in the building and maybe near peoples also will be dead. and if indestructible building, make ruin and hide original building model.

	_building_pos = getpos _building;
	_boundingbox = boundingBoxReal _building;
	_p1 = _boundingbox select 0;
	_p2 = _boundingbox select 1;
	_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
	_maxLength = abs ((_p2 select 1) - (_p1 select 1));
	_maxHeight = abs ((_p2 select 2) - (_p1 select 2));	

	_area_scan = (_maxWidth + _maxLength) / 2;
	
	_destrType = getText (configFile >> "CfgVehicles" >> typeOf _building >> "replaceDamaged");	
	
	_units_ary = _building_pos nearEntities ["Man", _area_scan];
	_units_ary_count = count _units_ary;
	_units_ary_count = _units_ary_count - 1;
	
	for "_i" from 0 to _units_ary_count do
	{
		_unit = _units_ary select _i;
		
		_unitpos = _building worldToModel (getPos _unit);
		_pt1 = _unitpos;

		if (((_p1 select 0 <= _pt1 select 0) && (_p1 select 1 <= _pt1 select 1) && (_p1 select 2 <= _pt1 select 2)) && ((_pt1 select 0 <= _p2 select 0) && (_pt1 select 1 <= _p2 select 1) && (_pt1 select 2 <= _p2 select 2))) then
		{
			_deadlist pushBack _unit;
		};

	};	
	
	_sub_ex = "FIR_BLU109_EX" createvehicle _building_pos;
	_sub_ex setpos [(_building_pos select 0),(_building_pos select 1),1.5];
	_sub_ex setdamage 1;	

	{_x setDamage 1;} foreach _deadlist;	
	
	if (_destrType == "") then
	{
		// if building is indestructible.. maybe. but most indestructible building has no any replacedamaged value. make some common ruin model and hide original building.
	
		for [{_i=0}, {_i < 1}, {_i=_i+1}] do
		{	
			_ruin = "Land_Stone_HouseBig_V1_ruins_F" createvehicle _building_pos;
			_normal = surfaceNormal _building_pos;
			_ruin setVectorUp _normal;
		};
		[_building,"hideObject",true,true] call BIS_fnc_MP;		
		// _building hideObjectGlobal true;
	};
	

};
