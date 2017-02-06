%{
#include <stdio.h>
#include <string.h> 
#include <stdlib.h>
extern FILE *yyin;
FILE *out;

void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}

int yywrap() {
        return 1;
} 
  
%}

%union {
        char *str;
}

%token <str> LISTP_OPEN TXT P_CLOSE NAME PHONE AWARD WEB DESG RESP EMAIL
%type <str>  info txt lists start ignore

%%
start: 
        /*empty*/
        | start info
        | start ignore
        | start txt  
        | start lists  
        ;
lists:
        LISTP_OPEN txt P_CLOSE {
               fprintf(out,"%s\n\n",$2);
          }
        | lists LISTP_OPEN txt P_CLOSE {
               fprintf(out,"%s\n\n",$3);

          }
        ;

txt: 
        TXT {
               char *s = malloc(strlen($1)+2);
               strcpy(s, $1); 
               $$ = strdup(s);
          }
        | txt TXT {
                char *s = malloc(strlen($1)+strlen($2)+2);
                strcpy(s, $1); 
                strcat(s, $2);
                $$ = strdup(s);
        }
        ;
ignore: /*empty string*/
        | ignore P_CLOSE
        ;

info:   NAME { fprintf(out,"NAME$%s\n",$1); }
        | PHONE { fprintf(out,"PHONE$%s\n",$1);}
        | WEB { fprintf(out,"WEB$%s\n",$1); fflush(NULL); }
        | AWARD { fprintf(out,"%s\n",$1); }
        | DESG { fprintf(out,"DESG$%s\n",$1); }
        | EMAIL { fprintf(out,"EMAIL$%s\n",$1); }
        | RESP {fprintf(out,"RESP$%s\n",$1); }
        ;

%%
