if (not Local player) Exitwith {};
_plane = vehicle player;

private _weap = _this;
private _weapcount = (count _weap)-1;
private _count = 1;
private _interval = 0.5;
private _custom = false;
private _mass = 0;

if (isNil "AWS_AMS_LoadingTime") then 
{
	_plane vehiclechat "custom value not found. standard inverval time : 0.5s";
}
else
{
	_plane vehiclechat "Weight-based Loading time enabled.";
	_custom = true;
};

for "_i" from 0 to _weapcount do
{
	_equip = _weap select _i;
	if (_custom) then
	{
		_mass = getNumber  (configFile >> "CfgMagazines" >> _equip >> "mass");		
		_interval = _mass * 0.1;
	};
	_plane vehicleChat format ["%1 / load time : %2 s",_equip,_interval];	
	sleep _interval;
	_plane setPylonLoadOut [_count,_equip, false, []];
	_count = _count + 1;
};
