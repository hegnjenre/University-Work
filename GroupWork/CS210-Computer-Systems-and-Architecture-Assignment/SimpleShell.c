// standard inclusions
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

// fork inclusions
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>

// Group M3 !!!
// Demonstration Slot 12:30 Week 11

/* SINCE THERE IS NO WAY TO DETECT UP ARROW OR SIMILAR
    '^[[' TYPE COMMANDS, JUST DO NOT ENTER THEM INTO 
      THE COMMAND LINE OR ELSE HISTORY WILL BE BROKEN. */

// ==============================================================================================
// CONSTANTS
// ==============================================================================================
#define HISTORY_SIZE 20
#define MAX_INPUT 512
#define MAX_ALIASES 10
#define MAX_ALIAS_NAME 50

// ==============================================================================================
// HISTORY DATA STRUCTURE
// ==============================================================================================

/*
* HistoryEntry: stores a single command line along with its sequential command number.
* history[] : circular/shift array holding up to HISTORY_SIZE entries.
* history_count : how many entries are currently stored.
* next_index : the command number to be assigned to the next new entry.
*/
typedef struct {
int cmd_number;
char command[MAX_INPUT];
} HistoryEntry;

HistoryEntry history[HISTORY_SIZE];
int history_count = 0;
int next_index = 1;

// ==============================================================================================
// ALIAS DATA STRUCTURE
// ==============================================================================================

/*
* AliasEntry: maps a short alias name to a full command string (which may include parameters).
* aliases[] : array holding up to MAX_ALIASES entries.
* alias_count : how many aliases are currently set.
*/
typedef struct {
char name[MAX_ALIAS_NAME];
char command[MAX_INPUT];
} AliasEntry;

AliasEntry aliases[MAX_ALIASES];
int alias_count = 0;

// ==============================================================================================
// FUNCTION DECLARATIONS
// ==============================================================================================
char* prompt(char* input, char* curDir);
int forkRequest(char* command, char* arguments[]);
void addToHistory(char* commandLine);
void save_history();
void load_History();
void printAliases();
void addAlias(char* arg[]);
void removeAlias(char* arg[]);
void prIntro();
void save_aliases();
void load_aliases();

