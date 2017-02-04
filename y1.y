%{
#include <stdio.h>
#include <string.h> 
#include <stdlib.h>
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

%token <str> PBEGIN CHR PEND NAME PHONE AWARD WEB DESG RESP EMAIL
%type <str>  info chr publist start garbage

%%
start: 
        /*empty*/
        | start info
        | start garbage
        | start chr  
        | start publist  
        ;
publist:
        PBEGIN chr PEND {
               //char *text1 = malloc(sizeof(char)*(strlen($2)+2));
               //strcpy(text1, $2); //strcat(text, "$");
               //$$ = strdup(text1);
               printf("%s\n\n",$2);
          }
        | publist PBEGIN chr PEND {
               //char *text1 = malloc(sizeof(char)*(strlen($2)+2));
               //strcpy(text1, $1);
               //strcat(text1, $3);
               //$$ = strdup(text1);
               printf("%s\n\n",$3);

          }
        ;

chr: 
        CHR {
               char *text = malloc(sizeof(char)*(strlen($1)+2));
               strcpy(text, $1); //strcat(text, "$");
               $$ = strdup(text);
          }
        | chr CHR {
                char *text = malloc(sizeof(char)*(strlen($1)+strlen($2)+2));
                strcpy(text, $1); 
                strcat(text, $2);
                $$ = strdup(text);
        }
        ;
garbage: /*empty string*/
        | garbage PEND
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
