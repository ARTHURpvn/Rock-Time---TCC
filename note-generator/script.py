import librosa
import json
import numpy as np
from scipy.signal import butter, lfilter

# Função para criar um filtro passa-banda
def butter_bandpass(lowcut, highcut, fs, order=5):
    nyquist = 0.5 * fs
    low = lowcut / nyquist
    high = highcut / nyquist
    b, a = butter(order, [low, high], btype='band')
    return b, a

# Aplicar o filtro passa-banda
def bandpass_filter(data, lowcut, highcut, fs, order=5):
    b, a = butter_bandpass(lowcut, highcut, fs, order=order)
    y = lfilter(b, a, data)
    return y

# Detecção de notas de guitarra
def detectar_notas_de_guitarra(audio_path, output_json):
    # Carregar o arquivo de áudio
    y, sr = librosa.load(audio_path)
    
    # Aplicar o filtro passa-banda para isolar as frequências da guitarra
    lowcut = 80.0  # Limite inferior de frequência para guitarra
    highcut = 1200.0  # Limite superior de frequência para guitarra
    y_filtered = bandpass_filter(y, lowcut, highcut, sr)
    
    # Detecção de batidas/picos nas frequências filtradas
    tempo, beat_frames = librosa.beat.beat_track(y=y_filtered, sr=sr)
    
    # Converter os frames das batidas para tempos (em segundos)
    beat_times = librosa.frames_to_time(beat_frames, sr=sr)
    
    # Criar uma lista para armazenar as notas de guitarra detectadas
    notas_guitarra = [{"time": int(beat_time), "value": 1} for i, beat_time in enumerate(beat_times)]
    
    # Verificar se o BPM é um único valor ou um array
    if isinstance(tempo, (list, tuple, np.ndarray)):
        tempo = tempo[0]  # Pega o primeiro valor, ou você pode decidir uma forma de lidar com múltiplos BPMs

    # Exportar para um arquivo JSON
    with open(output_json, "w") as f:
        json.dump(notas_guitarra, f, indent=4)
    
    print(f"BPM: {tempo:.2f}")
    print(f"Dados exportados para {output_json}")

# Exemplo de uso
audio_path = "teste.mp3"  # Substitua pelo caminho da sua música
output_json = "guitar_notes.json"
detectar_notas_de_guitarra(audio_path, output_json)
