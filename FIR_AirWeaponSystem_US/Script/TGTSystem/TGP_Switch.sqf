_plane = vehicle player;

_zoom_switch = _plane getvariable "AWS_TGP_ZOOM_Switch";

switch (_zoom_switch) do
{
    case "1":
    {
		_plane setVariable ["AWS_TGP_ZOOM_Switch","2",true];
    };

    case "2":
    {
		_plane setVariable ["AWS_TGP_ZOOM_Switch","3",true];
    };
    case "3":
    {
		_plane setVariable ["AWS_TGP_ZOOM_Switch","1",true];
    };

};