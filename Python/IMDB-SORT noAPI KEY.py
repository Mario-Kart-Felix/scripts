#  can be further worked upon using DeepLearning.ai 
# Can also incorporate other segregation methods within every rating or otherwise !
# Set up Instructions :-

# REQUIREMENTS :-
# requests, **API key from omdbapi**
import requests
import os
import shutil
# Link - > http://www.omdbapi.com/apikey.aspx
API_Key="XXXXXXXX" 				# ******IMPORTANT PART***** ENTER YOUR API KEY HERE !!!!!
# 1. Move all your movies to 1 folder -> "NEW" (any name would suffice, IGNORE "").
# 2. Create a folder "MOVIES" and move "NEW" into "MOVIES"	
# 3. Paste this script in "MOVIES"
# $. Run the Script, baby !!!
noise=["[","]","{","}","(",")",",","DVDRip","mkv","mp4","avi","AAC","RARBG","UNRATED","18+","WEB","DVDScr","XVID","AC3","HQ","HD","Hive",".","_","\\","/","\"","\"","1080","1080p","720","720p","480","480p","360","360p","144","144p","ETRG","BRRip","Blu","Ray"]
print os.getcwd()
if (((os.getcwd()).replace("/"," ")).split()[-1]).lower() !='movies':
	print "start the script from MOVIES folder !"
	exit()
err=[]
for i in range(6,10):
    if not os.path.isdir(str(i)):
        os.mkdir(str(i))
if not os.path.isdir("Below 6"): os.mkdir("Below 6")
for name in os.listdir("./NEW"):
	orig_name=name
	for nn in noise:
		name=name.replace(nn," ")
	name=name.replace("  "," ")
	ndx=0
	for s in name.split():
		if len(s)==4 and str.isdigit(s) and int(s)>1940 and int(s)<2025:
			break
		else:
			ndx+=1+len(s)
	name=name.lower()[:ndx-1]
	print name
	query_name = name
	query_name=query_name.replace(" ","+")
	imdb=requests.get("https://www.omdbapi.com/?"+"t="+query_name+"&apikey="+API_Key)
	if imdb.status_code==200:
		if ("and" in query_name.lower()) and (imdb.json()['Response'] =="False") :
			query_name=name
			query_name = query_name.replace("and","&")
			query_name=query_name.replace(" ","+")
			imdb=requests.get("https://www.omdbapi.com/?"+"t="+query_name+"&apikey="+API_Key)
		imdb=imdb.json()
		if imdb['Response']=='True':
			print "SUCCESS :-"
			print imdb['Title']+" - ",
			print imdb['imdbRating']
			rating=int(float(imdb['imdbRating']))
			title=imdb['Title'].replace(":",'-')
			if not os.path.isdir("./NEW/"+orig_name):
				os.mkdir("./NEW/"+title)
				shutil.move("./NEW/"+orig_name,"./NEW/"+title)
				orig_name=title 
			if(rating<6):
				shutil.move("./NEW/"+orig_name,"Below 6/"+title)
			else:
				shutil.move("./NEW/"+orig_name,str(rating)+"/"+title)
		else:
			err.append(str(query_name)+" NOT IN IMDB DATABASE")
	else:
		err.append(query_name)
print str(len(err))+" Movies Not Found "
for i in err:
    print i