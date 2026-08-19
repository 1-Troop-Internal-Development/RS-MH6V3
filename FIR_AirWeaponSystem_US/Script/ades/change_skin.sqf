/*Loadout Dialog By Firewill*/

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

_planetype = typeof _plane;

If (not Local _plane) ExitWith {};
if (not(_plane iskindof "Plane")) ExitWith {player vehiclechat "You Must get in the Plane!";};

_get_code = lbCurSel 2100;
_codename = lbText [2100, _get_code];
_texture_array = getArray (configFile >> "CfgVehicles" >> _codename >> "hiddenselectionstextures");

_plane_type = typeof _plane;

_ades_aircraft_type = gettext (configFile >> "CfgVehicles" >> _plane_type >> "ades_aircraft");

_ades_type = gettext (configFile >> "CfgADES_Skin" >> _ades_aircraft_type >> "ades_type");
_ades_name = gettext (configFile >> "CfgADES_Skin" >> _ades_aircraft_type >> "ades_name");
_ades_skin_count = getnumber (configFile >> "CfgADES_Skin" >> _ades_aircraft_type >> "ades_skin_count");
_ades_skin_count = _ades_skin_count - 1;

_ades_acc_script_check = gettext (configFile >> "CfgADES_Skin" >> _ades_aircraft_type >> "ades_acc_script_check");
_ades_name = gettext (configFile >> "CfgADES_Skin" >> _ades_aircraft_type >> "ades_name");

_texture_name = getText (configfile >> "CfgVehicles" >> _codename >> _ades_name);
_plane vehiclechat format ["skin name : %1", _texture_name];


for "_i" from 0 to _ades_skin_count do
{
	_plane setobjecttextureglobal[_i, _texture_array select _i]; 	
};

if (_ades_acc_script_check == "yes") then
{
	_ades_acc_script = gettext (configFile >> "CfgADES_Skin" >> _ades_aircraft_type >> "ades_acc_script");
	
	_acc = [_codename] execVM _ades_acc_script;
};

