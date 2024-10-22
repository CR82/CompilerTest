cd .\CppCompilationTest
rm .\build -Recurse -Force
mkdir .\build
cd .\build
cmake ..
cmake --build . -j 1
cd ..
cd ..
