
_plane = _this select 0;

_tgt_array = _plane getVariable "AWS_ITGT_GPS_TGTLIST";
_tgt_array_copy = _tgt_array;

while {alive _plane} do
{
	sleep 3;
};

for "_i" from 0 to (count _tgt_array_copy)-1 do
{
	_mkr_id = ((_tgt_array_copy select _i)select 3);
	_mkr_local = ((_tgt_array_copy select _i)select 4); 

	if (_mkr_local isEqualTo "global") then
	{
		deleteMarker _mkr_id;	
	}
	else
	{
		deleteMarkerLocal _mkr_id;	
	};

	sleep 0.01;
};
