
private ["_ammoname","_weapon","_obj","_array","_missobj","_projectile"];

_obj = _this select 0;


// [_obj, [
	// "Download the Mission Planning SW to PDU",
	// "\FIR_AirWeaponSystem_US\Script\function\AWS_PDU_Install.sqf",
	// [],
	// 1,
	// true,
	// true,
	// "",
	// "true"
// ]] remoteExec ["addAction", _obj, true];

[[_obj, ["Download the Mission Planning SW to PDU","\FIR_AirWeaponSystem_US\Script\function\AWS_PDU_Install.sqf",[],1,true,true,"","true"]],"addAction",true,true] call BIS_fnc_MP;