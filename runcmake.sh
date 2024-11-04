export CC=gcc
export CXX=g++

cd ./CppCompilationTest
rm -rf ./build
mkdir ./build

# Detect operating system using uname
OS_NAME="$(uname -s)"

echo "Operating system: $OS_NAME"

case "$OS_NAME" in
    MINGW64*)
        cmake -G "MinGW Makefiles" -B build
        ;;
    *)
        cmake -B build
        ;;
esac

cd ..