/*I-TGT 2.0 Designate  location function by Firewill
only adding target location.
*/

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

if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat localize "str_FIR_ITGT_AIRCRAFT_WARN";};

disableSerialization;
_mydisplay = findDisplay 5581;

_lb_pylon_ctrl = (findDisplay 5581) displayCtrl 1500;
_lb_tgt_ctrl = (findDisplay 5581) displayCtrl 1501;
_list_pic = (findDisplay 5581) displayCtrl 1202;
_grid_edit = (findDisplay 5581) displayCtrl 1400;
_map = (findDisplay 5581) displayCtrl 3620;

_lb_pylon_ctrl ctrlShow false;
_lb_tgt_ctrl ctrlShow false;
_list_pic ctrlShow false;
_grid_edit ctrlShow true;
_map ctrlShow true;

_text_pylon_idx = (findDisplay 5581) displayCtrl 1001;
_text_pylon_weap = (findDisplay 5581) displayCtrl 1002;
_text_mode = (findDisplay 5581) displayCtrl 1003;
_mode_combo = (findDisplay 5581) displayCtrl 2100;
_text_prior = (findDisplay 5581) displayCtrl 1004;
_edit_priority = (findDisplay 5581) displayCtrl 1401;
_btn_edit_apply = (findDisplay 5581) displayCtrl 1614;
_priority_check = (findDisplay 5581) displayCtrl 2800;

_text_pylon_idx ctrlShow false;
_text_pylon_weap ctrlShow false;
_text_mode ctrlShow false;
_mode_combo ctrlShow false;
_text_prior ctrlShow false;
_edit_priority ctrlShow false;
_btn_edit_apply ctrlShow false;
_priority_check ctrlShow false;

_btn_edit_apply ctrlEnable false;
_mode_combo ctrlEnable false;
_edit_priority ctrlEnable false;
_priority_check ctrlEnable false;
