#include <iostream>
#include "instruction.h"

Instruction::Instruction(int rsp, int rtp, int rdp) {
    rs = rsp;
    rt = rtp;
    rd = rdp;
}

Instruction::~Instruction() {

}

void AddInstruction::disassemble() {
    std::cout << "add $" << rs << ", $" << rt << ", $" << rd << std::endl;
}

int AddInstruction::execute(Registers *reg) {
    // rs rt rd
    reg->setRegister(rs, reg->getRegister(rt) + reg->getRegister(rd));
    return reg->getPC()+1;
}

void SubInstruction::disassemble() {
    std::cout << "sub $" << rs << ", $" << rt << ", $" << rd << std::endl;
}

int SubInstruction::execute(Registers *reg) {
    reg->setRegister(rs, reg->getRegister(rt) - reg->getRegister(rd));
    return reg->getPC()+1;
}

void OriInstruction::disassemble() {
    std::cout << "ori $" << rs << ", $" << rt << ", 10" << std::endl;
}

int OriInstruction::execute(Registers *reg) {
    reg->setRegister(rs, reg->getRegister(rt) | rd);
    return reg->getPC()+1;
}

void BrneInstruction::disassemble() {
    std::cout << "brne $" << rs << ", $" << rt << ", -4" << std::endl;
}

int BrneInstruction::execute(Registers *reg) {
    if (reg->getRegister(rs) != reg->getRegister(rt)) {
        return reg->getPC()+1+rd;
    }
    else {
        return reg->getPC()+1;
    }
}