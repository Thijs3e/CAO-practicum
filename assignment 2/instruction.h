#ifndef _INSTRUCTION_H_
#define _INSTRUCTION_H_

#include <iostream>
#include "registers.h"

using namespace std;

class Instruction
{
public:
    Instruction(int, int, int);
    virtual ~Instruction();
    virtual void disassemble() = 0;
    virtual int execute (Registers *) = 0;
protected:
    int rs;
    int rt;
    int rd;
};

class AddInstruction : public Instruction {
public:
    using Instruction::Instruction;
    void disassemble();
    int execute (Registers *);
};

class SubInstruction : public Instruction {
    using Instruction::Instruction;
    void disassemble();
    int execute (Registers *);
};

class OriInstruction : public Instruction {
    using Instruction::Instruction;
    void disassemble();
    int execute (Registers *);
};

class BrneInstruction : public Instruction{
    using Instruction::Instruction;
    void disassemble();
    int execute (Registers *);
};

#endif /* _INSTRUCTION_H_ */
