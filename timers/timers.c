/*----------------------------------------------------------------------------------
// Name: timers.c
// Description: Includes functions intended to read information off of the hpmcounters
//              available in a given RISCV simulator.
//----------------------------------------------------------------------------------
*/

#include <stdio.h>
#include <stdint.h>
#include "timers.h"

/*
This function initializes the "start" timers available for a given run.
Input:
    struct Timer t: a Timer struct with start and stop timer members, based on values
    read out from the hardware registers available.
Output:
    The updated Timer struct with its "start" timers snapshotted and saved off.
*/
struct Timer update_start_timers(Timer t)
{
    t.numInstretsStart = update_instrets_val();
    t.numCPUCyclesStart = update_num_cycles_val();
    t.CPUTimeStart = update_cpu_time_val();
    t.branchesTakenStart = update_branch_taken_val();
    t.instrCacheMissStart = update_instruction_cache_miss_val();
    t.branchMissStart = update_branch_miss_val();
    return t;
}

/*
This function initializes the "stop" timers available for a given run.
Input:
    struct Timer t: a Timer struct with start and stop timer members, based on values
    read out from the hardware registers available.
Output:
    The updated Timer struct with its "stop" timers snapshotted and saved off.
*/
struct Timer update_stop_timers(Timer t)
{    
    t.numInstretsEnd = update_instrets_val();
    t.numCPUCyclesEnd = update_num_cycles_val();
    t.CPUTimeEnd = update_cpu_time_val();
    t.branchesTakenEnd = update_branch_taken_val();
    t.instrCacheMissEnd = update_instruction_cache_miss_val();
    t.branchMissEnd = update_branch_miss_val();
    return t;
}

/*
The following "update_<>_<>_val()" functions read raw values from the associated hpmcounter available.
See the riscv-pk toolchains and the Berkeley Out-of-Order Machine (BOOM) docs for more details.
Reference the SiFive U54-MC Core Complex Manual for instructions on how to map hpmevents.
The following variables are available by default:
- cycle
- time
- instret
*/

unsigned int update_num_cycles_val()
{
    unsigned int num_cycles = 0;
    __asm__ volatile("csrr %0, cycle"
                            : "=r"(num_cycles)
                    );
    return num_cycles;
}

unsigned int update_cpu_time_val()
{
    unsigned int cpu_time = 0;
    __asm__ volatile("csrr %0, time"
                            : "=r"(cpu_time)
                    );
    return cpu_time;
}

unsigned int update_instrets_val()
{
    unsigned int num_instrets = 0;
    __asm__ volatile("csrr %0, instret"
                            : "=r"(num_instrets)
                    );
    return num_instrets;
}

/*
This function reads the hpmcounter3, which is currently mapped to increment on instruction
cache misses for our RocketCore design.
*/
unsigned int update_instruction_cache_miss_val()
{
    unsigned int num_instr_cache_miss = 0;
    __asm__ volatile("csrr %0, hpmcounter3"
                            : "=r"(num_instr_cache_miss)
                    );
    return num_instr_cache_miss;
}

/*
This function reads the hpmcounter4, which is currently mapped to increment on branches
taken for our RocketCore design.
*/
unsigned int update_branch_taken_val()
{
    unsigned int num_branch_taken = 0;
    __asm__ volatile("csrr %0, hpmcounter4"
                            : "=r"(num_branch_taken)
                    );
    return num_branch_taken;
}

/*
This function reads the hpmcounter5, which is currently mapped to increment on branch
mispredictions for our RocketCore design.
*/
unsigned int update_branch_miss_val()
{
    unsigned int num_branch_misses = 0;
    __asm__ volatile("csrr %0, hpmcounter5"
                            : "=r"(num_branch_misses)
                    );
    return num_branch_misses;
}

/*
This function formats and prints the available timing data. This should be expanded as the
list of events to monitor grows.
*/
void print_timing_data(Timer t)
{
    unsigned int total_cpu_cycles = t.numCPUCyclesEnd - t.numCPUCyclesStart;
    unsigned int total_cpu_time = t.CPUTimeEnd - t.CPUTimeStart;
    unsigned int total_instrets = t.numInstretsEnd - t.numInstretsStart;
    unsigned int total_instr_cache_miss = t.instrCacheMissEnd - t.instrCacheMissStart;
    unsigned int total_branches = t.branchesTakenEnd - t.branchesTakenStart;
    unsigned int total_branch_miss = t.branchMissEnd - t.branchMissStart;

    printf("# ---------- Timing data for benchmark: ---------- #\n");
    printf("%u         seconds CPU execution time    #\n", total_cpu_time);
    printf("%u         cycles executed               #\n", total_cpu_cycles);
    printf("%u         instructions executed         #\n", total_instrets);
    printf("%u         instruction cache-misses      #\n", total_instr_cache_miss);
    printf("%u         branch-misses                 #\n", total_branch_miss);
    printf("%u         branches                      #\n", total_branches);
    printf("# ------------------------------------------------- #\n");
}