/*AMS Lite dialog By Firewill*/
/*FOR NEW PYLON SYSTEM*/

if (not(isNil "AWS_AMS_Disable")) exitWith
{
	systemChat "AMS deactivated via AWS_AMS_Disable command.";
};

private _plane = "";
private _planetype = "";

private _yes_icon = "FIR_AirWeaponSystem_US\ui\yes_ca.paa";
private _no_icon = "FIR_AirWeaponSystem_US\ui\no_ca.paa";

private _dialogNumber = 5280;
private _checkboxnumber = 2800;

disableSerialization;
_mydisplay = findDisplay _dialogNumber;

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

private _data = lbData [1500, (lbCurSel 1500)];
private _wepdata = lbData [1501, (lbCurSel 1501)];
private _plane_ary = _plane getVariable "Pylon_Temp_Ary";
private _plane_ary_count = (count _plane_ary) - 1;
private _cb_ctrl = _mydisplay displayCtrl _checkboxnumber;	
private _checked = cbChecked _cb_ctrl;

for "_i" from 0 to _plane_ary_count do 
{
	private _ary_pick = _plane_ary select _i;
	private _ary_name = _ary_pick select 0;
	
	if (_data == _ary_name) then //for gunner
	{
		if (_checked) then
		{
			_plane_ary set [_i,[_ary_name,_wepdata,"gunner"]];
			lbSetColor [1503,(lbCurSel 1500),[0,0,1,1]];		
		}
		else //for pilot
		{
			_plane_ary set [_i,[_ary_name,_wepdata,"pilot"]];
			lbSetColor [1503,(lbCurSel 1500),[0,1,0,1]];		
		
		};	
		_plane setVariable ["Pylon_Temp_Ary",_plane_ary,true];		
		lbSetPicture [1503, (lbCurSel 1500),_yes_icon];
		lbSetTooltip [1503 ,(lbCurSel 1500), _wepdata];

		systemChat "Pylon data has been updated.";
	};
};
