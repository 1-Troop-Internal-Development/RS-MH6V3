/* script for Snakeye
   Made by Firewill */

/* get the cluster bomb */
_snakeye = _this select 0;

_snakeyespeed = velocity _snakeye;
_snakeyedir = direction _snakeye;
_speed = 50;


_snakeye setVelocity 
[
	(_snakeyespeed select 0) - (sin _snakeyedir * _speed), 
	(_snakeyespeed select 1) - (cos _snakeyedir * _speed), 
	(_snakeyespeed select 2)
];