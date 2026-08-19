// [this,true,true,true,true] call fir_fnc_aws_enablefunction;

//worked
params [["_plane",vehicle player],["_itgt",false],["_ecm",false],["_amslite",false],["_ew",false]];


_plane setVariable ["ITGT_GRIDTYPE","8D",true];
_plane setVariable ["ITGT_C_DATA",[]];

_plane setVariable ["ITGT_DATA_1",[]];
_plane setVariable ["ITGT_DATA_2",[]];
_plane setVariable ["ITGT_DATA_3",[]];
_plane setVariable ["ITGT_DATA_4",[]];
_plane setVariable ["ITGT_DATA_5",[]];

_plane setVariable ["ITGT_NEW","no"];
_plane setVariable ["ITGT_TYPE","GPS",true];
_plane setVariable ["ITGT_LSR","none"];

_plane setVariable ["ITGT_LSR_SET","no"];
_plane setVariable ["ITGT_TGT_SET","no"];

_plane setVariable ["ITGT_C_MARKER","none"];
_plane setVariable ["ITGT_MARKER_1","none"];
_plane setVariable ["ITGT_MARKER_2","none"];
_plane setVariable ["ITGT_MARKER_3","none"];
_plane setVariable ["ITGT_MARKER_4","none"];
_plane setVariable ["ITGT_MARKER_5","none"];

_plane setVariable ["ITGT_MARKER_1_SET","no"];
_plane setVariable ["ITGT_MARKER_2_SET","no"];
_plane setVariable ["ITGT_MARKER_3_SET","no"];
_plane setVariable ["ITGT_MARKER_4_SET","no"];
_plane setVariable ["ITGT_MARKER_5_SET","no"];

_plane setvariable ["Loadout_Status","no",true];

_plane setVariable ["ITGT_VT","no",true];


_plane setVariable ["AWS_MAP_STATUS","no",true];
_plane setVariable ["AWS_TGP_ZOOM_Switch","1",true];
_plane setVariable ["AWS_TGP_MODE_Switch","1",true];
_plane setVariable ["AWS_TGP_CAM","",true];

if (_itgt isEqualTo true) then
{
	_plane setVariable ["AWS_EF_ITGT","yes",true];
};

if (_ecm isEqualTo true) then
{
	_plane setVariable ["ECMJAMMER","yes",true];
};
	
if (_amslite isEqualTo true) then
{
	_plane setVariable ["AWS_EF_AMSLITE","yes",true];
};

if (_ew isEqualTo true) then
{
	_plane setVariable ["AWS_EWS",true,true];
};

if (isServer) then
{

	[[_plane, [
			"Open I-TGT system",
			"\FIR_AirWeaponSystem_US_cfg\sqs\ITGT\OPEN.sqf",
			[],
			1,
			true,
			true,
			"FIR_AWS_ACTION_ITGT",
			"_target getVariable 'AWS_EF_ITGT' == 'yes' and player in _target and isengineon _target"
		]],"addAction",true,true] call BIS_fnc_MP;	
		
		[[_plane, [
			"ECM JAMMER ON",
			"\FIR_AirWeaponSystem_US\Script\ECM\ECM_ON.sqf",
			[],
			1,
			true,
			true,
			"User2",
			"player in _target and isengineon _target and _target getvariable 'ECMJAMMER' == 'yes'"
		]],"addAction",true,true] call BIS_fnc_MP;			
		
		[[_plane, [
			"Open AMS-Lite",
			"\FIR_AirWeaponSystem_US\Script\AMS\AMS_Lite\AMS_Lite_GUI_Open.sqf",
			[],
			1,
			true,
			true,
			"User3",
			"player in _target and (speed _target < 1) and _target getVariable 'AWS_EF_AMSLITE' == 'yes'"
		]],"addAction",true,true] call BIS_fnc_MP;			
		
		[[_plane, [
				"EWS Open",
				"\FIR_AirWeaponSystem_US\Script\EW\EW_MFD_OPEN.sqf",
				[],
				1,
				true,
				true,
				"User6",
				"player in _target and isengineon _target and _target getVariable 'AWS_EWS'"
			]],"addAction",true,true] call BIS_fnc_MP;			
};
