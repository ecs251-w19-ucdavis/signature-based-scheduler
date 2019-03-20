CC = /usr/bin/gcc
CPP = /usr/bin/gcc++
LD = /usr/bin/gcc
CFLAGS = $(FLAGS)
CPPFLAGS = $(FLAGS)
RM = rm -f

########################################################
# implicit rules
%.o : %.c
	$(CC) -c $(CFLAGS) $< -o $@


########################################################
################################################################################
#
# Some flags that may help during the debug
#
# Electric Fence: -lefence
# GConf: -pg
# Find Extra Errors: -pedantic -Wextra
################################################################################

# ~ ## DEBUG DEEP
# ~ FLAGS =  -Wall -O0 -ggdb  -Werror -lefence
# ~ LDFLAGS = -ggdb  -lefence

# ~ ## DEBUG DEEP FAST
# ~ FLAGS =  -Wall -O2 -ggdb  -Werror -lefence
# ~ LDFLAGS = -ggdb  -lefence

## DEBUG NORMAL
# ~ FLAGS =  -Wall -O1 -ggdb -Werror
# ~ LDFLAGS = -ggdb

# ~ ## EXECUTION
FLAGS = -fopenmp -O1  -Wall -Wextra -static # -ggdb
#-mno-mmx -mno-sse2 -mno-sse3 -mno-sse4.1 -mno-sse4.2
# -mno-mmx -mno-sse -mno-sse2 -mno-sse3 -mno-sse4.1 -mno-sse4.2

LDFLAGS = -fopenmp -static # -ggdb

########################################################

EXEC_C1 = control_complex/control_complex
EXEC_C2 = control_conditional/control_conditional
EXEC_C3 = control_switch/control_switch
EXEC_C4 = control_random/control_random
EXEC_C5 = control_small_bbl/control_small_bbl

EXEC_D1 = dependency_chain1/dependency_chain1
EXEC_D2 = dependency_chain2/dependency_chain2
EXEC_D3 = dependency_chain3/dependency_chain3
EXEC_D4 = dependency_chain4/dependency_chain4
EXEC_D5 = dependency_chain5/dependency_chain5
EXEC_D6 = dependency_chain6/dependency_chain6

EXEC_EI1 = execution_int_add_ind/execution_int_add_ind
EXEC_EI2 = execution_int_mul_ind/execution_int_mul_ind
EXEC_EI3 = execution_int_div_ind/execution_int_div_ind

EXEC_EF1 = execution_fp_add_ind/execution_fp_add_ind
EXEC_EF2 = execution_fp_mul_ind/execution_fp_mul_ind
EXEC_EF3 = execution_fp_div_ind/execution_fp_div_ind

EXEC_M11 = memory_load_dep1/memory_load_dep1
EXEC_M12 = memory_load_dep2/memory_load_dep2
EXEC_M13 = memory_load_dep3/memory_load_dep3
EXEC_M14 = memory_load_dep4/memory_load_dep4
EXEC_M21 = memory_load_ind1/memory_load_ind1
EXEC_M22 = memory_load_ind2/memory_load_ind2
EXEC_M23 = memory_load_ind3/memory_load_ind3
EXEC_M24 = memory_load_ind4/memory_load_ind4
EXEC_M31 = memory_load_random1/memory_load_random1
EXEC_M32 = memory_load_random2/memory_load_random2
EXEC_M33 = memory_load_random3/memory_load_random3
EXEC_M34 = memory_load_random4/memory_load_random4
EXEC_M41 = memory_store_ind1/memory_store_ind1
EXEC_M42 = memory_store_ind2/memory_store_ind2
EXEC_M43 = memory_store_ind3/memory_store_ind3
EXEC_M44 = memory_store_ind4/memory_store_ind4
EXEC_M51 = memory_store_random1/memory_store_random1
EXEC_M52 = memory_store_random2/memory_store_random2
EXEC_M53 = memory_store_random3/memory_store_random3
EXEC_M54 = memory_store_random4/memory_store_random4

########################################################

OBJ_C1 = control_complex/control_complex.o
OBJ_C2 = control_conditional/control_conditional.o
OBJ_C3 = control_switch/control_switch.o
OBJ_C4 = control_random/control_random.o
OBJ_C5 = control_small_bbl/control_small_bbl.o

