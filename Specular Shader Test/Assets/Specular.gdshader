shader_type canvas_item;

uniform vec4 intensity: hint_color = vec4(1000.0,1000.0,1000.0,1000.0);

void light()
{
	if (UV.y > 0.5) {
		vec4 specular_map = texture(TEXTURE,vec2(UV.x,1.0-UV.y));
		float specularity = (((specular_map.r + specular_map.g + specular_map.b) /3.0) /255.0);
		vec4 tex = texture(TEXTURE,UV);
		vec4 color = mix(tex,LIGHT,specularity);
		float alpha = LIGHT.a;
		vec3 reflection = mix(color.rgb,intensity.rgb,specularity);
		LIGHT.rgb = reflection.rgb;
	}
}

void fragment()
{
	if (UV.y < 0.5) {
		COLOR.a = 0.0;
	}
	if (UV.y > 0.5) {
		vec4 tex = texture(TEXTURE,UV);
		COLOR.rgb = tex.rgb;
		COLOR.a = tex.a;
	}
}
