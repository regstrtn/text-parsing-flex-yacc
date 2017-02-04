%{
#include <stdio.h>
#include "y.tab.h"

%}
%%

\<h3[ \r]style=\"color:#ff0;[ \r]font-weight:[ \r]bold;\"\>.*\<\/h3\> {
																		char *data = strdup(yytext);
																		char processed_data[500];
																		int index1= (int)(strchr(data,'>')-data)+1;
																		int index2 = (int)(strstr(data,"</h3>")-data);
																		memcpy( processed_data, &data[index1], index2-index1 );
																		processed_data[index2-index1]='\0';
																		yylval.str = strdup(processed_data);
																		return NAME;}

\<i[ \r]class=\"fa[ \r]fa-phone\"\>\<\/i\>[ \t\n]*&nbsp;.*[ \t\n]*\<\/li\> {
																			char *data = strdup(yytext);
																			char processed_phone[16];
																			int index1= (int)(strstr(data,"&nbsp;")-data)+6;
																			memcpy( processed_phone, &data[index1], 15 );
																			processed_phone[15]='\0';
																			yylval.str = strdup(processed_phone);
																			return PHONE;
																			}

\<i[ \r]class=\"fa[ \r]fa-envelope\"\>\<\/i\>[ \t\n]*&nbsp;.*[ \t\n]*\<\/li\>  {
																				char *data = strdup(yytext);
																				char processed_data[500];
																				int index1= (int)(strstr(data,"&nbsp;")-data)+6;
																				int index2 = (int)(strstr(data,".in")-data)+3;
																				memcpy( processed_data, &data[index1], index2-index1 );
																				processed_data[index2-index1]='\0';
																				yylval.str = strdup(processed_data);
																				return EMAIL;
																				}

\<div[ \r]*id=\"collapseOne\"[ \r]class=\"accordion-body[ \r]collapse[ \r]in\"[ \r]aria-expanded=\"true\"\>[ \t\n]*\<div[ \r]class=\"accordion-inner\"\>[ \t\n]*\<ul\>[ \t\n]*\<li\>.*\<\/li\>  {
																																																char *data = strdup(yytext);
																																																char processed_data[500];
																																																int index1= (int)(strstr(data,"<li>")-data)+4;
																																																int index2 = (int)(strstr(data,"</li>")-data);
																																																memcpy( processed_data, &data[index1], index2-index1 );
																																																processed_data[index2-index1]='\0';
																																																yylval.str = strdup(processed_data);
																																																return RESP;}
\<p[ \r]style=\"font-weight:[ \r]bold;\"\>[ \t\n]*\<span\>.*\<\/span\> {
																		char *data = strdup(yytext);
																		char processed_data[500];
																		int index1= (int)(strstr(data,"<span>")-data)+6;
																		int index2 = (int)(strstr(data,"</span>")-data);
																		memcpy( processed_data, &data[index1], index2-index1 );
																		processed_data[index2-index1]='\0';
																		yylval.str = strdup(processed_data);
																		return DESG;
																		} 

\<a[ \r]target=\"_blank\"[ \r]href=\".*\"\>[ \t\n]*Website 				{
																		char *data = strdup(yytext);
																		char processed_data[500];
																		int index1= (int)(strstr(data,"htt")-data);
																		int index2 = (int)(strstr(data,"\">")-data);
																		memcpy( processed_data, &data[index1], index2-index1 );
																		processed_data[index2-index1]='\0';
																		yylval.str = strdup(processed_data);
																		return WEB;
	
																		}  
\<div[ \r]style=\"height:[ \r]0px;\"[ \r]id=\"collapseseven\"[ \r]class=\"accordion-body[ \r]collapse\"\>[ \r\t\n]*\<div[ \r]class=\"accordion-inner\"\>[ \r\t\n]*\<ul\>[ \r\t\n]*\<li\>.*\<\/li\>  {
																																						char *data = strdup(yytext);
																																						char processed_data[500];
																																						int index1= (int)(strstr(data,"<li>")-data)+4;
																																						int index2 = (int)(strstr(data,"</li>")-data);
																																						memcpy( processed_data, &data[index1], index2-index1 );
																																						processed_data[index2-index1]='\0';
																																						yylval.str = strdup(processed_data);
																																						return AWARD;
																																						} 
\<p\>\<span[ \r]*class=\"glyphicon[ \r]*glyphicon\-circle\-arrow\-right\"\>\<\/span\>  {
																							return PBEGIN;
																		     			}

\<\/p\>	 {
				return PEND;
			}

\<[^\>]*\> 				/*Ignore all tags not handled so far*/


[ \n]+                      		//{printf("\\n matched");}/* ignore end of line */;
[ \t]+                  			//{printf("\\t matched");}/* ignore whitespace */;
.                       			{ yylval.str = strdup(yytext); return CHR; }

%%
