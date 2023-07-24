shader_type canvas_item;

// INTERACTIVE VALUES. (WITH GDSCRIPT)
uniform vec3 color: source_color = vec3(1);
uniform float alpha: hint_range(0.0, 1.0, 0.1) = 0;

void fragment() {
	// GET THE ALPHA VALUE.
	float current_a = texture(TEXTURE, UV).a;
	// UPDATE THE COLOR VALUE.
	COLOR = mix(texture(TEXTURE, UV), vec4(color, current_a), alpha);
}
