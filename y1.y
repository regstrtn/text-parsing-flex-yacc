%{
#include <stdio.h>
#include <string.h> 
extern FILE *yyin;
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap() {
        return 1;
} 
  
void main(int argc, char** argv) {
        if(argc<2) {
                fprintf(stderr, "Provide filename\n");
                exit(0);
        }
        char fname[256] = {0};
        strcpy(fname, "./fac/");
        strcat(fname, argv[1]);
        FILE * p =fopen(fname,"r");
        yyin =p;
        yyparse();
} 

%}

%union {
        char *str;
}

%token <str> NAME PHONE AWARD WEB DESG RESP EMAIL

%%
start: 
        /*empty*/
        | start info
        ;

info:   name
        | phone
        | web
        | award
        | desg
        | email
        | resp
        ;
name:
        NAME { 
               printf("%s\n",$1);
        }
        ;
phone:
        PHONE { 
                printf("%s\n",$1);
        }
        ;
award:
        AWARD { 
                printf("%s\n",$1);
        }
        ;        
email: 
        EMAIL {
                printf("%s\n",$1);
        }
        ;
desg: 
        DESG {
                printf("%s\n",$1);
        }
        ;
web:   
        WEB {
                printf("%s\n",$1);
        }
        ;  
resp: 
        RESP {
                printf("%s\n",$1);
        }
        ;
%%
