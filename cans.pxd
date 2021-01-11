
cdef extern from "filter_audio/ns/include/noise_suppression_x.h":

    ctypedef struct NsxHandle:
        pass

    bint WebRtcNsx_Create(NsxHandle** NS_inst)
    bint WebRtcNsx_Free(NsxHandle*NS_inst)
    bint WebRtcNsx_Init(NsxHandle*NS_inst, int fs)
    bint WebRtcNsx_set_policy(NsxHandle* Ns_inst, int mode)
    bint WebRtcNsx_Process(NsxHandle* NS_inst,
                           short* speechFrame,
                           short* speechFrameHB,
                           short* outframe,
                           short* outFrameHB)




