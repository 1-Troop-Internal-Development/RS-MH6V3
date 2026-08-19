
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

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "ADESData";
private _ADESEnabled = getNumber (_configPath >> "ADESEnabled"); if (_ADESEnabled == 0) exitWith {};
private _NumberEnabled = getNumber (_configPath >> "NumberEnabled");
private _NumberList = getArray (_configPath >> "NumberList");
private _EmblemEnabled = getNumber (_configPath >> "EmblemEnabled");
private _KillmarkEnabled = getNumber (_configPath >> "KillmarkEnabled"); 
private _NameEnabled = getNumber (_configPath >> "NameEnabled"); 
private _NameType = getText (_configPath >> "NameType");


If (not Local _plane) ExitWith {};
if (not(_plane iskindof "Plane")) ExitWith {player vehiclechat "You Must get in the Plane!";};

private _rank = lbdata [2100,(lbCurSel 2100)];
private _rank2 = lbdata [2101,(lbCurSel 2101)];
private _name = ctrlText 1400;
private _name2 = ctrlText 1401;
private _font_color_get = lbdata [2102,(lbCurSel 2102)];
private _seater = "";

switch (_NameType) do
{
    case "AF_Single":
    {
		_seater = "single";	
    };
    case "AF_Dual":
    {
		_seater = "dual";
    };
    case "Navy_Single":
    {
		_seater = "single";		
    };
    case "Navy_Dual":
    {
		_seater = "dual";
    };
    default
    {
		_seater = "single";	
    };
};


[_plane,_name,_rank,_font_color_get,_name2,_rank2,_seater] call FIR_fnc_AWS_SetRankName;