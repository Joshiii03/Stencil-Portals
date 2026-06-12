class_name TravablePortal
extends Portal

var portal_layer_1 : int = 1
var portal_layer_2 : int = 2

enum PortalLayers {portal_layer_1, portal_layer_2}
var active_portal_layer : PortalLayers = PortalLayers.portal_layer_1

@onready var portal_1a : PortalPlane = $Portal1A
@onready var portal_1b : PortalPlane = $Portal1B

var player_inside : bool = false :
	set(new_value):
		if new_value:
			last_player_side = player_side
		player_inside = new_value

var last_player_side : bool = false :
	set(new_value):
		if last_player_side != new_value and player_inside:
			player_changed_side()
		last_player_side = new_value


func _process(_delta: float) -> void:
	if player_inside:
		last_player_side = player_side


func update_portal_layer() -> void:
	portal_1a.update_portal_layer()
	portal_1b.update_portal_layer()


func _on_area_3d_body_entered(body):
	if body == player:
		player_inside = true


func _on_area_3d_body_exited(body):
	if body == player:
		player_inside = false


func player_changed_side():
	print("Player changed side")
