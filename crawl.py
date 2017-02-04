from bs4 import BeautifulSoup
import requests
import re

def storepage(curr_url):
	#__add url to base url__
	base_url = "http://www.iitkgp.ac.in"
	proper_url = base_url + curr_url
	#__extracting faculty name from the url.__ 
	start = proper_url.find('-')+1
	end = proper_url.find(';',start)
	filename = proper_url[start:end]+ ".html"
	
	f= open("./fac/"+filename,'w') 
	r = requests.get(proper_url[:end])
	data  = r.text
	data = re.sub('data:image/jpeg;base64.*>', "searchforme>", data)
	data = re.sub('[ \r\t]+', ' ', data)
	data = re.sub('[\n]+', '\n', data)
  
	f.write(data)
	f.close()

def extractUrl():
	url = "http://www.iitkgp.ac.in/department/CS"
	r  = requests.get(url)
	data = r.text
	soup = BeautifulSoup(data)
	all_url =[]
	for link in soup.find_all('a'):
	    
	    curr_url = link.get('href')
	    if curr_url is not None:
	    	if "/department/CS/faculty/cs-" in curr_url:
	    		print (curr_url)
	    		all_url.append(curr_url)
	    		storepage(curr_url)
				

extractUrl()
