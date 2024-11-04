Set-Location .\CppCompilationTest
if (Test-Path .\build) {
  Remove-Item .\build -Recurse -Force
}

mkdir .\build

cmake -B build

Set-Location ..