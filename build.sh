cd ./CppCompilationTest
rm -rf ./build
mkdir ./build
cd ./build

# Detect operating system using uname
OS_NAME="$(uname -s)"

case "$OS_NAME" in
    Linux*)
        cmake ..
        ;;
    *)
        cmake -G "MinGW Makefiles" ..
        ;;
esac

cmake --build . -j 1
cd ..
cd ..