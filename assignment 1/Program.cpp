//
// Created by Thijs on 21/02/2023.
//
#include <iostream>
#include "Program.h"

//constructor for when specific number of instructions are known
Program::Program(int arith, int store, int load, int branch) {
    numArith = arith;
    numStore = store;
    numLoad = load;
    numBranch = branch;
    numTotal = numArith + numStore + numLoad + numBranch;
}

//constructor for when the percentages of the total instructions are known
Program::Program(int total, double fracArith, double fracStore, double fracLoad) {
    double fracBranch = (100 - (fracArith*100) - (fracLoad*100) - (fracStore*100))/100; // multiplication and division by 100 to reduce the floating point error
    numArith = total*fracArith;
    numStore = total*fracStore;
    numLoad = total*fracLoad;
    numBranch = (double)total*fracBranch;
    numTotal = numArith + numStore + numLoad + numBranch;
}

// print the stat
void Program::printStats() {
    std::cout << "The program consists of " << numTotal << " different instructions. Of which " << numArith << " are arith, " << numLoad << " are load, " << numStore << " are store and " << numBranch << " are branch." << std::endl;
}

// Getters for this class
int Program::getNumArith() const {
    return numArith;
}

int Program::getNumStore() const {
    return numStore;
}

int Program::getNumLoad() const {
    return numLoad;
}

int Program::getNumBranch() const {
    return numBranch;
}

int Program::getNumTotal() const {
    return numTotal;
}
