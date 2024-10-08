shader_type canvas_item;

uniform float time : hint_range(0.0, 10.0); // Tempo para controlar os efeitos psicodélicos
uniform vec2 box_position; // Posição da caixa
uniform float fade_out : hint_range(0.0, 1.0); // Para o fade out no final

// Função para criar faíscas azuis
float spark_effect(vec2 uv) {
    float angle = mod(time * 10.0 + length(uv - box_position) * 5.0, 6.28);
    float spark = abs(sin(angle * 5.0)) * smoothstep(0.1, 0.2, length(uv - box_position));
    return spark;
}

// Função para o efeito psicodélico
vec3 psychedelic_effect(vec2 uv) {
    float wave = sin(uv.y * 10.0 + time * 5.0) * cos(uv.x * 10.0 + time * 5.0);
    return vec3(wave, sin(wave + time * 2.0), cos(wave + time * 3.0));
}

void fragment() {
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE.xy; // Coordenadas normalizadas da tela (0 a 1)

    // Adiciona as faíscas azuis
    float sparks = spark_effect(uv);
    vec3 blue_sparks = vec3(0.0, 0.5, 1.0) * sparks; // Faíscas em azul

    // Adiciona o efeito psicodélico na tela
    vec3 psychedelic_color = psychedelic_effect(uv);

    // Mistura o efeito de faíscas e o efeito psicodélico
    vec3 final_color = mix(psychedelic_color, blue_sparks, 0.5);

    // Fade out gradual até preto
    final_color = mix(final_color, vec3(0.0), fade_out);

    // Saída da cor final
    COLOR = vec4(final_color, 1.0);
}
