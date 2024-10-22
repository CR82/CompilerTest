cd .\CppCompilationTest
rm .\build -Recurse -Force
mkdir .\build
cd .\build
cmake ..
cmake --build .
cd ..
cd ..
