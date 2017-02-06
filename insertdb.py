from __future__ import print_function
import os
import sys

'''
INSERT INTO table_name ( field1, field2,...fieldN )
                       VALUES
                       ( value1, value2,...valueN );
'''

def insert(table, qfields, qval):
  qfile = open("query.sql", "a")
  qstring = "INSERT INTO "+table+" "+" ("+qfields+") VALUES ("+qval+");"
  qfile.write(qstring+"\n")
  qfile.close()


def readfile(fname, facname):
  f = open(fname,'r');
  line = f.readline()
  line.strip()
  qfields = ""
  qval = ""
  name = ""
  while(line!=''):
    if("$" in line):
      valtoinsert = line.split('$')[1]
      valtoinsert = valtoinsert.rstrip("\n")
    if("PUBLICATIONS" in line or "AWARDS" in line):
      break
    if("NAME" in line):
      qfields = qfields + "name" + ","
      qval = qval + "'" + valtoinsert + "',"
      name = valtoinsert
    if("DESG" in line):
      qfields = qfields + "designation" + ","
      qval = qval + "'" + valtoinsert + "',"
    if("WEB" in line):
      qfields = qfields + "website" + ","
      qval = qval + "'" + valtoinsert + "',"
    if("EMAIL" in line):
      qfields = qfields + "email" + ","
      qval = qval + "'" + valtoinsert + "',"
    if("PHONE" in line):
      qfields = qfields + "phone" + ","
      qval = qval + "'" + valtoinsert + "',"
    if("RESP" in line):
      qfields = qfields + "responsibility" + ","
      qval = qval + "'" + valtoinsert + "',"
    if("RESAREA" in line):
      qfields = qfields + "research_area" + ","
      qval = qval + "'" + valtoinsert + "',"
    line = f.readline()  
  qval = qval[:-1]
  qfields = qfields[:-1]
  insert("info", qfields, qval)
  
  if("AWARDS" in line):
    qfields = ""
    qval = ""
    qfields = "name, award"
    line = f.readline()
    award = line.rstrip('\r\n')
    qval = qval + "'" + name + "','" + award + "'"
    insert("awards", qfields, qval)
    line = f.readline()
  
  qfields = ""
  qval = ""
  if("PUBLICATIONS" in line):
    line = f.readline() #Advance one line after publication
    ''' Insert publications '''
    qfields = "name, year, title"
    while(line!=''):
      if('PROJECTS' in line or 'STUDENTS' in line):
        break
      year = int(line)
      title = f.readline()
      tile = title.rstrip('\r\n')
      f.readline()
      qval = ""
      qval = qval + "'" + name + "',"
      qval = qval + str(year) + ","      
      qval = qval + "'" + title[:-1] + "',"
      qval = qval[:-1]
      insert("publications", qfields, qval)
      line = f.readline()

  qval = ""
  qfields = "name, title"
  line = f.readline()
  while(line!=''):
    if('STUDENTS' in line):
      break
    title = line.rstrip('\r\n')
    qval = ""
    qval = qval + "'" + name + "',"
    qval = qval + "'" + title + "',"
    qval = qval[:-1]
    insert("projects", qfields, qval)
    line = f.readline()
    if(line[0] == '\n'):
      line = f.readline()
  
  qval = ""
  qfields = "name, student_name, student_type, student_research_area"
  line = f.readline()
  student_type = line.rstrip('\r\n')
  
  while(line!=''):
    if('STUDENTS' in line):
      student_type = line.rstrip('\r\n')
      line = f.readline()
      line = line.rstrip('\r\n')
    if('Area of Research:' in line):
      splitname = line.split('Area of Research:')
      student_name = splitname[0]
      r_area = splitname[1].rstrip('\n\r')
    else: 
      student_name = line
      r_area = ""
    qval = ""
    qval = qval + "'" + name + "',"
    qval = qval + "'" + student_name + "',"
    qval = qval + "'" + student_type + "',"
    qval = qval + "'" + r_area + "',"
    qval = qval[:-1]
    insert("students", qfields, qval)
    line = f.readline()
    if(line[0] == '\n'):
      line = f.readline()


deletestring = "delete from info where 1;\ndelete from publications where 1;\ndelete from students where 1;\ndelete from projects where 1;\ndelete from awards where 1;\n"

def main():
  #os.remove("query.sql")
  qfile = open("query.sql", "w")
  qfile.write(deletestring)
  qfile.close()
  files = os.listdir("./databaseinp")
  for fname in files:
    readfile("./databaseinp/"+fname, fname)


if __name__=='__main__':
  main()