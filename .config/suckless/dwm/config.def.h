/* See LICENSE file for copyright and license details. */

#define SESSION_FILE "/tmp/dwm-session"
#include "gaplessgrid.c"

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int focusonwheel       = 0;        /* 0 allows the user to scroll window without changing focus */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:style=Regular:size=16:antialias=true:autohint=true", "NotoColorEmoji:style=Regular:size=18" };
static const char dmenufont[]       = "monospace:size=16";
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
const char *spcmd1[] = {"st", "-n", "spterm", "-g", "120x30",  NULL };
const char *spcmd2[] = {"emcapture",  NULL };
const char *spcmd3[] = {"st", "-n", "spcalc", "-f", "monospace:size=18", "-g", "20x10", "-e", "bc", "-lq", NULL };
const char *spcmd4[] = {"st", "-n", "spfm", "-g", "96x24", "-e", "lf",  NULL };
const char *spcmd5[] = {"emdiredsp",  NULL };
const char *spcmd6[] = {"st", "-n", "spemact", "-g", "120x30", "-e", "etbuffer",  NULL };
const char *spcmd7[] = {"embuffersp",  NULL };
static Sp scratchpads[] = {
  /* name          cmd  */
  {"spterm",      spcmd1},
  {"spnote",   spcmd2},
  {"spcalc",   spcmd3},
  {"spfm",    spcmd4},
  {"spdired",   spcmd5},
  {"spemact",   spcmd6},
  {"spemacs",   spcmd7},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" };
static const int taglayouts[] = { 0, 2, 0, 2, 0, 2, 2, 2, 2, 1 }; /* taglayouts-6.4 patch modified for zeroastag patch */

/* Lockfile */
static char lockfile[] = "/tmp/dwm.lock";

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     instance  title           tags mask  isfloating  isterminal  noswallow  resizehints  monitor */
	{ "Tor Browser", NULL, NULL,           1 << 8,         0,          0,          -1,			1,        -1 },
	{ "qBittorrent", NULL, NULL,           1 << 8,         0,          0,          -1,			1,        -1 },
	{ "FileZilla",   NULL, NULL,           1 << 8,         0,          0,          -1,			1,        -1 },
	{ "st-256color", NULL, "youtube-viewer", 1 << 8,       0,          1,           0,			1,        -1 },
	{ "Pcmanfm",     NULL, NULL,           1 << 7,         0,          0,          -1,			1,        -1 },
	{ "calibre",     NULL, NULL,           1 << 7,         1,          0,          -1,			1,        -1 },
	{ "obs",         NULL, NULL,           1 << 7,         1,          0,          -1,			1,        -1 },
	{ "Gimp",        NULL, NULL,           1 << 6,         1,          0,          -1,			1,        -1 },
	{ "Inkscape",    NULL, NULL,           1 << 6,         0,          0,          -1,			1,        -1 },
	{ "Minetest",    NULL, NULL,           1 << 6,         1,          0,          -1,			1,        -1 },
	{ "signal",      NULL, NULL,           1 << 5,         0,          0,          -1,			1,        -1 },
	{ "Brave-browser", NULL, NULL,         1 << 5,         0,          0,          -1,			1,        -1 },
	{ "Alacritty",   NULL, "aerc",         1 << 5,         0,          1,           0,			1,        -1 },
	{ "st-256color", NULL, "newsraft",     1 << 5,         0,          1,           0,			1,        -1 },
	{ "qutebrowser", NULL, NULL,           1 << 1,         0,          0,          -1,			1,        -1 },
	{ "st-256color", NULL, NULL,           0,              0,          1,           0,			1,        -1 },
	{ "Alacritty",   NULL, NULL,           0,              0,          1,           0,			1,        -1 },
	{ NULL,      NULL,     "Event Tester", 0,              0,          0,           1,			1,        -1 }, /* xev */
	{ "st-256color", "spterm",	NULL,		SPTAG(0),      1,          1,           0,			1,        -1 },
	{ "Emacs",		 "spnote",	NULL,		SPTAG(1),      1,          0,          -1,			1,        -1 },
	{ "st-256color", "spcalc",	NULL,		SPTAG(2),      1,          1,          -1,			1,        -1 },
	{ "st-256color", "spfm",	NULL,		SPTAG(3),      1,          1,           0,			1,        -1 },
	{ "Emacs",		 "spdired",	NULL,		SPTAG(4),      1,          0,          -1,			1,        -1 },
	{ "st-256color", "spemact",	NULL,		SPTAG(5),      1,          1,           0,			1,        -1 },
	{ "Emacs",		 "spemacs",	NULL,		SPTAG(6),      1,          0,          -1,			1,        -1 },
};

