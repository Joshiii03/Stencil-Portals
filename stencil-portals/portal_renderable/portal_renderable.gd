class_name PortalRenderable
extends MeshInstance3D

@export_flags_3d_physics var portal_layer : int
@export_file_path() var texture
@export var color : Color

@export_node_path() var portal_path
@export var overwrite_portal : bool = false
var portal

func _ready() -> void:
	if portal_path != null:
		portal = get_node(portal_path)
	set_layer()

func set_layer() -> void:
	for child in get_children():
		if child.get("collision_layer"):
			child.collision_layer = portal_layer
	var bits = portal_layer
	layers = bits
	for i in 5:
		var flag = (bits & 1) == 1
		bits = bits >> 1
		if flag:
			var stencil_shader : ShaderMaterial = ShaderMaterial.new()
			stencil_shader = ShaderMaterial.new()
			stencil_shader.shader = load("res://shader/schader_scripts/shader" + str(i+1) + ".gdshader")
			stencil_shader.render_priority = 1
			
			if portal != null:
				stencil_shader.set_shader_parameter("portal_coords", portal.global_position)
				stencil_shader.set_shader_parameter("portal_norm", portal.normal)
				stencil_shader.set_shader_parameter("switch_side", false)
				stencil_shader.set_shader_parameter("use_portal", true)
			
			stencil_shader.set_shader_parameter("color", color)
			if texture != null:
				stencil_shader.set_shader_parameter("my_texture", load(texture))
				stencil_shader.set_shader_parameter("use_texture", true)
			material_override = stencil_shader
			
			if overwrite_portal:
				var next_material : StandardMaterial3D = StandardMaterial3D.new()
				next_material.depth_draw_mode =BaseMaterial3D.DEPTH_DRAW_DISABLED
				next_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
				next_material.albedo_color = "ffffff00"
				print(name," ", i+1)
				next_material.stencil_mode = BaseMaterial3D.STENCIL_MODE_CUSTOM
				next_material.stencil_reference = i+1
				next_material.stencil_flags = 2
				stencil_shader.next_pass = next_material
				#material_override = next_material
				#material_overlay.next_pass = next_material
			
			#material_overlay = null
			#material_override = null
			#material_overlay = null
