function GenerateCppCode($fileIndex, $totalFiles, $sourceFunctionCount) {
  $otherIncludes = @()
  $otherModules = @()
  $internalSums = @()
  $internalSumsDefinitions = @()
  
  # Collect includes for other module headers and their computeSum calls
  for ($i = 1; $i -le $totalFiles; $i++) {
    if ($i -ne $fileIndex) {
      $otherIncludes += "#include `"file$i.h`""
      $otherModules += "Module$i::MyClass$i other$i;"
      $otherModules += "sum += other$i.computeSum();"
    }
  }

  for ($i = 0; $i -lt $sourceFunctionCount; $i++) {
    $internalSums += "sum += computeSum$i();"
  }

  for ($i = 0; $i -lt $sourceFunctionCount; $i++) {
    $internalSumsDefinitions += "double MyClass$fileIndex::computeSum$i() const { return data[$i]; }"
  }
  
  # Join the includes and sum additions into their respective sections
  $includeHeaders = $otherIncludes -join "`n"
  $otherSums = $otherModules -join "`n          "
  $internalSumsJoined = $internalSums -join "`n          "
  $internalSumsDefinitionsJoined = $internalSumsDefinitions -join "`n`n  "

  return @"
#include "file$fileIndex.h"
$includeHeaders

namespace Module$fileIndex {

  double MyClass$fileIndex::computeSum() const {
          double sum = 0;
          for(auto val : data) {
              sum += val;
          }

          $internalSumsJoined

          // Add sums from other modules
          $otherSums
          return sum;
      }

  $internalSumsDefinitionsJoined

} // namespace Module$fileIndex

"@
}
