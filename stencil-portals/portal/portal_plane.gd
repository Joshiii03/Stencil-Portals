class_name PortalPlane
extends MeshInstance3D


# The Normal of the Portal plane.
var normal : Vector3 :
	get():
		return -transform.basis.z


# the layer as int
@export var portal_layer : int = 1 :
	set(value):
		portal_layer = value
		update_portal_layer()


func _ready():
	update_portal_layer()


func update_portal_layer() -> void:
	var portal_flags = 1 << (portal_layer -1)
	material_override.stencil_reference = portal_flags
