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
def detectar_notas_de_guitarra(audio_path):
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
    
    
    # Verificar se o BPM é um único valor ou um array
    if isinstance(tempo, (list, tuple, np.ndarray)):
        tempo = tempo[0]

    print(f"BPM: {tempo:.2f}")

# Exemplo de uso
audio_path = "beggin.mp3"
detectar_notas_de_guitarra(audio_path)
