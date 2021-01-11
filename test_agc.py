import agc
import numpy as np
from spokestack.context import SpeechContext


def rms(y):
    return np.sqrt(np.mean(y ** 2))


def get_frame(sample_rate, frequency, amplitude):
    x = 2 * np.pi * np.arange(sample_rate) / sample_rate
    return np.sin(frequency * x) * amplitude


context = SpeechContext()

fs = 8000
f = 2000
frame_width = fs * 10 // 1000
frame = get_frame(fs, f, 0.08)
frame = frame[:frame_width]

gain_control = agc.AutomaticGainControl(
    sample_rate=fs,
    frame_width=10,
    target_level_dbfs=9,
    compression_gain_db=15,
)

level = rms(frame)
print(level)
gain_control(context, frame)
print(rms(frame))
assert rms(frame) > level
