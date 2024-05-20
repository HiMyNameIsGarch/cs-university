#include <assert.h>

#include "SortedMultiMap.h"
#include "SMMIterator.h"
#include <iostream>
#include <exception>
#include <vector>

using namespace std;

bool relation1(TKey cheie1, TKey cheie2) {
	if (cheie1 <= cheie2) {
		return true;
	}
	else {
		return false;
	}
}

void testAll(){
	SortedMultiMap smm = SortedMultiMap(relation1);
	assert(smm.size() == 0);
	assert(smm.isEmpty());
    smm.add(1,2);
    smm.add(1,3);
    assert(smm.size() == 2);
    assert(!smm.isEmpty());
    vector<TValue> v= smm.search(1);
    std::cout << "Search done" << std::endl;
    assert(v.size()==2);
    v= smm.search(3);
    assert(v.size()==0);
    std::cout << "Iterator begin" << std::endl;
    SMMIterator it = smm.iterator();
    it.first();
    while (it.valid()){
    	it.getCurrent();
    	it.next();
    }
    std::cout << "Iterator done" << std::endl;
    assert(smm.remove(1, 2) == true);
    assert(smm.remove(1, 3) == true);
    assert(smm.remove(2, 1) == false);
    assert(smm.isEmpty());
}

