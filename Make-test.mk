DEJATOOL = $(PROJECT)
RUNTESTFLAGS =
RUNTESTDEFAULTFLAGS = --tool $(PROJECT) --srcdir $$srcdir/testsuite
EXPECT = expect
RUNTEST = runtest
srcdir = $(top_srcdir)

check: site.exp
	@srcdir=`cd $(srcdir) && pwd`; export srcdir; \
        EXPECT=$(EXPECT); export EXPECT; \
        if $(SHELL) -c "$(RUNTEST) --version" > /dev/null 2>&1; then \
            $(RUNTEST) $(RUNTESTDEFAULTFLAGS) $(RUNTESTFLAGS); \
        else \
  	    echo "Could not find $(RUNTEST).  Is dejagnu installed?" 1>&2; :;\
        fi

site.exp: Makefile
	@echo 'Making a new site.exp file...'
	@test ! -f site.bak || rm -f site.bak
	@echo '## these variables are automatically generated by make ##' > $@-t
	@echo '# Do not edit here.  If you wish to override these values' >> $@-t
	@echo '# edit the last section' >> $@-t
	@echo 'set tool $(DEJATOOL)' >> $@-t
	@echo 'set srcdir $(srcdir)' >> $@-t
	@echo 'set objdir' `pwd` >> $@-t
	@echo '## All variables above are generated by configure. Do Not Edit ##' >> $@-t
	@test ! -f site.exp || sed '1,/^## All variables above are.*##/ d' site.exp >> $@-t
	@test ! -f site.exp || mv site.exp site.bak
	@mv $@-t site.exp
