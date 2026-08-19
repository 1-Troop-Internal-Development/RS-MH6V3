
private _pos = _this select 0;
private _range = _this select 1;
private _time = 0;


while {_time >= 150} do
{
	private _manlist = _pos nearEntities ["Man", _range];
	{_dam = damage _x; _x setdamage _dam + 0.01; _x sidechat "i'm burning!";} foreach _manlist;
	_time = _time + 1;
	uisleep 0.3;
};
