#------------------------------------------------------------------------------
# 
# Copyright (c) 2016-Present Pivotal Software, Inc
#
#------------------------------------------------------------------------------

PGXS := $(shell pg_config --pgxs)
include $(PGXS)

REGRESS_OPTS = --dbname=$(PL_TESTDB) --init-file=./init_file --schedule=pl_schedule
RESGROUP_OPTS = --dbname=$(PL_TESTDB) --init-file=./init_file --schedule=pl_resgroup_schedule
PSQLDIR = --psqldir=$(bindir)
ifeq ($(PLC_PG),yes)
    REGRESS_OPTS = --dbname=$(PL_TESTDB)  --schedule=pl_schedule_pg
    PSQLDIR = --bindir=$(bindir)
endif

.PHONY: default
default: all

.PHONY: all
all: tests

.PHONY: resgroup
resgroup:
	@echo "Tests require two runtime configurations. Will check the two"
	@echo "runtime configurations soon. If there is configuration missing,"
	@echo "please refer plcontainer script concourse/scripts/run_plcontainer_resgroup_tests.sh"
	@echo "as example to learn how to set up those configurations"
	plcontainer runtime-show -r plc_python_shared
	plcontainer runtime-show -r plc_r_shared
	
	# Might use branch to handle the difference later.
	pg_config --version
	if [ "`pg_config --version`" == "PostgreSQL 8.3.23" ]; then    \
		cp expected/test_python.out.gp5 expected/test_python.out; \
		cp expected/uda_python.out.gp5 expected/uda_python.out;  \
	else                                                         \
		cp expected/test_python.out.gp6 expected/test_python.out; \
		cp expected/uda_python.out.gp6 expected/uda_python.out;  \
	fi
	PL_TESTDB=$(PL_TESTDB) $(top_builddir)/src/test/regress/pg_regress \
				$(PSQLDIR) $(RESGROUP_OPTS) || if [[ -f regression.diffs ]]; then cat regression.diffs; exit 1; fi
.PHONY: tests
tests:
	@echo "Tests require two runtime configurations. Will check the two"
	@echo "runtime configurations soon. If there is configuration missing,"
	@echo "please refer plcontainer script concourse/scripts/run_plcontainer_tests.sh"
	@echo "as example to learn how to set up those configurations"
	plcontainer runtime-show -r plc_python_shared
	plcontainer runtime-show -r plc_r_shared
	# Might use branch to handle the difference later.
	pg_config --version
	if [ "`pg_config --version`" == "PostgreSQL 8.3.23" ]; then    \
		cp expected/test_python.out.gp5 expected/test_python.out; \
		cp expected/uda_python.out.gp5 expected/uda_python.out;  \
	else                                                         \
		cp expected/test_python.out.gp6 expected/test_python.out; \
		cp expected/uda_python.out.gp6 expected/uda_python.out;  \
	fi
	
	PL_TESTDB=$(PL_TESTDB) $(top_builddir)/src/test/regress/pg_regress \
				$(PSQLDIR) $(REGRESS_OPTS) || if [[ -f regression.diffs ]]; then cat regression.diffs; exit 1; fi

.PHONY: submake
submake:
	$(MAKE) -C $(top_builddir)/src/test/regress pg_regress$(X)
