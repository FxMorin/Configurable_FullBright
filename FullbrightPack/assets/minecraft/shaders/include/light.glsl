#version 150

// Make sure to include `.0` after the value
#define FULLBRIGHT_GAMMA_SHIFT (40.0) // Put a number between 0.0 - 100.0 - Default vanilla value: 0.0

vec4 minecraft_sample_lightmap(sampler2D lightMap, ivec2 uv) {
	float gammaShift = FULLBRIGHT_GAMMA_SHIFT / 100.0;
	float offset = 1.0 + gammaShift;
	return texture(lightMap,clamp((uv*offset)/(256.0*(2.0-offset)),vec2(clamp(0.03125 + (gammaShift/2.0),0.03125,0.96875)),vec2(0.96875)));
}

// DO NOT MODIFY THE FILE PAST THIS LINE

#define MINECRAFT_LIGHT_POWER   (0.6)
#define MINECRAFT_AMBIENT_LIGHT (0.4)

vec4 minecraft_mix_light(vec3 lightDir0, vec3 lightDir1, vec3 normal, vec4 color) {
    lightDir0 = normalize(lightDir0);
    lightDir1 = normalize(lightDir1);
    float light0 = max(0.0, dot(lightDir0, normal));
    float light1 = max(0.0, dot(lightDir1, normal));
    float lightAccum = min(1.0, (light0 + light1) * MINECRAFT_LIGHT_POWER + MINECRAFT_AMBIENT_LIGHT);
    return vec4(color.rgb * lightAccum, color.a);
}
