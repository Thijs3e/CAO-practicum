#include <iostream>
#include "Computer.h"
#include "Program.h"

int main() {
    // define the computers and the programs
    Computer computers[3] = {Computer(1.0, 2.0, 2.0, 3.0, 4.0), Computer(1.2, 2.0, 3.0, 4.0, 3.0), Computer(2.0, 2.0, 2.0, 4.0, 6.0)};
    Program programs[3] = {Program(2000, 100, 100, 50), Program(2000, 0.1, 0.4, 0.25), Program(500, 100, 2000, 200)};

    // print stats for each computer
    for (Computer c : computers) {
        c.printStats();
    }

    // print global mips of every computer
    for (Computer c : computers) {
        std::cout << "The global mips score is " << c.calculateMIPS() << std::endl;
    }

    // calculate execution time for each program on each computer.
    int compNum = 1;
    for (Computer c : computers) {
        char progChar = 65; // char 65 is 'A'
        for (Program p : programs) {
            std::cout << "Computer " << compNum << " takes " << c.calculateExecutionTime(p) << " seconds to run program " << progChar << std::endl;
            ++progChar;
        }
        ++compNum;
    }

    // same code as above, but now displaying the weighted mips score
    compNum = 1;
    for (Computer c : computers) {
        char progChar = 65;
        for (Program p : programs) {
            std::cout << "Computer " << compNum << " has a MIPS score of " << c.calculateMIPS(p) << " when running program " << progChar << std::endl;
            ++progChar;
        }
        ++compNum;
    }
    return 0;
}

/*
 * Compare the global MIPS ratings to the program-dependent MIPS ratings. Comment on your findings
 *
 * The accuracy of the global MIPS rating is low when the program contains a big number of instructions of one type,
 * and the CPI values are very different
 *
 * The book clarifies that MIPS is not a good performance indicator
 *
 * Yes, we can see that the global and program dependent MIPS values of computer 1 are similair for program 2 and 3,
 * but very different for program 1.
 */