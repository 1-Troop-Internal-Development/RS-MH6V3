
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


If (not Local _plane) ExitWith {};
if (not(_plane iskindof "Plane")) ExitWith {player vehiclechat "You Must get in the Plane!";};

_plane_type = typeof _plane;

_get_code = lbCurSel 2100;
_codename = lbText [2100, _get_code];

_ades_aircraft_type = gettext (configFile >> "CfgVehicles" >> _plane_type >> "ades_aircraft");

_ades_preview = gettext (configFile >> "CfgADES_Skin" >> _ades_aircraft_type >> "ades_preview");
_ades_name = gettext (configFile >> "CfgADES_Skin" >> _ades_aircraft_type >> "ades_name");

_texture_data = getText (configfile >> "CfgVehicles" >> _codename >> _ades_preview);
_texture_name = getText (configfile >> "CfgVehicles" >> _codename >> _ades_name);

if (_texture_data == "") then
{
	_texture_data = "\FIR_AirWeaponSystem_US\ui\pic_no_preview.paa";
};
ctrlSetText [1200, _texture_data];//for Dialogs