cd .\CppCompilationTest
if (Test-Path .\build) {
  rm .\build -Recurse -Force
}
mkdir .\build
cd .\build
cmake ..
cmake --build . -j 1
cd ..
cd ..
