//
// Created by Thijs on 21/02/2023.
//

#ifndef ASSIGNMENT_1_COMPUTER_H
#define ASSIGNMENT_1_COMPUTER_H


#include "Program.h"

class Computer {
private:
    double clockRateGHz;
    double cpiArith;
    double cpiStore;
    double cpiLoad;
    double cpiBranch;
public:
    Computer (double, double, double, double, double);
    void printStats();
    double calculateGlobalCPI();
    double calculateExecutionTime(Program);
    double calculateMIPS(void);
    double calculateMIPS(Program);
};


#endif //ASSIGNMENT_1_COMPUTER_H
