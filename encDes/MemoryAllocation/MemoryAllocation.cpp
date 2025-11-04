// MemoryAllocation.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>

int main()
{
    std::cout << "Hello World!\n";
    int* stackPtr;
    int* headPtr = new int;
	int x = 42;
    stackPtr = &x;
    *heapPtr = 65;
	cout << heapPtr << ", " << stackPtr << endl;

    int* dataPtr = nullPtr;
	dataPtr = new int[1000];
    for (int i = 0; i < 1000; i++) {
        dataPtr[i] = i;
		cout << dataPtr[i] << " ";
	}
}
