//Command Guidance system based on nuxil's Tvs script. all credit goes to nuxil who created the original Tvs script.

private ["_missile","_conx,","_cony","_dir", "_startanglen","_startanglee","_startangles","_startanglew"];
	
_missile = _this;
if (isNull _missile) exitwith {};
_conx = 0.5 - 0.018;
_cony =  0.5 - 0.018;
while {((dialog) && (alive _missile))} do
{
	_dir = (getdir _missile);
	_startanglen = 270 - _dir;
	_startanglee = 360 - _dir;
	_startangles = 90 - _dir;
	_startanglew = 180 - _dir;

	// North
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8569) ctrlSetPosition [_conx + 0.2 * cos(_startanglen * (4 * atan(1) / 180)), _cony + 0.2 * sin(_startanglen * (4 * atan(1) / 180))];
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8569) ctrlCommit 0;
	// East
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8570) ctrlSetPosition [_conx + 0.2 * cos(_startanglee * (4 * atan(1) / 180)), _cony + 0.2 * sin(_startanglee * (4 * atan(1) / 180))];
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8570) ctrlCommit 0;
	// South
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8571) ctrlSetPosition [_conx + 0.2 * cos(_startangles * (4 * atan(1) / 180)), _cony + 0.2 * sin(_startangles * (4 * atan(1) / 180))];
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8571) ctrlCommit 0;
	// West
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8572) ctrlSetPosition [_conx + 0.2 * cos(_startanglew * (4 * atan(1) / 180)), _cony + 0.2 * sin(_startanglew * (4 * atan(1) / 180))];
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8572) ctrlCommit 0;
	sleep 0.01;
};