// =================================================================open=============================
// MAIN
// ==============================================================================================
int main(void) {

prIntro();

char input[MAX_INPUT];

/* Built-in command table.
* tokenArray : the command keyword.
* tokenArgSize : expected number of arguments (-1 means variable / handled internally).
* tokArrSize : number of entries in the table.
*/
const char* tokenArray[50] = {"exit", "help", "cd", "getpath", "setpath", "history", "alias", "unalias"}; 
const int tokenArgSizeMin[50] = {0, 0, 1, 0, 1, 0, 0, 1};   // minimum number of arguments taken by command                          
const int tokenArgSizeMax[50] = {0, 0, 1, 0, 1, 0, 99, 1};   // maximum number of arguments taken by command
const int tokArrSize = 8;

bool shellExit = false;
char currentDir[MAX_INPUT];
bool tooManyError = false;
bool tooFewError = false;
bool reExec = false; // true when re-executing from history (do notopen re-add to history)
bool histFail = true; // this way we don't have to check for non-numbers in history, as it will only succeed with number arguments
char* reCmd = "";
bool checkCommand = false; // for preventing failed history args from being ran as commands

// Change to home directory at startup
if (chdir(getenv("HOME")) == -1) {
printf("ErrNo: %d\n", errno);
printf("No path found...\n");
}

load_History();
load_aliases();

char* ogPath = getenv("PATH");

while (!shellExit) {

// Refresh current working directory each iteration
char* cwdOut = getcwd(currentDir, sizeof(currentDir));
if (cwdOut == NULL) {
printf("ErrNo: %d\n", errno);
printf("Working Directory Error...\n");
}

reExec = false;
checkCommand = true;
char* prompted = prompt(input, currentDir);

if (prompted == NULL) {
// ctrl-D pressed
break;
}

if (strcmp(prompted, "EmptyError") == 0) {
// Empty command line
reExec = true; // prevent empty line added to history
}
else if (strcmp(prompted, "SpaceError") == 0){
// Space at beginning of command/only space in command line
reExec = true;
printf("Please check for incorrect space at the beginning of that command.\n");
}

// Save the full command line before strtok mutates it
char cmdLine[MAX_INPUT];
strncpy(cmdLine, prompted, MAX_INPUT - 1);
cmdLine[MAX_INPUT - 1] = '\0';

char* inputPnt = strtok(prompted, " \t|<>&;");  //Splits the string into tokens by the characters defined as 'delimiters'
//strtok uses its second input string as its delimiters
int idx = 0;
int tokenNum = -1;
char* arg[512];
memset(arg, 0, sizeof(arg));


// ------------------------------------------------------------------
// HISTORY INVOCATION (!! / !<no> / !-<no>)strncat(cmd, " ", sizeof(cmd) - strlen(cmd) - 1)
// ------------------------------------------------------------------
if (inputPnt != NULL && inputPnt[0] == '!') {
  reExec = true;
  int cmdNum = 0;
  
  if (inputPnt[1] == '!') {
    // Most recent command
    cmdNum = history_count;
    printf("cmdNum: %d\n", cmdNum);
    histFail = false;
  } 
  
  else if (inputPnt[1] == '-') {
    // !-<no> : go back <no> positions from the most recent
    cmdNum = history_count - atoi(strpbrk(cmdLine, "123456789"));
    if(cmdNum <= 20){
      printf("cmdNum: %d\n", cmdNum);
      histFail = false;
    }
  } 
  
  else if (strpbrk(cmdLine, "123456789") != NULL && (cmdLine[1]) > 48 && (cmdLine[1]) <= 57) {
    // !<no>
    if(cmdLine[2] == '\0' || ((cmdLine[2]) > 48 && (cmdLine[2]) <= 57)){
      cmdNum = atoi(strpbrk(cmdLine, "123456789"));
      if(cmdNum <= 20){
        printf("cmdNum: %d\n", cmdNum);
        histFail = false;
      }
    }
  }

  if (cmdNum < 1 || cmdNum > history_count) {
    printf("There is no command at the number you entered\n");
  }

  if (!histFail) {
    char* foundCommand = history[cmdNum - 1].command;

    reCmd = malloc(strlen(foundCommand) + 1);
    strcpy(reCmd, foundCommand);

    // Re-tokenise using the retrieved command line
    inputPnt = strtok(reCmd, " \t|<>&;");
  }
  else{
    checkCommand = false; // so we don't try to use the failed history arg as a command arg
  }
}

// Build arg[] from whatever inputPnt points to
while (inputPnt != NULL) {
arg[idx] = inputPnt;
inputPnt = strtok(NULL, " \t|<>&;");
idx++;
}

// ------------------------------------------------------------------
// ALIAS CHECKING
// Check if arg[0] matches a known alias. If it does, build an
// expanded command line in aliasLine (declared here so the pointers
// in arg[] remain valid for the rest of the loop), then re-tokenise
// back into arg[]. cmdLine is untouched so history stores the alias
// name rather than the expanded command.
// ------------------------------------------------------------------
char aliasLine[MAX_INPUT * 2];
aliasLine[0] = '\0';

if (arg[0] != NULL && strcmp(prompted, "EmptyError") != 0) {
  for (int i = 0; i < alias_count; i++) {
    if (strcmp(arg[0], aliases[i].name) == 0) {

      // start with the aliased command string
      strncpy(aliasLine, aliases[i].command, sizeof(aliasLine) - 1);
      aliasLine[sizeof(aliasLine) - 1] = '\0';

      // append any extra parameters typed after the alias name
      for (int j = 1; arg[j] != NULL; j++) {
        strncat(aliasLine, " ", sizeof(aliasLine) - strlen(aliasLine) - 1);
        strncat(aliasLine, arg[j], sizeof(aliasLine) - strlen(aliasLine) - 1);
      }

      // re-tokenise the expanded line back into arg[]
      memset(arg, 0, sizeof(arg));
      idx = 0;
      char* tok = strtok(aliasLine, " \t|<>&;");
      while (tok != NULL) {
        arg[idx++] = tok;
        tok = strtok(NULL, " \t|<>&;");
      }
      break;
    }
  }
}

int argSize = (idx - 1);
int foundArgIdx = 0;

idx = 0;

// Only add non-reExec, non-empty commands to history
if (!reExec) {
addToHistory(cmdLine); // store the original (alias name) line
save_history();
}

// ------------------------------------------------------------------
// MATCH ARG[0] AGAINST BUILT-IN COMMAND TABLE
// ------------------------------------------------------------------
  while (idx < tokArrSize && tokenNum == -1 && arg[0] != NULL) {
    if (strcmp(arg[0], tokenArray[idx]) == 0) {
    tokenNum = idx;
    foundArgIdx = idx;

    if (argSize > tokenArgSizeMax[idx]){  // check if too many args
      tooManyError = true;
    }
    else if (argSize < tokenArgSizeMin[idx]){ // check if too few args
      tooFewError = true;
    }
  }
  idx++;
}

//report argument count error
  if (tooManyError == true){
    printf("Too many arguments for %s, it requires %d arguments maximum.\n", arg[0], tokenArgSizeMax[foundArgIdx]);
    tooManyError = false;
  }
  else if (tooFewError == true){
    printf("Too few arguments for %s, it requires %d arguments minimum.\n", arg[0], tokenArgSizeMin[foundArgIdx]);
    tooFewError = false;
  }

  else if ((tooFewError == false) && (tooManyError == false) && (checkCommand == true)){
// ------------------------------------------------------------------
// DISPATCH BUILT-IN COMMANDS OR FORK EXTERNAL
// ------------------------------------------------------------------

if (tokenNum == 0) {
  // exit
  shellExit = true;
  break;
} 

else if (tokenNum == 1) {
  // help
  printf("|------------------------------------------------------------------------------------------------->|\n");
  printf(" exit : closes the shell.\n");
  printf(" help : opens list of commands with descriptions.\n");
  printf(" cd <dir> : changes directory to <dir>.\n");
  printf(" setpath <dir> : changes current path to <dir>.\n");
  printf(" getpath : prints current path to the terminal.\n");
  printf(" !<no> : re-executes command number <no> from history.\n");
  printf(" !! : re-executes most recent command from history.\n");
  printf(" !-<no> : re-executes (most recent - <no>) command from history.\n");
  printf(" history : prints command history to the terminal.\n");
  printf(" alias : prints all currently set aliases.\n");
  printf(" alias <n> <c> : creates alias <n> for command <c>.\n");
  printf(" unalias <n> : removes alias <n>.\n");
  printf("|------------------------------------------------------------------------------------------------->|\n");
} 

else if (tokenNum == 2) {
  // cd <dir>
  char* fileLoc = arg[1];
  if (chdir(fileLoc) == -1) {
    printf("ErrNo: %d\n", errno);
    perror("Error");
    char* cwdOut = getcwd(currentDir, sizeof(currentDir));
    if (cwdOut == NULL) {
      printf("ErrNo: %d\n", errno);
      printf("Working Directory Error...\n");
    }
  }
}

else if (tokenNum == 3){                                   // getpath
  char* cwdOut = getenv("PATH");
  if (cwdOut == NULL){
    printf("ErrNo: %d\n", errno);
    printf("Invalid Path Error...\n");
  }
  else{
    printf("Current Path: %s\n", cwdOut);
  }
}
	      
else if (tokenNum == 4){                                    //setpath
  char* pathReq = arg[1];
  if (setenv("PATH", pathReq, 1) == -1){
    printf("ErrNo: %d\n", errno);
    perror("Error");
  }
  else{
    printf("New Path: %s\n", getenv("PATH"));
  }
}

else if (tokenNum == 5){                              // print hist
  for(int i = 0; i < history_count; i++){
    printf("%d - cmd: %s\n",  history[i].cmd_number, history[i].command);
  }
  printf("\n");
} 

else if (tokenNum == 6) {
  // alias (with or without arguments)
  if (arg[1] == NULL) {
    // No arguments: print all aliases
    printAliases();
  }
  else if (arg[2] == NULL) {
    // One argument: error — need name AND command
    printf("Error: 'alias' requires both a name and a command.\n");
    printf("Usage: alias <name> <command>\n");
  } 
  else {
    // Two or more arguments: set the alias
    addAlias(arg);
  }
}

else if (tokenNum == 7) {
  // unalias <name>
  removeAlias(arg);
} 

else if (strcmp(arg[0], "EmptyError") == 0 || (strcmp(prompted, "SpaceError") == 0)) {
// Empty input — do nothing
}

else {
// External command
  if (forkRequest(arg[0], arg) == -1) {
    printf("ErrNo: %d\n", errno);
    printf("Process forking failed, try again...\n");
  }
}
} /* End of command checking =================================================================== */

// Free malloc'd reCmd buffer after use
if (reExec && strcmp(prompted, "EmptyError") != 0 && histFail != true) {
  free(reCmd);
  reExec = false;
}
} /* End of shell loop ========================================================================= */

save_aliases(); 

// Restore original path and exit
setenv("PATH", ogPath, 1);
printf("\nRestored Path: %s\n\n\n", getenv("PATH"));
return 0;
} /* End of shell main ========================================================================== */

