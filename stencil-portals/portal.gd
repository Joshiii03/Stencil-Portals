extends MeshInstance3D

@export var portal_layer : int = 1

func update_portal_layer() -> void:
	var portal_flags = 1 << (portal_layer -1)
	material_override.stencil_reference = portal_flags

func _ready():
	update_portal_layer()

var normal : Vector3 :
	get():
		return -transform.basis.z


func _on_area_3d_body_entered(body):
	body.change_layer(portal_layer)
