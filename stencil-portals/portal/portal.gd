class_name Portal
extends MeshInstance3D


var portal_layer_1 : int = 1
var portal_layer_2 : int = 2

@onready var portal_1a : PortalPlane = $Portal1A
@onready var portal_1b : PortalPlane = $Portal1B


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


func _process(_delta: float) -> void:
	print(player_side)


func update_portal_layer() -> void:
	portal_1a.update_portal_layer()
	portal_1b.update_portal_layer()


func _on_area_3d_body_entered(body):
	if body == player:
		pass


func _on_area_3d_body_exited(body):
	if body == player:
		pass
