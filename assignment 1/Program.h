#ifndef ASSIGNMENT_1_PROGRAM_H
#define ASSIGNMENT_1_PROGRAM_H
// class defenition of Program

class Program {
private:
    int numArith;
    int numStore;
    int numLoad;
    int numBranch;
    int numTotal;
public:
    Program(int, int, int, int);
    Program(int, double, double, double);
    void printStats();
    int getNumArith() const;

    int getNumStore() const;

    int getNumLoad() const;

    int getNumBranch() const;

    int getNumTotal() const;
};


#endif //ASSIGNMENT_1_PROGRAM_H
