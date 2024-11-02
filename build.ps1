cd .\CppCompilationTest
if (Test-Path .\build) {
  rm .\build -Recurse -Force
}

mkdir .\build

cmake -B build

cmake --build build -j 1

cd ..
