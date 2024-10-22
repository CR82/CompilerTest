cd ./CppCompilationTest
rm -rf ./build
mkdir ./build
cd ./build
cmake -G "MinGW Makefiles" -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ ..
cmake --build . -j 1
cd ..
cd ..
