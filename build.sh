cd ./CppCompilationTest
rm -rf ./build
mkdir ./build

# Detect operating system using uname
OS_NAME="$(uname -s)"

case "$OS_NAME" in
    Linux*)
        cmake -B build
        ;;
    *)
        cmake -G "MinGW Makefiles" -B build
        ;;
esac

time cmake --build build -j1 

cd ..