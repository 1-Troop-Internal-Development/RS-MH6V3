private ["_plane","_type"];

// _plane = vehicle player;

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

_type = _plane getVariable "ITGT_TYPE";
_planetype = typeof _plane;

private _text = "";
private _msg = "";

_get_gps_type = getText (configFile >> "CfgVehicles" >> _planetype >> "FIR_AWS_GPS_Type");

switch (_get_gps_type) do
{
    case "GPS":
    {
		_text = "MODE : GPS";
		_msg = "SYSTEM : SWITCH TO GPS MODE";
    };
    case "GLONASS":
    {
		_text = "MODE : GLONASS";
		_msg = "SYSTEM : SWITCH TO GLONASS MODE";		
    };
	default
	{
		_text = "MODE : GPS";		
		_msg = "SYSTEM : SWITCH TO GPS MODE";		
	};
};


switch (_type) do
{
    case "GPS":
    {
		_plane setVariable ["ITGT_TYPE","DUAL",true];		
		systemChat "SYSTEM : SWITCH TO DUAL MODE";
		ctrlSetText [1999, "MODE : DUAL"];	

    };
    case "DUAL":
    {
		_plane setVariable ["ITGT_TYPE","CG",true];		
		systemChat "SYSTEM : SWITCH TO CG MODE";
		ctrlSetText [1999, "MODE : CG"];	
    };
    case "CG":
    {
		_plane setVariable ["ITGT_TYPE","CGT",true];		
		systemChat "SYSTEM : SWITCH TO CG-Terminal MODE";
		ctrlSetText [1999, "MODE : CG-Terminal"];	
    };	
    case "CGT":
    {
		_plane setVariable ["ITGT_TYPE","GPS",true];		
		systemChat _msg;
		ctrlSetText [1999, _text];		
    };		
};
