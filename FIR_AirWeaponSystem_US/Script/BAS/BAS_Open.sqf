params [["_computer",objNull],["_actor",objNull]];

_handle= CreateDialog "FIR_BAS_Dialog";
disableSerialization;

private _slideshow_list = "true" configClasses (getMissionConfig "CfgAWS_BAS_Slideshow"); 
private _slideshow_array = _slideshow_list apply {configName _x};
private _slideshow_array_count = (count _slideshow_array)-1;


private _computers = missionNamespace getVariable "AWS_BAS_COMP_LIST";
private _screens = missionNamespace getVariable "AWS_BAS_SCREEN_LIST";

private _comp_count = (count _computers) - 1;
private _screen_count = (count _screens) - 1;
private _select_comp = "";

for "_i" from 0 to _slideshow_array_count do
{
	private _select_slideshow = _slideshow_array select _i;	
	private _slideshow_data = [["CfgAWS_BAS_Slideshow",_select_slideshow],configfile] call bis_fnc_loadclass;
	private _slideshow_name = gettext (_slideshow_data >> "name");
	private _slideshow_num = getNumber (_slideshow_data >> "count");
	
	//private _slideshow_slide = getArray (_slideshow_data >> "slides");
	
	lbAdd [1502,_slideshow_name];
	lbSetData [1502,_i,_select_slideshow];
	lbSetValue [1502,_i,_slideshow_num];
}; 

for "_i" from 0 to _comp_count do
{
	_select_comp = _computers select _i;	
	private _comp_name = typeOf _select_comp;
	private _comp_id = _select_comp getVariable "AWS_BAS_COMP_ID";
	
	
	lbAdd [1500,_comp_name];
	lbSetValue [1500,_i,_comp_id];
}; 

for "_i" from 0 to _screen_count do
{
	private _select_screen = _screens select _i;	
	private _screen_id = _select_screen getVariable "AWS_BAS_SCREEN_ID";
	
	
	lbAdd [1501,str(_select_screen)];
	lbSetValue [1501,_i,_screen_id];
}; 

