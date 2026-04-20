class_name PortalRenderable
extends MeshInstance3D

@export_flags_3d_physics var portal_layer : int
@export_file_path() var texture
@export var color : Color

@export_node_path() var portal_path
@export var overwrite_portal : bool = false
var portal


var active : bool = false :
	set(new_value) :
		active = new_value
		stencil_shader.set_shader_parameter("use_portal", !active)
		if override_shader != null:
			if !active:
				override_shader.stencil_flags = 0
			else:
				override_shader.stencil_flags = BaseMaterial3D.STENCIL_FLAG_WRITE


func _ready() -> void:
	if portal_path != null:
		portal = get_node(portal_path)
	set_layer()
	active = false

var stencil_shader : ShaderMaterial
var override_shader : StandardMaterial3D

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
			add_to_group("Layer_" + str(i +1))
			
			stencil_shader = ShaderMaterial.new()
			stencil_shader.shader = load("res://shader/schader_scripts/shader" + str(i+1) + ".gdshader")
			stencil_shader.render_priority = 2
			
			if portal != null:
				stencil_shader.set_shader_parameter("portal_coords", portal.global_position)
				stencil_shader.set_shader_parameter("portal_norm", portal.normal)
				stencil_shader.set_shader_parameter("switch_side", false)
				stencil_shader.set_shader_parameter("use_portal", true)
			
			stencil_shader.set_shader_parameter("color", color)
			if texture != null:
				stencil_shader.set_shader_parameter("my_texture", load(texture))
				stencil_shader.set_shader_parameter("use_texture", true)
			
			
			if overwrite_portal:
				override_shader = StandardMaterial3D.new()
				override_shader.depth_draw_mode =BaseMaterial3D.DEPTH_DRAW_DISABLED
				override_shader.transparency =BaseMaterial3D.TRANSPARENCY_ALPHA
				override_shader.albedo_color = "ffffff00"
				override_shader.stencil_mode = BaseMaterial3D.STENCIL_MODE_CUSTOM
				override_shader.stencil_reference = i+1
				override_shader.stencil_flags = 0# BaseMaterial3D.STENCIL_FLAG_WRITE
				
				material_override = override_shader
				override_shader.next_pass = stencil_shader
			else:
				material_override = stencil_shader
