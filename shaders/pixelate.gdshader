shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

uniform float pixel_size : hint_range(0.001, 0.03, 0.001) = 0.008;

void fragment() {
	vec2 uv = SCREEN_UV;
	uv -= mod(uv, pixel_size);

	COLOR.rgb = textureLod(screen_texture, uv, 0.0).rgb;
}
