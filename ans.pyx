"""
This module contains the AutomaticNoiseSuppression class implemented in Cython
"""
# disutils: sources = filter_audio/ns/noise_suppression_x.c
# disutils: include_dirs = filter_audio/ns/include/
cimport cans


cdef extern from "Python.h":
    char *PyBytes_AsString(object)

cdef class AutomaticNoiseSuppression:
    cdef cans.NsxHandle* _ans
    cdef int _sample_rate
    cdef int _policy
    def __cinit__(self):
        self._ans = NULL
        result = cans.WebRtcNsx_Create(&self._ans)
        if result == 0:
            result = cans.WebRtcNsx_Init(self._ans, self._sample_rate)

            if result == 0:
                result = cans.WebRtcNsx_set_policy(self._ans, self._policy)

    def __dealloc__(self):
        cans.WebRtcNsx_Free(self._ans)

    def __init__(self, sample_rate=16000, policy=0, **kwargs):

        self._sample_rate = sample_rate
        self._policy = policy

    def __call__(self, context, frame):
        frame = frame.tobytes()
        self._process(frame)

    cdef _process(self, frame):
        result = cans.WebRtcNsx_Process(self._ans,
                                        <short*> PyBytes_AsString(frame),
                                        NULL,
                                        <short*> PyBytes_AsString(frame),
                                        NULL)

    def close(self):
        self.__dealloc__()

    def reset(self):
        pass
