%{
#include <stdio.h>
#include <string.h> 
extern FILE *yyin;
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
} 
  
main()
{
        FILE * p =fopen("./fac/shamik.html","r");
        yyin =p;
        yyparse();
} 

%}

%union {
        char *str;
}

%token <str> NUMBER TOKHEAT STATE TOKTARGET TOKTEMPERATURE DUMY NBSP NAME PHONE AWARD

%%
name:
        NAME{ printf("%s\n",$1);}
        ;
phone:
        PHONE {printf("%s\n",$1);}
        ;
award:
        AWARD {printf("%s\n",$1);}
        ;        
commands: /* empty */
        | commands command
        ;

command:
        heat_switch
        |
        target_set
        ;

heat_switch:
        TOKHEAT STATE
        {
                printf("\tHeat turned on or off\n");
        }
        ;

target_set:
        TOKTARGET TOKTEMPERATURE NUMBER
        {
                printf("\tTemperature set\n");
        }
        | NUMBER
        ;
phone:
        DUMY NBSP{printf("%s\n",$2);}

%%