// ==============================================================================================
// INTRO BANNER
// ==============================================================================================

/* Prints an ASCII-art welcome banner when the shell starts. */
void prIntro(){
	printf("\n\n\n|================================>|<---------------------------------------------->|<================================|\n");
	printf("				          /^\\    /^\\ \n");
	printf("				         {  O}  {  O}                         Welcome to SnailShell\n");
	printf("				          \\ /    \\ /                            A Simple Shell Project for CS210\n");
	printf("				          //     //       _=======_               For a list of commands type help\n");
	printf("				         //     //     ./~@@@@@@@@@~-_              To exit type exit, or ctrl+D\n");
	printf("				        / ~----~/     /@@@@@@@@@@@@@@@\\\n");
	printf("				      /         :   ./@@@@@@@_---_@@@@~-\n");
	printf("				     |  \\________) :@@@@@@@/~     ~\\@@@|\n");
	printf("				     |        /    |@@@@@@|  :~~\\  |@@@|\n");
	printf("				     |       |     |@@@@@@|  \\___-~@@@@|\n");
	printf("			   	     |        \\ __/`^\\______\\.@@@@@@@@./\n");
	printf("				      \\                     ~-______-~\\.\n");
	printf("				      .|                                ~-_\n");
	printf("				     /_____________________________________~~____      Ascii Art by John Macdonald\n");
	printf("|================================>|<---------------------------------------------->|<================================|\n\n\n");
}

