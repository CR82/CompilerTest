cd .\CppCompilationTest
if (Test-Path .\build) {
  rm .\build -Recurse -Force
}

mkdir .\build

cmake -B build

cd ..