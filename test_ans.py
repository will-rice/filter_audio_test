import ans
import numpy as np
from spokestack.context import SpeechContext

context = SpeechContext()
frame = np.ones(8000)
print(frame)
noise_suppression = ans.AutomaticNoiseSuppression(sample_rate=8000)

before = frame.copy()
frame_width = 8000 * 10 / 1000
noise_suppression(context, frame)

print(frame)