OBJ_D1 = dependency_chain1/dependency_chain1.o
OBJ_D2 = dependency_chain2/dependency_chain2.o
OBJ_D3 = dependency_chain3/dependency_chain3.o
OBJ_D4 = dependency_chain4/dependency_chain4.o
OBJ_D5 = dependency_chain5/dependency_chain5.o
OBJ_D6 = dependency_chain6/dependency_chain6.o

OBJ_EI1 = execution_int_add_ind/execution_int_add_ind.o
OBJ_EI2 = execution_int_mul_ind/execution_int_mul_ind.o
OBJ_EI3 = execution_int_div_ind/execution_int_div_ind.o

OBJ_EF1 = execution_fp_add_ind/execution_fp_add_ind.o
OBJ_EF2 = execution_fp_mul_ind/execution_fp_mul_ind.o
OBJ_EF3 = execution_fp_div_ind/execution_fp_div_ind.o

#OBJ_M1 = memory_load_dep/memory_load_dep.o
#OBJ_M2 = memory_load_ind/memory_load_ind.o
#OBJ_M3 = memory_load_random/memory_load_random.o
#OBJ_M4 = memory_store_ind/memory_store_ind.o
#OBJ_M5 = memory_store_random/memory_store_random.o

OBJ_M11 = memory_load_dep1/memory_load_dep1.o
OBJ_M12 = memory_load_dep2/memory_load_dep2.o
OBJ_M13 = memory_load_dep3/memory_load_dep3.o
OBJ_M14 = memory_load_dep4/memory_load_dep4.o
OBJ_M21 = memory_load_ind1/memory_load_ind1.o
OBJ_M22 = memory_load_ind2/memory_load_ind2.o
OBJ_M23 = memory_load_ind3/memory_load_ind3.o
OBJ_M24 = memory_load_ind4/memory_load_ind4.o
OBJ_M31 = memory_load_random1/memory_load_random1.o
OBJ_M32 = memory_load_random2/memory_load_random2.o
OBJ_M33 = memory_load_random3/memory_load_random3.o
OBJ_M34 = memory_load_random4/memory_load_random4.o
OBJ_M41 = memory_store_ind1/memory_store_ind1.o
OBJ_M42 = memory_store_ind2/memory_store_ind2.o
OBJ_M43 = memory_store_ind3/memory_store_ind3.o
OBJ_M44 = memory_store_ind4/memory_store_ind4.o
OBJ_M51 = memory_store_random1/memory_store_random1.o
OBJ_M52 = memory_store_random2/memory_store_random2.o
OBJ_M53 = memory_store_random3/memory_store_random3.o
OBJ_M54 = memory_store_random4/memory_store_random4.o

all:	$(EXEC_C1) $(EXEC_C2) $(EXEC_C3) $(EXEC_C4) $(EXEC_C5)\
		$(EXEC_D1) $(EXEC_D2) $(EXEC_D3) $(EXEC_D4) $(EXEC_D5) $(EXEC_D6)\
		$(EXEC_EI1) $(EXEC_EI2) $(EXEC_EI3) \
		$(EXEC_EF1) $(EXEC_EF2) $(EXEC_EF3) \
	$(EXEC_M11) $(EXEC_M12) $(EXEC_M13) $(EXEC_M14) $(EXEC_M15) \
		$(EXEC_M21) $(EXEC_M22) $(EXEC_M23) $(EXEC_M24) $(EXEC_M25) \
	$(EXEC_M31) $(EXEC_M32) $(EXEC_M33) $(EXEC_M34) $(EXEC_M35) \
	$(EXEC_M41) $(EXEC_M42) $(EXEC_M43) $(EXEC_M44) $(EXEC_M45) 
	#$(EXEC_M1) $(EXEC_M2) $(EXEC_M3) $(EXEC_M4) $(EXEC_M5) 

$(EXEC_C1): $(OBJ_C1)
	$(LD) $(LDFLAGS) -o $(EXEC_C1) $(OBJ_C1) $(LIBRARY)