// ==============================================================================================
// PROMPT
// ==============================================================================================

/*
* Displays the prompt and reads a line of input from stdin.
* Returns NULL on ctrl-D, "EmptyError" for blank lines, or the input string.
*/

char* prompt(char* input, char* curDir) {
printf("%s/shell:> ", curDir);

if (fgets(input, MAX_INPUT, stdin) == NULL) {
printf("\n");
return NULL;
}

if ((strcmp(input, "\n") == 0)) {
return "EmptyError";
}
else if (input[0] == ' '){
return "SpaceError";
}

// Strip trailing newline
input[strcspn(input, "\n")] = '\0';
return input;
}

// ==============================================================================================
// EXTERNAL COMMAND EXECUTION
// ==============================================================================================

/*
* Forks a child process to execute the given external command via execvp().
* The parent waits for the child to complete.
* Returns 0 on success, -1 if fork fails.
*/
int forkRequest(char* command, char* arguments[]) {
pid_t newP = fork();
if (newP < 0) {
return -1;
}
if (newP == 0) {
// Child process
if (execvp(command, arguments) == -1) {
  printf("ErrNo: %d\n", errno);
  if (errno == 2){
    printf("Invalid Command\n");
  }
  else{
    perror("Process Error");
  }
  abort();
}

} 
else
{
// Parent process — wait for child
wait(NULL);
}
return 0;
}

