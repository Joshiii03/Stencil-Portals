class_name TravablePortal
extends Portal

@export var portal_layer_2 : int = 2 :
	set(value):
			portal_layer_2 = value
			update_portal_layer() 

enum PortalLayers {portal_layer_1, portal_layer_2}
# The active PortalLAyer is the on being displayed the other is th one the player is inside
var active_portal_layer : PortalLayers = PortalLayers.portal_layer_1 :
	set(value):
		active_portal_layer = value
		update_portal_layer() 

@onready var portal_1a : PortalPlane = $Portal1A
@onready var portal_1b : PortalPlane = $Portal1B

# If the Player is insdie the Area3D
var player_inside : bool = false :
	set(new_value):
		if new_value:
			last_player_side = player_side
		player_inside = new_value

var last_player_side : bool = true :
	set(new_value):
		if last_player_side == null:
			last_player_side = new_value
		elif last_player_side != new_value:
			player_changed_side()
		last_player_side = new_value


func _process(_delta: float) -> void:
	#if player_inside:
	last_player_side = player_side


# Will be called when PortalLayer is changed
func update_portal_layer() -> void:
	if player_inside:
		match active_portal_layer:
			PortalLayers.portal_layer_1:
				if player_side:
					portal_1a.portal_layer = portal_layer_2
					portal_1b.portal_layer = portal_layer
				else:
					portal_1a.portal_layer = portal_layer
					portal_1b.portal_layer = portal_layer_2
			PortalLayers.portal_layer_2:
				if player_side:
					portal_1a.portal_layer = portal_layer
					portal_1b.portal_layer = portal_layer_2
				else:
					portal_1a.portal_layer = portal_layer_2
					portal_1b.portal_layer = portal_layer
	else:
		match active_portal_layer:
			PortalLayers.portal_layer_1:
				portal_1a.portal_layer = portal_layer
				portal_1b.portal_layer = portal_layer
			PortalLayers.portal_layer_2:
				portal_1a.portal_layer = portal_layer_2
				portal_1b.portal_layer = portal_layer_2
	
	portal_1a.update_portal_layer()
	portal_1b.update_portal_layer()


func _on_area_3d_body_entered(body):
	if body == player:
		player_inside = true
		update_portal_layer()


func _on_area_3d_body_exited(body):
	if body == player:
		player_inside = false
		update_portal_layer()


# Is triggered when Player changes side of portal while standing inside.
# Swaps active PortalLayer
func player_changed_side():
	if not player_inside:
		print("swap")
		get_tree().call_group("Layer_" + str(portal_layer), "change_side")
		get_tree().call_group("Layer_" + str(portal_layer_2), "change_side")
	else:
		match active_portal_layer:
			PortalLayers.portal_layer_1:
				player.change_layer(portal_layer)
				active_portal_layer = PortalLayers.portal_layer_2
				
			PortalLayers.portal_layer_2:
				player.change_layer(portal_layer_2)
				active_portal_layer = PortalLayers.portal_layer_1

func _input(event):
	if event.is_action_pressed("jump"):
		get_tree().call_group("Layer_" + str(portal_layer), "change_side")
		get_tree().call_group("Layer_" + str(portal_layer_2), "change_side")
