
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
_handle= CreateDialog "FIR_SetNameRank_GUI";
disableSerialization;
_mydisplay = findDisplay 9912;

switch (_NameType) do
{
    case "AF_Single":
    {
		[2100,
			[
				["2LT","2lt"],
				["CAPT","capt"],
				["MAJ","maj"],
				["COL","col"]
			]
		] call FIR_fnc_lbadd;
		
	_font_ctrl = _mydisplay displayCtrl 2102;
		{
			_font_ctrl lbAdd getText (_x >> "name");
			_font_ctrl lbSetData [_foreachindex, getText (_x >> "fonttype")];

		} forEach ("isClass _x" configClasses (configFile >> "CfgAWS_Font"));	
		

		lbSetCurSel [2100, 0];
		lbSetCurSel [2102, 0];

		ctrlShow [1001, false ];
		ctrlShow [1003, false ];	
		ctrlShow [2101, false ];
		ctrlShow [1401, false ];	
	
    };
    case "AF_Dual":
    {
		[2100,
			[
				["2LT","2lt"],
				["CAPT","capt"],
				["MAJ","maj"],
				["COL","col"]
			]
		] call FIR_fnc_lbadd;
		
		[2101,
			[
				["2LT","2lt"],
				["CAPT","capt"],
				["MAJ","maj"],
				["COL","col"]
			]
		] call FIR_fnc_lbadd;		
		
	_font_ctrl = _mydisplay displayCtrl 2102;
		{
			_font_ctrl lbAdd getText (_x >> "name");
			_font_ctrl lbSetData [_foreachindex, getText (_x >> "fonttype")];

		} forEach ("isClass _x" configClasses (configFile >> "CfgAWS_Font"));	
		

		lbSetCurSel [2100, 0];
		lbSetCurSel [2101, 0];		
		lbSetCurSel [2102, 0];
    };
    case "Navy_Single":
    {
		[2100,
			[
				["LTJG","ltjg"],			
				["LT","lt"],
				["LCDR","lcdr"],
				["CAPT","capt"]
			]
		] call FIR_fnc_lbadd;
		
	_font_ctrl = _mydisplay displayCtrl 2102;
		{
			_font_ctrl lbAdd getText (_x >> "name");
			_font_ctrl lbSetData [_foreachindex, getText (_x >> "fonttype")];

		} forEach ("isClass _x" configClasses (configFile >> "CfgAWS_Font"));	
		

		lbSetCurSel [2100, 0];
		lbSetCurSel [2102, 0];

		ctrlShow [1001, false ];
		ctrlShow [1003, false ];	
		ctrlShow [2101, false ];
		ctrlShow [1401, false ];	
	
    };
    case "Navy_Dual":
    {
		[2100,
			[
				["LTJG","ltjg"],			
				["LT","lt"],
				["LCDR","lcdr"],
				["CAPT","capt"]
			]
		] call FIR_fnc_lbadd;
		
		[2101,
			[
				["LTJG","ltjg"],
				["LT","lt"],				
				["LCDR","lcdr"],
				["CAPT","capt"]
			]
		] call FIR_fnc_lbadd;		
		
	_font_ctrl = _mydisplay displayCtrl 2102;
		{
			_font_ctrl lbAdd getText (_x >> "name");
			_font_ctrl lbSetData [_foreachindex, getText (_x >> "fonttype")];

		} forEach ("isClass _x" configClasses (configFile >> "CfgAWS_Font"));	
		

		lbSetCurSel [2100, 0];
		lbSetCurSel [2101, 0];		
		lbSetCurSel [2102, 0];
    };
    default
    {
		[2100,
			[
				["2LT","2lt"],
				["CAPT","capt"],
				["MAJ","maj"],
				["COL","col"]
			]
		] call FIR_fnc_lbadd;
		
	_font_ctrl = _mydisplay displayCtrl 2102;
		{
			_font_ctrl lbAdd getText (_x >> "name");
			_font_ctrl lbSetData [_foreachindex, getText (_x >> "fonttype")];

		} forEach ("isClass _x" configClasses (configFile >> "CfgAWS_Font"));	
		

		lbSetCurSel [2100, 0];
		lbSetCurSel [2102, 0];

		ctrlShow [1001, false ];
		ctrlShow [1003, false ];	
		ctrlShow [2101, false ];
		ctrlShow [1401, false ];	
    };
};



