#include "simulator.h"
#include "program.h"
#include "registers.h"

void loadProgram (Program *program)
{
	program->appendInstruction (new OriInstruction (1, 0, 12));
	program->appendInstruction (new OriInstruction (2, 0, 4));
	program->appendInstruction (new OriInstruction (3, 0, 1));
	program->appendInstruction (new AddInstruction (4, 4, 1));
	program->appendInstruction (new SubInstruction (2, 2, 3));
	program->appendInstruction (new BrneInstruction (2, 0, -3));
}


int main (void)
{
	Registers *registers	= new Registers ();
	Program	*program	= new Program ();

	loadProgram (program);

	Simulator theSimulator = Simulator (registers, program);

	theSimulator.ui ();


	return 0;
}


// Yes it does. the types of instructions match, and the values match. For 'loop' it takes -3. This is also correct

/*
 * for (i = $2; i > 0; --i){
 *    $4 += $1;
 * }
 *
 * or easier said: $2*$4
 */