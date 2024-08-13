import librosa
import json
import numpy as np

# Defina os números das teclas da guitarra
teclas = [1, 2, 3, 4]

# Carregue a música
musica = 'note-generator/teste.mp3'
audio, sr = librosa.load(musica)

# Detecta os onsets das notas
onsets = librosa.onset.onset_detect(y=audio, sr=sr, units='time')

# Calcula o BPM
if len(onsets) > 1:
    intervals = np.diff(onsets)  # Calcula os intervalos entre os onsets
    average_interval = np.mean(intervals)  # Intervalo médio
    bpm = 60 / average_interval  # Converte intervalo médio para BPM
else:
    bpm = 0  # Se não houver onsets suficientes, define BPM como 0

# Crie uma lista para armazenar as notas mapeadas
notas_mapeadas = []

for onset in onsets:
    tecla = teclas[int(onset) % len(teclas)]
    notas_mapeadas.append({
        'position': int(onset),  # Converte o tempo de onset para inteiro
        'value': tecla
    })

# Exporta o dicionário para um arquivo JSON
json_data = {
    'bpm': bpm,
    'notes': notas_mapeadas
}

with open('note-generator/guitar_notes.json', 'w') as arquivo:
    json.dump(json_data, arquivo, indent=4)

print("Notas mapeadas com sucesso!")
print("BPM calculado:", bpm)
