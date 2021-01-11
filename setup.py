from setuptools import Extension, setup
from Cython.Build import cythonize
import numpy

setup(
    ext_modules=cythonize(
        [
            Extension("agc", ["agc.pyx"], libraries=["filteraudio"]),
            Extension("ans", ["ans.pyx"], libraries=["filteraudio"]),
        ],
    ),
    include_dirs=[numpy.get_include()],
)
