//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "~/.local/bin/statusbar/micvol",	10,		0},
	{"", "~/.local/bin/statusbar/net",	1,		0},
	{"", "~/.local/bin/statusbar/brtt",	10,		0},
	{"", "~/.local/bin/statusbar/freedisk",	30,		0},
	{"", "~/.local/bin/statusbar/batt",	10,		0},
	{"", "~/.local/bin/statusbar/cpumem",	30,		0},
	{"", "~/.local/bin/statusbar/datime",	60,		0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " ";
static unsigned int delimLen = 5;
