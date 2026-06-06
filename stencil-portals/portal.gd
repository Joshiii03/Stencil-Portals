class_name Portal
extends MeshInstance3D

var player : Player :
	get():
		return get_node("%Player")


@export var portal_layer : int = 1 :
	set(value):
		portal_layer = value
		update_portal_layer()


func update_portal_layer() -> void:
	var portal_flags = 1 << (portal_layer -1)
	material_override.stencil_reference = portal_flags


func _ready():
	update_portal_layer()


func _process(delta: float) -> void:
	print(player_side)

var normal : Vector3 :
	get():
		return -transform.basis.z


var player_side : bool = false:
	get():
		if player != null:
			var player_coords : Vector3 = player.global_position
			var  z_coord : float = normal.dot(player_coords - global_position)  #dot(player_coords - global_position, normal );
			return z_coord < 0
		return false
