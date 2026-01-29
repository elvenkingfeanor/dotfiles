/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
/* static const char *fonts[]          = { "monospace:size=10" }; */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:style=Regular:size=18:antialias=true:autohint=true", "NotoColorEmoji:style=Regular:size=20" };
static const char dmenufont[]       = "monospace:size=18";
/* static char normbgcolor[]           = "#222222"; */
/* static char normbordercolor[]       = "#444444"; */
/* static char normfgcolor[]           = "#bbbbbb"; */
/* static char selfgcolor[]            = "#eeeeee"; */
/* static char selbordercolor[]        = "#005577"; */
/* static char selbgcolor[]            = "#005577"; */
static char normbgcolor[]           = "#282c34";
static char normbordercolor[]       = "#abb2bf";
static char normfgcolor[]           = "#abb2bf";
static char selfgcolor[]            = "#282c34";
static char selbordercolor[]        = "#d19a66";
static char selbgcolor[]            = "#98c379";
static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;
/* const char *spcmd1[] = {"st", "-n", "spterm", "-g", "120x34", NULL }; */
/* const char *spcmd2[] = {"st", "-n", "spfm", "-g", "144x41", "-e", "ranger", NULL }; */
/* const char *spcmd3[] = {"keepassxc", NULL }; */
/*const char *spcmd1[] = {"alacritty", "-n", "spterm", "-o", "\"window.dimensions = { columns = 80, lines = 20}\"",  NULL };*/
const char *spcmd1[] = {"st", "-n", "spterm", "-g", "120x30",  NULL };
/* const char *spcmd2[] = {"alacritty", "-n", "spnote", "-o", "\"window.dimensions = { columns = 85, lines = 24}\"", "-e", "nvim", NULL }; */
const char *spcmd2[] = {"st", "-n", "spnote", "-g", "96x24", "-e", "nvim",  NULL };
/* const char *spcmd3[] = {"alacritty", "-n", "spcalc", "-o", "\"font.size = 18\"", "-o", "\"window.dimensions = { columns = 50, lines = 20}\"", "-e", "bc", "-lq", NULL }; */
const char *spcmd3[] = {"st", "-n", "spcalc", "-f", "monospace:size=18", "-g", "50x20", "-e", "bc", "-lq", NULL };
 static Sp scratchpads[] = {
	/* name          cmd  */
/* 	{"spterm",      spcmd1}, */
/* 	{"spranger",    spcmd2}, */
/* 	{"keepassxc",   spcmd3}, */
	{"spterm",      spcmd1},
	{"spnote",      spcmd2},
	{"spcalc",      spcmd3},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating    isterminal    noswallow   monitor */
	/* { "Gimp",	  NULL,			NULL,		0,				1,	         0,            0,		 -1 }, */
	/* { "Firefox",  NULL,			NULL,		1 << 8,			0,           0,           -1,		 -1 }, */
	/* { NULL,		  "spterm",		NULL,		SPTAG(0),		1,           1,            1,		 -1 }, */
	/* { NULL,		  "spfm",		NULL,		SPTAG(1),		1,           1,            1,		 -1 }, */
	/* { NULL,		  "keepassxc",	NULL,		SPTAG(2),		0,			 0,           -1,        -1 }, */
	/* { "St",       NULL,         NULL,       0,              0,           1,            0,        -1 }, */
	{ "obs",            NULL,        NULL,           1 << 8,    1,          0,           1,        -1 },
	{ "galculator",     NULL,        NULL,           0,         1,          0,           1,        -1 },
	{ "st-256color",    NULL,        NULL,           0,         0,          1,           0,        -1 },
	{ "Alacritty",      NULL,        NULL,           0,         0,          1,           0,        -1 },
	{ NULL,       NULL,     "Event Tester", 		 0,         0,          0,           1,        -1 }, /* xev */
	{ NULL,            "spterm",     NULL,          SPTAG(0),   1,	        1,	         1,        -1 },
	{ NULL,	           "spnote",     NULL,	        SPTAG(1),   1,	        1,	         1,        -1 },
	{ NULL,	           "spcalc",     NULL,	        SPTAG(2),   1,	        1,           1,        -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
/* static const int resizehints = 1;    /\* 1 means respect size hints in tiled resizals *\/ */
static const int resizehints = 0;    /* st leaves gaps to the right and bottom of screen otherwise */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
/* static const int refreshrate = 120;  /\* refresh rate (per second) for client move/resize *\/ */
static const int refreshrate = 60;  /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#define STATUSBAR "/usr/local/bin/dwmblocks"

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
/* /\* static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL }; *\/ */
static const char *dmenucmd[] = { "dmenu_run", "-i", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
/* /\* static const char *termcmd[]  = { "st", NULL }; *\/ */
/* static const char *termcmd[]  = { "/usr/bin/alacritty", NULL }; */
/* static const char *upvol[] = { "incvol", NULL }; */
/* static const char *downvol[] = { "decvol", NULL }; */
/* static const char *mute[] = { "smute", NULL }; */
/* static const char *mic[] = { "mmute", NULL }; */
/* static const char *micvolup[] = { "incmic", NULL }; */
/* static const char *micvoldown[] = { "decmic", NULL }; */
/* static const char *upbrtt[] = { "incbrt", NULL }; */
/* static const char *downbrtt[] = { "decbrt", NULL }; */
/* static const char *cmd_emacs[] = { "embuffer", NULL }; */
/* static const char *cmd_elfeed[] = { "emfeed", NULL }; */
/* static const char *cmd_dired[] = { "emdired", NULL }; */
/* static const char *yankbookmark[] = { "dbook", NULL }; */
/* static const char *yankpassword[] = { "dpass", NULL }; */
/* static const char *keebswitch[] = { "keebswitch", NULL }; */

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_x,      spawn,          {.v = dmenucmd } },
	/* { MODKEY,                       XK_F5,     xrdb,           {.v = NULL } }, */
	{ MODKEY|ShiftMask,             XK_F5,     xrdb,           {.v = NULL } },
	/* { MODKEY,            			XK_y,  	   togglescratch,  {.ui = 0 } }, */
	/* { MODKEY,            			XK_u,	   togglescratch,  {.ui = 1 } }, */
	/* { MODKEY,            			XK_x,	   togglescratch,  {.ui = 2 } }, */
	{ MODKEY,            			XK_grave,  	   togglescratch,  {.ui = 0 } },
	{ MODKEY|ShiftMask,            	XK_grave,	   togglescratch,  {.ui = 1 } },
	/* { MODKEY,            			XK_Num_Lock,   togglescratch,  {.ui = 2 } }, */
	{ MODKEY,            			XK_equal,      togglescratch,  {.ui = 2 } },
	/* { MODKEY,                       XK_b,      togglebar,      {0} }, */
	{ MODKEY|ShiftMask,             XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	/* { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } }, */
	/* { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } }, */
	{ MODKEY|ShiftMask,             XK_j,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      incnmaster,     {.i = -1 } },
	/* { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} }, */
	/* { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} }, */
	{ MODKEY,               XK_bracketleft,    setmfact,       {.f = -0.05} },
	{ MODKEY,   		   XK_bracketright,    setmfact,       {.f = +0.05} },
	/* { MODKEY,                       XK_Return, zoom,           {0} }, */
	{ MODKEY|ShiftMask,             XK_Tab,    zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	/* { MODKEY|ShiftMask,             XK_c,      killclient,     {0} }, */
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY|ShiftMask,             XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,             XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_Down,   moveresize,     {.v = "0x 25y 0w 0h" } },
	{ MODKEY,                       XK_Up,     moveresize,     {.v = "0x -25y 0w 0h" } },
	{ MODKEY,                       XK_Right,  moveresize,     {.v = "25x 0y 0w 0h" } },
	{ MODKEY,                       XK_Left,   moveresize,     {.v = "-25x 0y 0w 0h" } },
	{ MODKEY|ShiftMask,             XK_Down,   moveresize,     {.v = "0x 0y 0w 25h" } },
	{ MODKEY|ShiftMask,             XK_Up,     moveresize,     {.v = "0x 0y 0w -25h" } },
	{ MODKEY|ShiftMask,             XK_Right,  moveresize,     {.v = "0x 0y 25w 0h" } },
	{ MODKEY|ShiftMask,             XK_Left,   moveresize,     {.v = "0x 0y -25w 0h" } },
	{ MODKEY|ControlMask,           XK_Up,     moveresizeedge, {.v = "t"} },
	{ MODKEY|ControlMask,           XK_Down,   moveresizeedge, {.v = "b"} },
	{ MODKEY|ControlMask,           XK_Left,   moveresizeedge, {.v = "l"} },
	{ MODKEY|ControlMask,           XK_Right,  moveresizeedge, {.v = "r"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Up,     moveresizeedge, {.v = "T"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Down,   moveresizeedge, {.v = "B"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Left,   moveresizeedge, {.v = "L"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Right,  moveresizeedge, {.v = "R"} },
	/* { MODKEY,                       XK_0,      view,           {.ui = ~0 } }, */
	/* { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } }, */
	{ MODKEY,                       XK_F11,    view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_F11,    tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} }, /* reload dwm */
	/* { ControlMask|Mod1Mask,         XK_BackSpace,      quit,           {0} }, /\*Ctrl+Alt+Bksp to terminate*\/ */
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        sigstatusbar,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigstatusbar,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigstatusbar,   {.i = 3} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button1,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

