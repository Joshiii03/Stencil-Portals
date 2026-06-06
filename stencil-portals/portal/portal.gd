class_name Portal
extends MeshInstance3D


# Player what else is there to say.
var player : Player :
	get():
		return $"/root/NodeRegistry".player


# The Normal of the Portal plane.
var normal : Vector3 :
	get():
		return -transform.basis.z


# Returns on which side the Player is.
# Main use is to detect if the Player switched the side.
var player_side : bool = false:
	get():
		if player != null:
			var player_coords : Vector3 = player.global_position
			var  z_coord : float = normal.dot(player_coords - global_position)  #dot(player_coords - global_position, normal );
			return z_coord < 0
		return false


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
