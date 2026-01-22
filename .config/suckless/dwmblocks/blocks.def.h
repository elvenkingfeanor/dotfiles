//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "~/.local/bin/statusbar/micvol",	5,		0},
	{"", "~/.local/bin/statusbar/net",	5,		0},
	{"", "~/.local/bin/statusbar/brtt",	5,		0},
	{"", "~/.local/bin/statusbar/freedisk",	20,		0},
	{"", "~/.local/bin/statusbar/batt",	10,		0},
	{"", "~/.local/bin/statusbar/cpumem",	10,		0},
	{"", "~/.local/bin/statusbar/datime",	60,		0},
	{"", "~/.local/bin/statusbar/keebstate",	5,		0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " ";
static unsigned int delimLen = 5;