/* layout(s) */
#define DEFAULT_MFACT 0.55
static const float mfact     = DEFAULT_MFACT; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 60;  /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "HHH",      gaplessgrid },
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

#define STATUSBAR "dwmblocks"

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-i", "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbordercolor, "-sf", selfgcolor, topbar ? NULL : "-b", NULL };
static const char *termcmd[]  = { "alacritty", NULL };
#include "shift-tools.c"
#include "exitdwm.c"
#include "movestack.c"

/* bulkill + keysequence */
static Key keyseq_quit[] = {
  /* modifier        key      function       argument */
  { 0,              XK_q,	killclient,	    {0}},
  { ControlMask,	XK_q,	killclient,	    {.ui = 1}},  // kill unselect 
  { ShiftMask,		XK_q,	killclient,	    {.ui = 2}},  // killall
  { 0,              XK_c,   exitdwm,        {0}}, // exitmenu
  { ShiftMask,      XK_c,   quit,           {1}}, // restartsig
  {0}
};

/* focusbynum + keysequence */
static Key keyseq_focus[] = {
  /* modifier        key      function       argument */
  { 0,	        	XK_n,	focusbynum,	    {.i = 0}},
  { 0,	        	XK_e,	focusbynum,	    {.i = 1}},
  { 0,	        	XK_i,	focusbynum,	    {.i = 2}},
  { 0,	        	XK_o,	focusbynum,	    {.i = 3}},
  { 0,	        	XK_t,	focusbynum,	    {.i = 4}},
  { 0,	        	XK_s,	focusbynum,	    {.i = 5}},
  { 0,	        	XK_r,	focusbynum,	    {.i = 6}},
  { 0,	        	XK_a,	focusbynum,	    {.i = 7}},
  {0}
};

/* other scratchpads + keysequence */
static Key keyseq_scratch[] = {
  /* modifier        key      function       argument */
  { 0,	        	XK_n,	togglescratch,	{.ui = 3}}, /* lf */
  { ShiftMask,	    XK_n,	togglescratch,	{.ui = 4}}, /* dired */
  { 0,	        	XK_e,	togglescratch,	{.ui = 5}}, /* emacs-terminal */
  { ShiftMask,	    XK_e,	togglescratch,	{.ui = 6}}, /* emacs */
  {0}
};

