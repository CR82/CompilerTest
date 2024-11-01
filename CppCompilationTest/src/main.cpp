#include <iostream>
#include <vector>
#include <string>
#include "file1.h"
#include "file2.h"
#include "file3.h"
#include "file4.h"
#include "file5.h"

int main() {
    double total = 0.0;
    for (int i = 1; i <= 5; ++i) {
        switch (i) {            case 1: {
                total += Module1::process();
                break;
            }
            case 2: {
                total += Module2::process();
                break;
            }
            case 3: {
                total += Module3::process();
                break;
            }
            case 4: {
                total += Module4::process();
                break;
            }
            case 5: {
                total += Module5::process();
                break;
            }
            default:
                break;
        }
    }
    std::cout << "Total Sum: " << total << std::endl;
    return 0;
}
