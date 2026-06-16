//LAYER 2
shader_type spatial;
render_mode world_vertex_coords;
stencil_mode read, 2 ,compare_equal;
render_mode depth_draw_always;

uniform bool switch_side = true;
uniform vec3 portal_coords;
uniform vec3 portal_norm;
uniform bool use_portal = false;

uniform vec3 color;
uniform sampler2D my_texture;
uniform bool use_texture = false;
varying vec3 v_vertex;

uniform bool disable_lighting = false;

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
		
		if (f < 0.5)
			discard;
		ALPHA *= f;
	}
	
	/*
	if (use_texture)
	{
		vec4 tex = texture(my_texture, UV);
		ALBEDO = tex.rgb;
	}
	else
		ALBEDO = color;
	*/
	
	vec3 final_color;
	if (use_texture)
	{
	    vec4 tex = texture(my_texture, UV);
	    final_color = tex.rgb;
	}
	else
	{
	    final_color = color;
	}

	if (disable_lighting)
	{
	    ALBEDO = vec3(0.0);
	    EMISSION = final_color;
	}
	else
	{
	    ALBEDO = final_color;
	}
}