// ==============================================================================================
// HISTORY FUNCTIONS
// ==============================================================================================

/*
* Adds a command line string to the history array.
* If the array is full, shifts all entries left by one to make room at the end.
* History invocations (lines starting with '!') are NOT added.
*/
void addToHistory(char* commandLine) {
HistoryEntry newEntry;
newEntry.cmd_number = next_index;
strncpy(newEntry.command, commandLine, MAX_INPUT);
newEntry.command[MAX_INPUT - 1] = '\0';

if (history_count < HISTORY_SIZE) {
history[history_count] = newEntry;
history_count++;
next_index++;
if (history_count == HISTORY_SIZE) {
next_index--; // Keep next_index at 20 once the array is full
}
} else {
// Shift left, dropping the oldest entry
for (int i = 1; i < history_count; i++) {
history[i].cmd_number--;
history[i - 1] = history[i];
}
history[HISTORY_SIZE - 1] = newEntry;
}
}

/*
* Writes the current history to ~/saved.hist_list, overwriting any previous file.
* Format: "<cmd_number> <command_line>" per line.
*/
void save_history() {
char path[MAX_INPUT];
snprintf(path, sizeof(path), "%s/.hist_list", getenv("HOME"));

FILE* fp = fopen(path, "w");
if (fp == NULL) {
  perror("Failed to open history file for writing");
  return;
}

for (int i = 0; i < history_count; i++) {
        fprintf(fp, "%d %s\n",
                history[i].cmd_number,
                history[i].command);
    }

fclose(fp);
}

/*
* Loads history from ~/saved.hist_list into the history array.
* Creates an empty file if none exists.
*/
void load_History() {
char path[MAX_INPUT];
snprintf(path, sizeof(path), "%s/.hist_list", getenv("HOME"));

FILE* fp = fopen(path, "r");
if (fp == NULL) {
  fprintf(stderr, "No history file found. Creating new history file.\n");
  fp = fopen(path, "w");
  if (fp != NULL) fclose(fp);
  return;
}

char line[MAX_INPUT + 20];
while (fgets(line, sizeof(line), fp) != NULL) {
  char *newline = strchr(line, '\n');
        if (newline) *newline = '\0';

        int cmd_num;
        char command[MAX_INPUT];

        if (sscanf(line, "%d %[^\n]", &cmd_num, command) != 2)
            continue;

        HistoryEntry entry;
        entry.cmd_number = cmd_num;
        strncpy(entry.command, command, MAX_INPUT - 1);
        entry.command[MAX_INPUT - 1] = '\0';

        if (history_count < HISTORY_SIZE) {
            history[history_count++] = entry;
        }

        if (cmd_num >= next_index) {
            next_index = cmd_num + 1;
            if (history_count == HISTORY_SIZE){
              next_index--;                      // make sure next index stays at 20 once reached again for loading
            }
        }
      }
fclose(fp);
}

// ==============================================================================================
// ALIAS FUNCTIONS
// ==============================================================================================

/*
* Prints all currently set aliases.
* Each alias is shown as: <name> -> '<command>'
* If no aliases are set, prints an informative message.
*/
void printAliases() {
  if (alias_count == 0) {
    printf("No aliases are currently set.\n");
    return;
  }
  printf("Current aliases:\n");
  for (int i = 0; i < alias_count; i++) {
    printf(" %s -> '%s'\n", aliases[i].name, aliases[i].command);
  }
}

