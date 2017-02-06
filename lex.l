%{
#include <stdio.h>
#include "y.tab.h"
extern FILE *out;

void cleanandprint(char * matchtext, char* startmark, char* endmark, int offset1, int offset2);

/*Take in the string matched by regular expressions, clean it and write it to file*/

void cleanandprint(char * yytext, char* startmark, char* endmark, int offset1, int offset2) {
	char* data = strdup(yytext); 
	char* dest = (char *)malloc(5000);
	int start = (int)(strstr(data, startmark)-data) + offset1;
	int end = (int)(strstr(data, endmark)-data) + offset2;
	if(!strstr(data, startmark) || !strstr(data, endmark)) {
		char *errmsg = "Not Found";
		yylval.str = strdup(errmsg);
		free(data); 
		free(dest);
		return;
	}
	strncpy(dest, data+start, end-start);
	dest[end-start] = '\0';
	yylval.str = strdup(dest);
	//printf("From function: %s\n", yylval.str);
	free(data); 
	free(dest);
}

%}
%%

\<h3[ \r]style=\"color:#ff0;[ \r]font-weight:[ \r]bold;\"\>.*\<\/h3\> {
																		cleanandprint(yytext, ">", "</h3>", 1, 0);
																		return NAME;}
\<i[ \r]class=\"fa[ \r]fa-phone\"\>\<\/i\>[ \t\n]*&nbsp;.*[ \t\n]*\<\/li\> {
																			char *data = strdup(yytext);
																			char processed_phone[500];
																			int index1= (int)(strstr(data,"&nbsp;")-data)+6;
																			strncpy( processed_phone, &data[index1], 15 );
																			processed_phone[15]='\0';
																			yylval.str = strdup(processed_phone);
																			return PHONE;
																			}
\<i[ \r]class=\"fa[ \r]fa-envelope\"\>\<\/i\>[ \t\n]*&nbsp;.*[ \t\n]*\<\/li\>  {
																				cleanandprint(yytext, "&nbsp;", ".in", 6, 3);
																				return EMAIL;
																				}
\<div[ \r]*id=\"collapseOne\"[ \r]class=\"accordion-body[ \r]collapse[ \r]in\"[ \r]aria-expanded=\"true\"\>[ \t\n]*\<div[ \r]class=\"accordion-inner\"\>[ \t\n]*\<ul\>[ \t\n]*\<li\>.*\<\/li\>  {
																																																cleanandprint(yytext, "<li>", "</li>", 4, 0);
																																																return RESP;
																																															}
\<p[ \r]style=\"font-weight:[ \r]bold;\"\>[ \t\n]*\<span\>.*\<\/span\> {
																		cleanandprint(yytext, "<span>", "</span>", 6, 0);
																		return DESG;
																		} 

\<a[ \r]target=\"_blank\"[ \r]href=\".*\"\>[ \t\n]*Website 				{
																		cleanandprint(yytext, "htt", "\">", 0, 0);
																		return WEB;
																		}  
\<div[ \r]style=\"height:[ \r]0px;\"[ \r]id=\"collapseseven\"[ \r]class=\"accordion-body[ \r]collapse\"\>[ \r\t\n]*\<div[ \r]class=\"accordion-inner\"\>[ \r\t\n]*\<ul\>[ \r\t\n]*\<li\>.*\<\/li\>  {
																																						cleanandprint(yytext, "<li>", "</li>", 4, 0);
																																						fprintf(out, "AWARDS\n");
																																						return AWARD;
																																						} 
\<div[ \r]class=\"tab-pane\"[ \r]id=\"resp-tab2\"\>			{fprintf(out, "PUBLICATIONS\n");} 
\<div[ \r]class=\"tab-pane\"[ \r]id=\"resp-tab3\"\> 		{fprintf(out,"PROJECTS\n"); }
\<div[ \r]class=\"tab-pane\"[ \r]id=\"resp-tab4\"\> 		{fprintf(out,"STUDENTS\n");}
\<b\>Ph\.D\.[ \r]\<\/b\>Students\<\/u\>						{fprintf(out,"PhD STUDENTS\n");}
\<b\>MS[ \r]\<\/b\>Students\<\/u\>							{fprintf(out,"MS STUDENTS\n");}
\<p\>\<span[ \r]*class=\"glyphicon[ \r]*glyphicon\-circle\-arrow\-right\"\>\<\/span\>  {
																							return LISTP_OPEN;
																						}
\([0-9]{4}\)[ \r\t\n]*\<\/p\>	 {
				//printf("%s\n", yytext);
				char year[7];
				strncpy(year, yytext+1, 4);
				year[4] = '\0'; 
				fprintf(out, "%s\n", year);
				return P_CLOSE;
			}																		     		
\<\/p\>	 {
				return P_CLOSE; 
			}
\<[^\>]*\> 				/*Ignore all tags not handled so far*/


[\n]+                      		//{fprintf(out,"\\n matched");}/* ignore end of line */;
[ \t]{2,}                  			//{fprintf(out,"\\t matched");}/* ignore whitespace */;
.                       			{ yylval.str = strdup(yytext); return TXT; }

%%

void main(int argc, char** argv) {
        if(argc<2) {
                fprintf(stderr, "Enter file name\n");
                exit(0);
        }
        char outputfname[256] = {0};
        char fname[256] = {0};
        int dotposition = strchr(argv[1], '.') - argv[1];
        strcpy(outputfname, "./databaseinp/");
        strncat(outputfname, argv[1], dotposition);
        strcat(outputfname, ".csv");
        strcpy(fname, "./fac/");
        strcat(fname, argv[1]);
        FILE * fp =fopen(fname,"r");
        out = fopen(outputfname, "a");
        yyin =fp;
        yyparse();
} 



