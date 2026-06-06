class_name travellablePortal
extends Portal

var portal_layer_1 : int = 1
var portal_layer_2 : int = 2

@onready var portal_1a: Portal = $Portal1A
@onready var portal_1b: Portal = $Portal1B


func update_portal_layer() -> void:
	portal_1a.update_portal_layer()
	portal_1b.update_portal_layer()
