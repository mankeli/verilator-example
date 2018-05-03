#include "Vtvmix_calc.h"
#include "verilated.h"
int main(int argc, char **argv, char **env)
{
	Verilated::commandArgs(argc, argv);

	Vtvmix_calc* top = new Vtvmix_calc;
	while (!Verilated::gotFinish())
	{
		static int clk = 0;
		clk = (clk+1) & 1;

		//uint32_t palentry = rand();
		static uint32_t palentry = 0;
		palentry+=1000;
		printf("\n\nclk: %i, palentry: 0x%08X\n",
			clk, palentry);



		top->clk = clk;
		top->palentry = palentry;
		top->cc_i = -1024;
		top->cc_q = 1024;
		top->eval(); 

		usleep(1000000);
	}

	delete top;
	exit(0);
}