$(EXEC_C2): $(OBJ_C2)
	$(LD) $(LDFLAGS) -o $(EXEC_C2) $(OBJ_C2) $(LIBRARY)

$(EXEC_C3): $(OBJ_C3)
	$(LD) $(LDFLAGS) -o $(EXEC_C3) $(OBJ_C3) $(LIBRARY)

$(EXEC_C4): $(OBJ_C4)
	$(LD) $(LDFLAGS) -o $(EXEC_C4) $(OBJ_C4) $(LIBRARY)

$(EXEC_C5): $(OBJ_C5)
	$(LD) $(LDFLAGS) -o $(EXEC_C5) $(OBJ_C5) $(LIBRARY)

###################

$(EXEC_D1): $(OBJ_D1)
	$(LD) $(LDFLAGS) -o $(EXEC_D1) $(OBJ_D1) $(LIBRARY)

$(EXEC_D2): $(OBJ_D2)
	$(LD) $(LDFLAGS) -o $(EXEC_D2) $(OBJ_D2) $(LIBRARY)

$(EXEC_D3): $(OBJ_D3)
	$(LD) $(LDFLAGS) -o $(EXEC_D3) $(OBJ_D3) $(LIBRARY)

$(EXEC_D4): $(OBJ_D4)
	$(LD) $(LDFLAGS) -o $(EXEC_D4) $(OBJ_D4) $(LIBRARY)

$(EXEC_D5): $(OBJ_D5)
	$(LD) $(LDFLAGS) -o $(EXEC_D5) $(OBJ_D5) $(LIBRARY)

$(EXEC_D6): $(OBJ_D6)
	$(LD) $(LDFLAGS) -o $(EXEC_D6) $(OBJ_D6) $(LIBRARY)

###################

$(EXEC_EI1): $(OBJ_EI1)
	$(LD) $(LDFLAGS) -o $(EXEC_EI1) $(OBJ_EI1) $(LIBRARY)

$(EXEC_EI2): $(OBJ_EI2)
	$(LD) $(LDFLAGS) -o $(EXEC_EI2) $(OBJ_EI2) $(LIBRARY)

$(EXEC_EI3): $(OBJ_EI3)
	$(LD) $(LDFLAGS) -o $(EXEC_EI3) $(OBJ_EI3) $(LIBRARY)

###################

$(EXEC_EF1): $(OBJ_EF1)
	$(LD) $(LDFLAGS) -o $(EXEC_EF1) $(OBJ_EF1) $(LIBRARY)

$(EXEC_EF2): $(OBJ_EF2)
	$(LD) $(LDFLAGS) -o $(EXEC_EF2) $(OBJ_EF2) $(LIBRARY)

$(EXEC_EF3): $(OBJ_EF3)
	$(LD) $(LDFLAGS) -o $(EXEC_EF3) $(OBJ_EF3) $(LIBRARY)

###################

$(EXEC_M11): $(OBJ_M11)  
	$(LD) $(LDFLAGS) -o $(EXEC_M11) $(OBJ_M11) $(LIBRARY)

$(EXEC_M12): $(OBJ_M12) 
	$(LD) $(LDFLAGS) -o $(EXEC_M12) $(OBJ_M12) $(LIBRARY)

$(EXEC_M13): $(OBJ_M13)
	$(LD) $(LDFLAGS) -o $(EXEC_M13) $(OBJ_M13) $(LIBRARY)

$(EXEC_M14): $(OBJ_M14)
	$(LD) $(LDFLAGS) -o $(EXEC_M14) $(OBJ_M14) $(LIBRARY)

$(EXEC_M15): $(OBJ_M15)
	$(LD) $(LDFLAGS) -o $(EXEC_M15) $(OBJ_M15) $(LIBRARY)

$(EXEC_M21): $(OBJ_M21)
	$(LD) $(LDFLAGS) -o $(EXEC_M21) $(OBJ_M21) $(LIBRARY)

$(EXEC_M22): $(OBJ_M22)
	$(LD) $(LDFLAGS) -o $(EXEC_M22) $(OBJ_M22) $(LIBRARY)

$(EXEC_M23): $(OBJ_M23)
	$(LD) $(LDFLAGS) -o $(EXEC_M23) $(OBJ_M23) $(LIBRARY)

