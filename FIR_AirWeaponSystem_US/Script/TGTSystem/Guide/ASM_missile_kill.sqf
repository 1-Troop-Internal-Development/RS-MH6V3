private _ary = _this select 0;
private _object = _ary select 0;

private _mssl = attachedTo _object;
private _mssl_check = false;

if (isNull _mssl) then 
{
	hint "object is not attached to anything.";
}
else 
{
	hint format ["%1",_mssl];
	_mssl_check = true;
};

detach _object;

deleteVehicle crew _object;
deleteVehicle _object;

if (_mssl_check) then
{
	deleteVehicle _mssl;
};
