//LAYER 3
shader_type spatial;
render_mode world_vertex_coords;
stencil_mode read, 3 ,compare_equal;
render_mode depth_draw_always;

uniform bool switch_side = true;
uniform vec3 portal_coords;
uniform vec3 portal_norm;
uniform bool use_portal = false;

uniform vec3 color;
uniform sampler2D my_texture;
uniform bool use_texture = false;
varying vec3 v_vertex;

void vertex() {
	v_vertex = VERTEX;
}

void fragment() {
	
	if(use_portal)
	{
		float f;
		float  z_coord = dot(v_vertex - portal_coords, portal_norm );
		if (switch_side)
			f = step(z_coord, 0.0);
		else
			f = step(0.0 ,z_coord);
		ALPHA *= f;
	}
	
	if (use_texture)
	{
		vec4 tex = texture(my_texture, UV);
		ALBEDO = tex.rgb;
	}
	else
		ALBEDO = color;
}