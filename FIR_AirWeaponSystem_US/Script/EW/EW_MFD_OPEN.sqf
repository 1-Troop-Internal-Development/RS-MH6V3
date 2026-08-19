/* Open MFD By Firewill */
private ["_plane","_range_str","_alt_str","_range","_alt"];

_plane = vehicle player;

/*If (not Local player) ExitWith {};*/
if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat "You Must get in the Aircraft!";};

// _handle= CreateDialog "FIR_AWS_EW_MFD";
findDisplay 46 createDisplay "FIR_AWS_EW_MFD";
disableSerialization;
_mydisplay = findDisplay 5590;

_decoy_ctrl = _mydisplay displayCtrl 2100;
_decoy_txt = _mydisplay displayCtrl 2002;
_range_txt = _mydisplay displayCtrl 2003;
_alt_txt = _mydisplay displayCtrl 2004;
	{
		_decoy_ctrl lbAdd getText (_x >> "name");
		_decoy_ctrl lbSetData [_foreachindex, getText (_x >> "decoytype")];

	} forEach ("isClass _x" configClasses (configFile >> "CfgAWS_EW_Decoy"));	

_decoy_ctrl lbSetCurSel 0;

_check = _plane getvariable ["AWS_EW_CHECK","no"];

if (_check == "no") then
{
	_plane setVariable ["AWS_EW_CHECK","yes",true];
	_plane setVariable ["AWS_EW_ACTIVE","no",true];	
	_plane setVariable ["AWS_EW_RANGE",1500,true];
	_plane setVariable ["AWS_EW_ALT",2000,true];
	_plane setVariable ["AWS_ESM_STATUS","no",true];	
}
else
{

};
_decoy_data_get = lbCurSel _decoy_ctrl;
_decoy_data = _decoy_ctrl lbdata _decoy_data_get;
_range = _plane getVariable "AWS_EW_RANGE";
_alt = _plane getVariable "AWS_EW_ALT";

_range_str = str _range;
_alt_str = str _alt;

_decoy_txt ctrlSetText _decoy_data;
_range_txt ctrlSetText _range_str;
_alt_txt ctrlSetText _alt_str;		

//ctrlSetText [2002, _decoy_data];
//ctrlSetText [2003, _range_str];
//ctrlSetText [2004, _alt_str];		
