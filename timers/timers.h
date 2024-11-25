/*----------------------------------------------------------------------------------
// Name: timers.h
// Description: Includes functions intended to read information off of the hpmcounters
//              available in a given RISCV simulator.
//----------------------------------------------------------------------------------
*/

#ifndef TIMERS_H
#define TIMERS_H

unsigned int update_cpu_time_val();
unsigned int update_instrets_val();
unsigned int update_num_cycles_val();
unsigned int update_instruction_cache_miss_val();
unsigned int update_branch_taken_val();
unsigned int update_branch_miss_val();

typedef struct Timer
{
    unsigned int numInstretsStart;
    unsigned int numInstretsEnd;
    unsigned int numCPUCyclesStart;
    unsigned int numCPUCyclesEnd;
    unsigned int CPUTimeStart;
    unsigned int CPUTimeEnd;
    unsigned int branchesTakenStart;
    unsigned int branchesTakenEnd;
    unsigned int instrCacheMissStart;
    unsigned int instrCacheMissEnd;
    unsigned int branchMissStart;
    unsigned int branchMissEnd;
} Timer;

    void print_timing_data(Timer t);
    struct Timer update_start_timers(Timer t);
    struct Timer update_stop_timers(Timer t);

#endif