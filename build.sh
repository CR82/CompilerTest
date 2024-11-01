cd ./CppCompilationTest
rm -rf ./build
mkdir ./build
cd ./build

# Check operating system and use appropriate cmake generator
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    cmake ..
else
    cmake -G "MinGW Makefiles" -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ ..
fi

cmake --build . -j 1
cd ..
cd ..