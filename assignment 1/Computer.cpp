#include "Computer.h"
#include <iostream>

//constructor
Computer::Computer(double clock, double arith, double store, double load, double branch) {
    clockRateGHz = clock;
    cpiArith = arith;
    cpiStore = store;
    cpiLoad = load;
    cpiBranch = branch;
}

//print the stats
void Computer::printStats() {
    std::cout << "This processor has a clock rate of " << clockRateGHz << " GHz. The arith, store, load and branch cpi's are " << cpiArith << ", " << cpiStore << ", " << cpiLoad << " and " << cpiStore << " respectively" << std::endl;
}

// calculate the unweighted CPI
double Computer::calculateGlobalCPI() {
    // Sums CPIs and divides by 4
    double sumCPI = cpiArith + cpiStore + cpiLoad + cpiBranch;
    return sumCPI/4.0;
}

//calc execution time by
double Computer::calculateExecutionTime(Program program) {
    // first determine the number of clock cycles needed to complete. then convert to seconds
    int totalClockCycles = cpiArith*program.getNumArith() + cpiStore*program.getNumStore() + cpiLoad*program.getNumLoad() + cpiBranch*program.getNumBranch();
    return totalClockCycles/(clockRateGHz*1e9);
}

double Computer::calculateMIPS(void) { // unwheighted mips score. Assumes that the four different operations are equally important
    // clock * 1000 to represent the clock in MHz
    return clockRateGHz*1e3/calculateGlobalCPI();
}

// calculated weighted mips
double Computer::calculateMIPS(Program program) { // weighted mips score
    return program.getNumTotal()/ (calculateExecutionTime(program)*1e6);
}