/*
* Sets an alias: alias <name> <command [args...]>
* arg[0] = "alias", arg[1] = name, arg[2..] = command tokens.
*
* - Rebuilds the full aliased command string from arg[2] onwards.
* - If the alias name already exists, overrides it with a message.
* - If the alias table is full and the name is new, prints an error.
*/
void addAlias(char* arg[]) {
  char* name = arg[1];

  // Rebuild the full command string from all tokens after the alias name
  char cmd[MAX_INPUT];
  cmd[0] = '\0';
  for (int i = 2; arg[i] != NULL; i++) {
    if (i > 2) strncat(cmd, " ", sizeof(cmd) - strlen(cmd) - 1);
    strncat(cmd, arg[i], sizeof(cmd) - strlen(cmd) - 1);
  }

  // Check if alias already exists — if so, override it
  for (int i = 0; i < alias_count; i++) {
    if (strcmp(aliases[i].name, name) == 0) {
      printf("Alias '%s' already exists. Overriding: '%s' -> '%s'\n",
      name, aliases[i].command, cmd);
      strncpy(aliases[i].command, cmd, MAX_INPUT - 1);
      aliases[i].command[MAX_INPUT - 1] = '\0';
      return;
    }
  }

  // New alias — check there is room
  if (alias_count >= MAX_ALIASES) {
    printf("Error: Maximum number of aliases (%d) reached. Cannot add '%s'.\n",
    MAX_ALIASES, name);
    return;
  }

  // Add the new alias
  strncpy(aliases[alias_count].name, name, MAX_ALIAS_NAME - 1);
  aliases[alias_count].name[MAX_ALIAS_NAME - 1] = '\0';
  strncpy(aliases[alias_count].command, cmd, MAX_INPUT - 1);
  aliases[alias_count].command[MAX_INPUT - 1] = '\0';
  alias_count++;

  printf("Alias set: '%s' -> '%s'\n", name, cmd);
}

/*
* Removes an alias by name: unalias <name>
* arg[0] = "unalias", arg[1] = name.
*
* Shifts remaining entries left so there are no gaps in the array.
* Prints an error if the alias is not found or the table is empty.
*/
void removeAlias(char* arg[]) {
  if (alias_count == 0) {
  printf("Error: No aliases are currently set.\n");
  return;
  }

  char* name = arg[1];

  for (int i = 0; i < alias_count; i++) {
    if (strcmp(aliases[i].name, name) == 0) {
    // Shift remaining entries left to close the gap
      for (int j = i + 1; j < alias_count; j++) {
        aliases[j - 1] = aliases[j];
      }
    alias_count--;
    printf("Alias '%s' removed.\n", name);
    return;
    }
  }

  printf("Error: No alias named '%s' found.\n", name);
}

void save_aliases() {
    char path[MAX_INPUT];
    snprintf(path, sizeof(path), "%s/.aliases", getenv("HOME"));

    FILE* fp = fopen(path, "w");
    if (fp == NULL) {
        perror("Failed to open .aliases for writing");
        return;
    }

    for (int i = 0; i < alias_count; i++) {
        fprintf(fp, "%s %s\n",
                aliases[i].name,
                aliases[i].command);
    }

    fclose(fp);
}

void load_aliases() {
    char path[MAX_INPUT];
    snprintf(path, sizeof(path), "%s/.aliases", getenv("HOME"));

    FILE* fp = fopen(path, "r");
    if (fp == NULL) {
        // No aliases file yet — not an error
        return;
    }

    char line[MAX_INPUT];

    while (fgets(line, sizeof(line), fp) != NULL) {

        // Remove newline
        char* newline = strchr(line, '\n');
        if (newline) *newline = '\0';

        // First token = alias name
        char* name = strtok(line, " \t");
        if (name == NULL) continue;

        // Rest of line = command
        char* command = strtok(NULL, "");
        if (command == NULL) continue;

        // Prevent overflow
        if (alias_count >= MAX_ALIASES)
            break;

        strncpy(aliases[alias_count].name, name, MAX_ALIAS_NAME - 1);
        aliases[alias_count].name[MAX_ALIAS_NAME - 1] = '\0';

        strncpy(aliases[alias_count].command, command, MAX_INPUT - 1);
        aliases[alias_count].command[MAX_INPUT - 1] = '\0';

        alias_count++;
    }

    fclose(fp);
}
