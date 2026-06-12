class_name Portal
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


# Returns on which side the Player is.
# Main use is to detect if the Player switched the side.
var player_side : bool = false:
	get():
		if player != null:
			var player_coords : Vector3 = player.global_position
			var  z_coord : float = normal.dot(player_coords - global_position)  #dot(player_coords - global_position, normal );
			return z_coord < 0
		return false


# Player what else is there to say.
var player : Player :
	get():
		return $"/root/NodeRegistry".player


func _ready():
	update_portal_layer()


func update_portal_layer() -> void:
	pass
