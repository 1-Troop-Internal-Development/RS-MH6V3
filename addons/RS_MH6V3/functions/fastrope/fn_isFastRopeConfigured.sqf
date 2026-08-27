private _points = call RS_MH6V3_fnc_getFastRopePoints;

_points isEqualType []
&& {count _points >= 8}
&& {(_points # 7) isEqualTo true}
