class_name PortalPlane
extends Portal

func update_portal_layer() -> void:
	var portal_layer_mask = 1 << (portal_layer -1)
	material_override.stencil_reference = portal_layer_mask
