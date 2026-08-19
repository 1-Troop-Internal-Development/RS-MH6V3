/* Open MFD By Firewill */
private ["_plane"];

// _plane = vehicle player;
// _planetype = typeof _plane;

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

/*If (not Local player) ExitWith {};*/
if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat "You Must get in the Aircraft!";};
_handle= CreateDialog "FIR_AWS_ITGT";


	
_type = _plane getvariable "ITGT_TYPE";

private _text = "";

_get_gps_type = getText (configFile >> "CfgVehicles" >> _planetype >> "FIR_AWS_GPS_Type");

switch (_get_gps_type) do
{
    case "GPS":
    {
		_text = "MODE : GPS";
    };
    case "GLONASS":
    {
		_text = "MODE : GLONASS";
    };
	default
	{
		_text = "MODE : GPS";		
	};
};


switch (_type) do
{
    case "GPS":
    {
		ctrlSetText [1999, _text];
    };

    case "DUAL":
    {
		ctrlSetText [1999, "MODE : DUAL"];
    };
    case "CG":
    {
		ctrlSetText [1999, "MODE : CG"];
    };	
    case "CGT":
    {
		ctrlSetText [1999, "MODE : CG-Terminal"];
    };		
};

_type2 = _plane getvariable "ITGT_GRIDTYPE";

switch (_type2) do
{
    case "8D":
    {
		ctrlSetText [1998, "8DIGITS"];
    };

    case "10D":
    {
		ctrlSetText [1998, "10DIGITS"];
    };
};

_slotcheck = _plane getvariable ["AWS_MEMORYSLOT_CHECK","no"];

if (_slotcheck == "no") then
{
	_plane setVariable ["AWS_MEMORYSLOT_CHECK","yes",true];
	_plane setVariable ["AWS_MEMORYSLOT",1,true];	
	_plane setvariable ["FIR_AWS_Nux_tvs_thermal",0];	
}
else
{

};

_slot = _plane getVariable "AWS_MEMORYSLOT";

_slot_str = "Slot No." + str _slot;

ctrlSetText [1997, _slot_str];		

