function GenerateCppCode($fileIndex, $totalFiles) {
  $otherIncludes = @()
  $otherModules = @()
  
  # Collect includes for other module headers and their computeSum calls
  for ($i = 1; $i -le $totalFiles; $i++) {
    if ($i -ne $fileIndex) {
      $otherIncludes += "#include `"file$i.h`""
      $otherModules += "Module$i::MyClass$i other$i;"
      $otherModules += "sum += other$i.computeSum();"
    }
  }
  
  # Join the includes and sum additions into their respective sections
  $includeHeaders = $otherIncludes -join "`n"
  $otherSums = $otherModules -join "`n          "

  return @"
#include "file$fileIndex.h"
$includeHeaders

namespace Module$fileIndex {

  double MyClass$fileIndex::computeSum() const {
          double sum = 0;
          for(auto val : data) {
              sum += val;
          }
          // Add sums from other modules
          $otherSums
          return sum;
      }

} // namespace Module$fileIndex

"@
}
