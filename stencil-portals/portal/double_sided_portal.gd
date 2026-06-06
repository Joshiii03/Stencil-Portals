class_name travellablePortal
extends Portal

var portal_layer_1 : int = 1
var portal_layer_2 : int = 2

@onready var portal_1a: Portal = $Portal1A
@onready var portal_1b: Portal = $Portal1B


func update_portal_layer() -> void:
	portal_1a.update_portal_layer()
	portal_1b.update_portal_layer()

func _process(_delta: float) -> void:
	print(player_side)


func _on_area_3d_body_entered(body):
	if body == player:
		pass


func _on_area_3d_body_exited(body):
	if body == player:
		pass