/* layouts + keysequence */
static Key keyseq_layout[] = {
  /* modifier        key      function       argument */
  { 0,	        	XK_t,	setlayout,      {.v = &layouts[0]}}, /* tiled */
  { 0,	        	XK_f,	setlayout,      {.v = &layouts[1]}}, /* floating */
  { 0,	        	XK_m,	setlayout,      {.v = &layouts[2]}}, /* monocle */
  { 0,	        	XK_g,	setlayout,      {.v = &layouts[3]}}, /* gaplessgrid */
  { ShiftMask,      XK_g,   gridall,        {}},
  { 0,              XK_o,   winview,        {0}},
  { ShiftMask,      XK_o,   winviewmono,    {}},
  {0}
};

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                   XK_bracketright, shiftviewclients,    { .i = +1 } }, /* shift-tools bindings modified */
	{ MODKEY|ShiftMask,         XK_bracketright, shiftview,           { .i = +1 } },
	{ MODKEY|ShiftMask,         XK_bracketleft,	 shiftview,           { .i = -1 } },
	{ MODKEY,	                XK_bracketleft,  shiftviewclients,    { .i = -1 } },
	{ MODKEY,                       XK_x,      spawn,          {.v = dmenucmd } }, /* remove sxhkd binding for dmenu */
	/* { MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } }, /\* sxhkd already manages programs *\/ */
	{ MODKEY|ShiftMask,             XK_b,      togglebar,      {0} }, /* sxhkd binding clash, modified */
	{ MODKEY,                       XK_n,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_e,      focusstack,     {.i = -1 } },
	{ MODKEY|ControlMask|ShiftMask, XK_n,      cycleview,      {1} }, /* cycleview + colemak */
	{ MODKEY|ControlMask|ShiftMask, XK_e,      cycleview,      {0} },
	{ MODKEY|ShiftMask,             XK_l,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_u,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_i,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_equal,  setmfact,       {.f = -1.0} },
	{ MODKEY|ShiftMask,             XK_n,      movestack,      {.i = +1 } }, /* movestack + colemak */
	{ MODKEY|ShiftMask,             XK_e,      movestack,      {.i = -1 } },
	{ MODKEY|ControlMask|ShiftMask, XK_h,      setcfact,	   {.f = +0.25} },
	{ MODKEY|ControlMask|ShiftMask, XK_i,      setcfact,	   {.f = -0.25} }, /* setcfact + colemak */
	{ MODKEY|ControlMask|ShiftMask, XK_o,      setcfact,	   {.f = 0.00} },
	{ MODKEY|ShiftMask,				XK_h,      shiftboth,      { .i = -1 } }, /* shift-tools + colemak */
	{ MODKEY|ControlMask,			XK_h,      shiftswaptags,  { .i = -1 } },
	{ MODKEY|ControlMask,			XK_i,      shiftswaptags,  { .i = +1 } },
	{ MODKEY|ShiftMask,             XK_i,      shiftboth,      { .i = +1 } },
    { MODKEY,                       XK_q,      keypress_other, {.v = keyseq_quit}}, /* bulkill + keysequence */
    { MODKEY,                       XK_c,      keypress_other, {.v = keyseq_layout}}, /* layouts + keysequence */
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY|ControlMask,           XK_space,  focusmaster,    {0} }, /* focusmaster-6.2 patch */
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
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_F5,     xrdb,           {.v = NULL } }, /* sxhkd keybind clash, modified */
    { MODKEY,	                	XK_grave,  togglescratch,  {.ui = 0 } }, /* spterm */
    { MODKEY|ShiftMask,	            XK_grave,  togglescratch,  {.ui = 1 } }, /* spnote */
    { MODKEY|ShiftMask,	            XK_equal,  togglescratch,  {.ui = 2 } }, /* spcalc */
    { MODKEY,                       XK_a,      keypress_other, {.v = keyseq_scratch}}, /* other scratchpads + keysequence */
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	TAGKEYS(                        XK_0,                      9)
    { MODKEY,                       XK_z,      keypress_other, {.v = keyseq_focus}}, /* focusbynum + keysequence */
	{0}
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
	{ ClkStatusText,        0,              Button4,        sigstatusbar,   {.i = 4} },
	{ ClkStatusText,        0,              Button5,        sigstatusbar,   {.i = 5} },
	{ ClkStatusText,        0,              6,              sigstatusbar,   {.i = 6} },
	{ ClkStatusText,        0,              7,              sigstatusbar,   {.i = 7} },
	{ ClkStatusText,        0,              8,              sigstatusbar,   {.i = 8} },
	{ ClkStatusText,        0,              9,              sigstatusbar,   {.i = 9} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

/* signal definitions */
/* signum must be greater than 0 */
/* trigger signals using `xsetroot -name "fsignal:<signum>"` */
static Signal signals[] = {
	/* signum       function        argument  */
	{ 1,            setlayout,      {.v = 0} },
};
