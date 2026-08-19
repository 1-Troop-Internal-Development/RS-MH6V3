/* TARPS
   Made by Firewill 
 */
 
 private ["_date","_year","_month","_day","_hour","_min","_sec","_prefix","_subfix","_main"];
 
 _prefix = "TARPS_Photo\";
 _subfix = ".png";

 if (cameraView == "GUNNER") then
{
	_date = date;
	_year = _date select 0;
	_month = _date select 1;
	_day = _date select 2;
	_hour = floor daytime;
	_min = floor ((daytime - _hour) * 60);
	_sec = floor (((((daytime) - (_hour))*60) - _min)*60);

	_year = str _year;
	_month = str _month;
	_day = str _day;
	_hour = str _hour;
	_min = str _min;
	_sec = str _sec;

	_main = _year + "_" + _month + "_" + _day + "_" + _hour + "_" + _min + "_" + _sec;

	_main = _prefix + _main + _subfix;

	["blackandwhite",0,false] call bis_fnc_setppeffecttemplate;
	screenshot  _main;
	sleep 0.03;

	["NONE",0,false] call bis_fnc_setppeffecttemplate;
};
