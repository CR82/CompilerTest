# Define the project directory
$projectName = "CppCompilationTest"
$projectDir = Join-Path -Path (Get-Location) -ChildPath $projectName

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
#pragma once

#include <vector>
#include <algorithm>
#include <cmath>
#include <string>

namespace Module$fileIndex {

    class HeavyClass$fileIndex {
    public:
        HeavyClass$fileIndex() {
            for(int i = 0; i < 1000; ++i) {
                data.push_back(std::sqrt(i * i + double(i)));
            }
        }

        double computeSum() const {
            double sum = 0;
            for(auto val : data) {
                sum += val;
            }
            return sum;
        }

    private:
        std::vector<double> data;
    };

    double process() {
        HeavyClass$fileIndex hc;
        return hc.computeSum();
    }

} // namespace Module$fileIndex

"@
}

# Generate 100 cpp and h files
for ($i = 1; $i -le 100; $i++) {
    $headerContent = GenerateHeaderCode $i
    
    $headerPath = Join-Path -Path $srcDir -ChildPath "file$i.h"

    Set-Content -Path $headerPath -Value $headerContent
}

# Generate main.cpp
$mainCppContent = @'
#include <iostream>
#include <vector>
#include <string>

'@

for ($i = 1; $i -le 100; $i++) {
    $mainCppContent += "`#include `"file$i.h`"`n"
}

$mainCppContent += @'

int main() {
    double total = 0.0;
    for (int i = 1; i <= 100; ++i) {
        switch (i) {
'@

for ($i = 1; $i -le 100; $i++) {
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
