/*
	Return model-space points for the RS MH-6V3 fast rope system.

	Layout:
	0: FRIES attachment point
	1: left rope origin
	2: right rope origin
	3: left prepare interaction point
	4: right prepare interaction point
	5: left rope interaction point
	6: right rope interaction point
	7: configured flag
	8: left deploy interaction point
	9: right deploy interaction point
*/
missionNamespace getVariable [
	"RS_MH6V3_fastRopePoints",
	[
		[0.026611, 0.821605, -0.107002],
		[-1.23242, 0.794033, -0.0076561],
		[1.26709, 0.794001, -0.00635719],
		[-1.1665, 0.796253, -0.108951],
		[1.1333, 0.792804, -0.107751],
		[-1.23926, 0.791841, -0.109039],
		[1.35791, 0.775916, -0.107684],
		true,
		[-1.1665, 0.796253, -0.108951],
		[1.1333, 0.792804, -0.107751]
	]
]
