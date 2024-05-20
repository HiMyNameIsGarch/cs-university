#include <iostream>

#include "ShortTest.h"
#include "ExtendedTest.h"

// 18. ADT SortedMultiMap – using a DLLA with (key, value) pairs ordered based on a relation on
// the keys. A key can appear in multiple pairs

int main(){
    testAll();
	testAllExtended();

    std::cout<<"Finished SMM Tests!"<<std::endl;
    return 0;
}
