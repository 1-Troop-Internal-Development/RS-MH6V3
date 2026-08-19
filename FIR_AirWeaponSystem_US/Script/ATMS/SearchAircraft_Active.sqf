
private _list = player nearEntities ["Plane", 150];
private _list_active = missionNamespace "ATMS_Aircraft_List";

_index = count _list_active;
_index = _index - 1;
lbClear 1500;

missionNamespace setVariable ["ATMS_Search_Status","no",true];		
missionNamespace setVariable ["ATMS_Search_Active_Status","yes",true];		

for "_i" from 0 to _index do
{

	_plane = _list_active select _i;
	_flag = 0;
	
	_check = _plane getVariable ["AWS_ACMI_PLANE_CHECK","no"];
	
	_pylon = GetPylonMagazines _plane;
	_pylon_count = count _pylon;
	
	for "_y" from 0 to _pylon_count-1 do
	{
		private _mag = _pylon select _y;
		private _acmi = getNumber (configFile >> "CfgMagazines" >> _mag >> "AWS_ACMI");

		if (_acmi isEqualTo 1) then
		{
			_flag = 1;
		};
	}; 		
	if (_flag isEqualTo 1) then
	{
		if (_check isEqualTo "no") then
		{
			private _r = floor (random 9999);
			private _aircraft_id = _prefix + str _r;		
			_plane setvariable ["AWS_ACMI_PLANE",_aircraft_id,true];
			_plane setvariable ["AWS_ACMI_PLANE_CHECK","yes",true];
			
		}
		else
		{

		};
		_name = getText (configFile >> "CfgVehicles" >> typeof _plane >> "displayName");	
		_id = _plane getVariable "AWS_ACMI_PLANE";
	
		lbAdd[1500,_name];
		lbSetData [1500, _i, _id];				
	};

};