$(EXEC_M24): $(OBJ_M24)
	$(LD) $(LDFLAGS) -o $(EXEC_M24) $(OBJ_M24) $(LIBRARY)

$(EXEC_M25): $(OBJ_M25)
	$(LD) $(LDFLAGS) -o $(EXEC_M25) $(OBJ_M25) $(LIBRARY)

$(EXEC_M31): $(OBJ_M31)
	$(LD) $(LDFLAGS) -o $(EXEC_M31) $(OBJ_M31) $(LIBRARY)

$(EXEC_M32): $(OBJ_M32)
	$(LD) $(LDFLAGS) -o $(EXEC_M32) $(OBJ_M32) $(LIBRARY)

$(EXEC_M33): $(OBJ_M33)
	$(LD) $(LDFLAGS) -o $(EXEC_M33) $(OBJ_M33) $(LIBRARY)

$(EXEC_M34): $(OBJ_M34)
	$(LD) $(LDFLAGS) -o $(EXEC_M34) $(OBJ_M34) $(LIBRARY)

$(EXEC_M35): $(OBJ_M35)
	$(LD) $(LDFLAGS) -o $(EXEC_M35) $(OBJ_M35) $(LIBRARY)

$(EXEC_M41): $(OBJ_M41)
	$(LD) $(LDFLAGS) -o $(EXEC_M41) $(OBJ_M41) $(LIBRARY)

$(EXEC_M42): $(OBJ_M42)
	$(LD) $(LDFLAGS) -o $(EXEC_M42) $(OBJ_M42) $(LIBRARY)

$(EXEC_M43): $(OBJ_M43)
	$(LD) $(LDFLAGS) -o $(EXEC_M43) $(OBJ_M43) $(LIBRARY)

$(EXEC_M44): $(OBJ_M44)
	$(LD) $(LDFLAGS) -o $(EXEC_M44) $(OBJ_M44) $(LIBRARY)

$(EXEC_M45): $(OBJ_M45)
	$(LD) $(LDFLAGS) -o $(EXEC_M45) $(OBJ_M45) $(LIBRARY)

###################
###################

clean:
	-$(RM) $(OBJ_C1) $(OBJ_C2) $(OBJ_C3) $(OBJ_C4) $(OBJ_C5) \
			$(OBJ_D1) $(OBJ_D2) $(OBJ_D3) $(OBJ_D4) $(OBJ_D5) $(OBJ_D6) \
			$(OBJ_EI1) $(OBJ_EI2) $(OBJ_EI3) \
			$(OBJ_EF1) $(OBJ_EF2) $(OBJ_EF3) \
	$(OBJ_M11) $(OBJ_M12) $(OBJ_M13) $(OBJ_M14) $(OBJ_M15) \
	$(OBJ_M21) $(OBJ_M22) $(OBJ_M23) $(OBJ_M24) $(OBJ_M25) \
	$(OBJ_M31) $(OBJ_M32) $(OBJ_M33) $(OBJ_M34) $(OBJ_M35) \
	$(OBJ_M41) $(OBJ_M42) $(OBJ_M43) $(OBJ_M44) $(OBJ_M45)
	-$(RM) $(EXEC_C1) $(EXEC_C2) $(EXEC_C3) $(EXEC_C4) $(EXEC_C5) \
			$(EXEC_D1) $(EXEC_D2) $(EXEC_D3) $(EXEC_D4) $(EXEC_D5) $(EXEC_D6) \
			$(EXEC_EI1) $(EXEC_EI2) $(EXEC_EI3) \
			$(EXEC_EF1) $(EXEC_EF2) $(EXEC_EF3) \
	$(EXEC_M11) $(EXEC_M12) $(EXEC_M13) $(EXEC_M14) $(EXEC_M15) \
	$(EXEC_M21) $(EXEC_M22) $(EXEC_M23) $(EXEC_M24) $(EXEC_M25) \
	$(EXEC_M31) $(EXEC_M32) $(EXEC_M33) $(EXEC_M34) $(EXEC_M35) \
	$(EXEC_M41) $(EXEC_M42) $(EXEC_M43) $(EXEC_M44) $(EXEC_M45)
	@echo All clean!
	@echo
