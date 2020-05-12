import build.src.python.commonLib as commonLib


print(commonLib.call_from_cpp(8.3))
print(commonLib.call_from_fortran(8.3))


print(commonLib.iseven(8))
print(commonLib.isodd(8))
