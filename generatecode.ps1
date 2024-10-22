# Define the project directory
$projectName = "CppCompilationTest"
$projectDir = Join-Path -Path (Get-Location) -ChildPath $projectName

$sourceFileCount = 50

# Create project directory
if (-Not (Test-Path $projectDir)) {
    New-Item -ItemType Directory -Path $projectDir | Out-Null
}

# Create src directory
$srcDir = Join-Path -Path $projectDir -ChildPath "src"
if (-Not (Test-Path $srcDir)) {
    New-Item -ItemType Directory -Path $srcDir | Out-Null
}

# Function to generate complex C++ code
function GenerateHeaderCode($fileIndex) {
    @"
#ifndef FILE${fileIndex}_H
#define FILE${fileIndex}_H

#include <vector>
#include <algorithm>
#include <cmath>
#include <string>

namespace Module$fileIndex {

    class MyClass$fileIndex {
    public:
        MyClass$fileIndex() {
            for(int i = 0; i < 1000; ++i) {
                data.push_back(std::sqrt(i * i + double(i)));
            }
        }

        double computeSum() const;

    private:
        std::vector<double> data;
    };

    inline double process() {
        MyClass$fileIndex myClass;
        return myClass.computeSum();
    }

} // namespace Module$fileIndex

#endif // FILE$fileIndex_H

"@
}

function GenerateCppCode($fileIndex) {
    @"
#include "file$fileIndex.h"

namespace Module$fileIndex {

    double MyClass$fileIndex::computeSum() const {
            double sum = 0;
            for(auto val : data) {
                sum += val;
            }
            return sum;
        }

} // namespace Module$fileIndex

"@
}

for ($i = 1; $i -le $sourceFileCount; $i++) {
    $headerContent = GenerateHeaderCode $i
    
    $headerPath = Join-Path -Path $srcDir -ChildPath "file$i.h"

    Set-Content -Path $headerPath -Value $headerContent

    $cppContent = GenerateCppCode $i

    $cppPath = Join-Path -Path $srcDir -ChildPath "file$i.cpp"

    Set-Content -Path $cppPath -Value $cppContent
}

# Generate main.cpp
$mainCppContent = @'
#include <iostream>
#include <vector>
#include <string>

'@

for ($i = 1; $i -le $sourceFileCount; $i++) {
    $mainCppContent += "`#include `"file$i.h`"`n"
}

$mainCppContent += @"

int main() {
    double total = 0.0;
    for (int i = 1; i <= $sourceFileCount; ++i) {
        switch (i) {
"@

for ($i = 1; $i -le $sourceFileCount; $i++) {
    $mainCppContent += "            case ${i}: {
                total += Module$i::process();
                break;
            }
"
}

$mainCppContent += @'
            default:
                break;
        }
    }
    std::cout << "Total Sum: " << total << std::endl;
    return 0;
}
'@

$mainCppPath = Join-Path -Path $srcDir -ChildPath "main.cpp"
Set-Content -Path $mainCppPath -Value $mainCppContent

# Generate CMakeLists.txt
$cmakeContent = @"
cmake_minimum_required(VERSION 3.10)
project($projectName)

# Set GCC as the C compiler
set(CMAKE_C_COMPILER "gcc")

# Set G++ as the C++ compiler
set(CMAKE_CXX_COMPILER "g++")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

file(GLOB SOURCES "src/*.cpp")

add_executable($projectName `${SOURCES})
"@

$cmakePath = Join-Path -Path $projectDir -ChildPath "CMakeLists.txt"
Set-Content -Path $cmakePath -Value $cmakeContent

Write-Output "C++ project '$projectName' has been generated at $projectDir."
Write-Output "To build the project, navigate to the project directory and run the following commands:"
Write-Output "  mkdir build"
Write-Output "  cd build"
Write-Output "  cmake .."
Write-Output "  cmake --build ."
