#ifndef _REGISTERS_H_
#define _REGISTERS_H_

#define MIPS_REGISTERS 32

class Registers
{
private:
    int registers[MIPS_REGISTERS];
    int PC;
public:
    Registers();
    void setRegister (int, int);
    int getRegister (int);
    void setPC(int);
    int getPC();
    void print();
};

#endif	/* _REGISTERS_H_ */
