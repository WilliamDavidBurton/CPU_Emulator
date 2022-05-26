# This is a comment

# all: is generally used a prerequisit, to ensure that certain things are done before the rest of the of makefile runs.


# What I need is:
#	/bin -- the final binary that is run???
#	/src -> .c files
#		/test -- unit testing???
#	/obj -> .o files
#	/include -> .h files
#	maybe have a location to put the actual compiled code?

# This is to show that I'm compiling with GCC, instead of, say, G++
CC = gcc
# These are the build flags -- used to inform the compiler what I want it to keep in mind.
# -g means 'generate debugging information'
# -Wall means 'recommended compiler warnings'
CFLAGS = -g -Wall -I $(HEADERDIR)

# More variables for later -- where the source, object and header files are, or are going to be.
SOURCEDIR = src
OBJECTDIR = obj
HEADERDIR = include
# The list of all directories -- used for later
ALLDIRS = $(SOURCEDIR) $(OBJECTDIR) $(HEADERDIR)

# Name of the compiled code
EXEC = CPUEmulator

# The source code files -- search for all files that are in SOURCEDIR that end with '.c'.
SOURCES = $(wildcard $(SOURCEDIR)/*.c)

# This replaces the list of files in SOURCEDIR that end with '.c', with a list of files in OBJECTDIR that end with '.o'
OBJECTS = $(patsubst $(SOURCEDIR)/%.c, $(OBJECTDIR)/%.o, $(SOURCES))

# Now for the actual code stuffs

vpath = %.h include


# 'all' is the first command to run:  It only lists prerequisets for it to complete before running.
# First, we run the 'makeDir' command.  This will make the directories if and only if they're needed.
all: makeDir $(EXEC)

makeDir: | $(ALLDIRS)

$(ALLDIRS):
	mkdir -p $(ALLDIRS)


# This reads as:  Run:  '[CC var] [Name of func] -o [Name of prerequisits]
# Or, '-gcc CompilerEmulator -o [all object files]'.
$(EXEC): $(OBJECTS)
	$(CC) $^ -o $@

# This should compile the object files...?
# For each item in objects:  Find the 'stem', the part that fits '%.o'.  Then, compile into the file
#	objectdir/STEM.o, from the file sourcedir/STEM.c, using the command:
#	gcc -c -g -Wall [prereqName] -o [targetName]
$(OBJECTS): $(OBJECTDIR)/%.o : $(SOURCEDIR)/%.c
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm -f $(OBJECTDIR)/*.o $(EXEC)




