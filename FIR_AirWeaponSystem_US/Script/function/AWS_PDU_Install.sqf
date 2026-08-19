private ["_check","_installer"];

_installer = player;

_check = _installer getVariable ["PDU_Check","no"];


if (_check == "yes") then
{

}
else
{
	[_installer, [
		"Open PDU",
		"\FIR_AirWeaponSystem_US\Script\TGTSystem\PDU\PDU_Open.sqf",
		[],
		1,
		true,
		true,
		"",
		"""FIR_PDU"" in assignedItems _this"
	]] remoteExec ["addAction", _installer, true];



	if (_installer == player) then
	{
		player setVariable ["PDU_Check","yes",true];

		player setVariable ["ITGT_GRIDTYPE","8D",true];
		player setVariable ["ITGT_C_DATA",[]];

		player setVariable ["ITGT_DATA_1",[]];
		player setVariable ["ITGT_DATA_2",[]];
		player setVariable ["ITGT_DATA_3",[]];
		player setVariable ["ITGT_DATA_4",[]];
		player setVariable ["ITGT_DATA_5",[]];

		player setVariable ["ITGT_NEW","no"];
		player setVariable ["ITGT_TYPE","GPS",true];

		player setVariable ["ITGT_TGT_SET","no"];

		player setVariable ["ITGT_C_MARKER","none"];
		player setVariable ["ITGT_MARKER_1","none"];
		player setVariable ["ITGT_MARKER_2","none"];
		player setVariable ["ITGT_MARKER_3","none"];
		player setVariable ["ITGT_MARKER_4","none"];
		player setVariable ["ITGT_MARKER_5","none"];

		player setVariable ["ITGT_MARKER_1_SET","no"];
		player setVariable ["ITGT_MARKER_2_SET","no"];
		player setVariable ["ITGT_MARKER_3_SET","no"];
		player setVariable ["ITGT_MARKER_4_SET","no"];
		player setVariable ["ITGT_MARKER_5_SET","no"];	
	};

};

