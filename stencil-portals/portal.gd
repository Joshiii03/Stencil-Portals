extends MeshInstance3D

var normal : Vector3 :
	get():
		return -transform.basis.z
