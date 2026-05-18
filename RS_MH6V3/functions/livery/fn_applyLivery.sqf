params [["_vehicle", objNull], ["_texture", ""], ["_name", "Livery"], ["_caller", objNull]];

if (!isServer) exitWith {
	[_vehicle, _texture, _name, _caller] remoteExec ["RS_MH6V3_fnc_applyLivery", 2];
};

if (isNull _vehicle || {!alive _vehicle}) exitWith {};
if !(typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"]) exitWith {};
if (_texture == "") exitWith {};

_vehicle setObjectTextureGlobal [0, _texture];
_vehicle setVariable ["RS_MH6V3_liveryTexture", _texture, true];

private _message = format ["RS MH-6V3: applied %1 livery.", _name];
private _recipients = [driver _vehicle, gunner _vehicle] select {
	!isNull _x && {isPlayer _x}
};

{
	if (hasInterface && {player == _x}) then {
		systemChat _message;
	} else {
		[_message] remoteExecCall ["systemChat", owner _x];
	};
} forEach (_recipients arrayIntersect _recipients);
