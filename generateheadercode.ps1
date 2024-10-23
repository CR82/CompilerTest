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