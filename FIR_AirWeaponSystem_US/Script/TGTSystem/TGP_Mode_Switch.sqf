_plane = vehicle player;

_mode_switch = _plane getvariable "AWS_TGP_MODE_Switch";
_TGP_CAM = _plane getvariable "AWS_TGP_CAM";

switch (_mode_switch) do
{
    case "1":
    {
		_plane setVariable ["AWS_TGP_MODE_Switch","2",true];
		_TGP_CAM setPiPEffect [1];				
    };

    case "2":
    {
		_plane setVariable ["AWS_TGP_MODE_Switch","3",true];
		_TGP_CAM setPiPEffect [2];					
    };
    case "3":
    {
		_plane setVariable ["AWS_TGP_MODE_Switch","4",true];
		_TGP_CAM setPiPEffect [7];				
    };
    case "4":
    {
		_plane setVariable ["AWS_TGP_MODE_Switch","1",true];
		_TGP_CAM setPiPEffect [0];				
		/*_TGP_CAM setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];*/
    };
};