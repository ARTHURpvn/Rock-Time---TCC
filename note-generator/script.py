from pydub import AudioSegment
import pytuning
import numpy as np
import json

def is_guitar_note(pitch, guitar_note_range=(80, 1200)):
    # Verifica se a nota está dentro da faixa típica de frequências da guitarra
    return guitar_note_range[0] <= pitch <= guitar_note_range[1]

def audio_to_numpy(audio_file):
    # Carregar o arquivo de áudio
    audio = AudioSegment.from_file(audio_file)
    
    # Converter para mono e obter os dados em formato numpy
    audio = audio.set_channels(1)
    samples = np.array(audio.get_array_of_samples(), dtype=np.float32)
    
    # Normalizar os samples
    samples /= np.max(np.abs(samples))
    
    return samples, audio.frame_rate

def generate_guitar_notes(audio_file, json_file, threshold=0.02, max_notes=0):
    # Converter áudio para numpy array
    y, sr = audio_to_numpy(audio_file)
    
    # Usar pytuning para detectar notas e frequências
    pitch, magnitude = pytuning.detect_pitch(y, sr)

    # Filtragem e geração dos eventos
    events = []
    for i in range(len(pitch)):
        if magnitude[i] > threshold:
            if is_guitar_note(pitch[i]):
                value = np.random.randint(1, 4)  # Valor aleatório entre 1 e 3
                position = round(i / sr)  # Tempo em segundos, mantendo 2 casas decimais
                events.append({"position": position, "value": value})

    # Ordenar os eventos por posição e limitar o número de notas
    events.sort(key=lambda x: x['position'])
    
    if len(events) > max_notes and max_notes > 0:
        # Selecionar notas igualmente espaçadas
        selected_events = []
        step = len(events) // max_notes
        for i in range(0, len(events), step):
            selected_events.append(events[i])
        events = selected_events

    # Salvar eventos em um arquivo JSON
    with open(json_file, 'w') as f:
        json.dump(events, f, indent=4)

    print(f"Notas exportadas para {json_file}")

# Exemplo de uso
generate_guitar_notes('note-generator/snd_helena.mp3', 'note-generator/guitar_notes.json')
