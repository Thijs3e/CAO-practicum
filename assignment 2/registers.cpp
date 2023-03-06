#include <iostream>
#include "registers.h"

using namespace std;

Registers::Registers() {
    PC = 0;
    for (int i = 0; i < MIPS_REGISTERS; ++i) {
        registers[i] = 0;
    }
}

void Registers::setRegister(int regNum, int value) {
    registers[regNum] = value;
}

int Registers::getRegister(int regNum) {
    return registers[regNum];
}

void Registers::setPC(int value) {
    PC = value;
}

int Registers::getPC() {
    return PC;
}

void Registers::print() {
    std::cout << "The program counter is " << PC << std::endl;
    std::cout << "The registers contain: " << std::endl;
    for (int i = 0; i < MIPS_REGISTERS; ++i) {
        std::cout << "\t" << i << " : " << registers[i] << std::endl;
    }
}


