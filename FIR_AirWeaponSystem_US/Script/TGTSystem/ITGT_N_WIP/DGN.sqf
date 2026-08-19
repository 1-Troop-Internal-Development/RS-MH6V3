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

if (ctrlShown ((findDisplay 5581) displayCtrl 1202)) exitWith {systemChat localize "str_FIR_ITGT_NOT_MAP"};


targetset = false;
systemChat localize "str_FIR_ITGT_DGN_RUNNING";
onMapSingleClick "tgtpos = _pos;targetset = true"; 

waitUntil {targetset}; 

systemChat localize "str_FIR_ITGT_DGN_CONFIRMED";
private _index = _plane getVariable ["AWS_ITGT_GPS_TGTLIST_INDEX",0];
private _tgt_list = _plane getVariable "AWS_ITGT_GPS_TGTLIST";
// element structure [index,tgtID,tgtpos,markerID,haslock];

private _tgt_id = format ["TGT_%1_%2",_index,(name player)];
private _marker_id = format ["MKR_%1_%2",_index,(name player)];

private _default_marker = createMarkerLocal [_marker_id, [0,0]];
_default_marker setMarkerColorLocal "ColorBlue";
_default_marker setMarkerShapeLocal "ICON";
_default_marker setMarkerSizeLocal [0.8,0.8];
_default_marker setMarkerTypeLocal "mil_triangle";
_default_marker setMarkerTextLocal _tgt_id;
_default_marker setMarkerAlphaLocal 1;
_default_marker setMarkerPosLocal tgtpos;	

//tgt element [index.id,pos,mkr_id,locality]
private _element = [_index,_tgt_id,tgtpos,_marker_id,"local"];
_tgt_list pushBack _element;	
_index = _index + 1;

_plane setVariable ["AWS_ITGT_GPS_TGTLIST",_tgt_list,true];
_plane setVariable ["AWS_ITGT_GPS_TGTLIST_INDEX",_index,true];
	
onMapSingleClick "";
targetset = false;

systemChat format [localize "str_FIR_ITGT_DGN_UPDATED",_tgt_id];