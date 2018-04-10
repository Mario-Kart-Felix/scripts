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
	print name[:ndx-1]
	movie_name = name[:ndx-1]
	movie_name=movie_name.replace(" ","+")
	print (movie_name+" -- Trying... ")
	imdb=requests.get("https://www.omdbapi.com/?"+"t="+movie_name+"&apikey="+API_Key)
	if imdb.status_code==200:
		if imdb.json()['Response']=='True':
			print "SUCCESS :-"
			print imdb.json()['Title']+" - ",
			print imdb.json()['imdbRating']
			rating=int(float(imdb.json()['imdbRating']))
			title=imdb.json()['Title'].replace(":",'-')
			if not os.path.isdir("./NEW/"+orig_name):
				os.mkdir("./NEW/"+title)
				shutil.move("./NEW/"+orig_name,"./NEW/"+title)
				orig_name=title 
			if(rating<6):
				shutil.move("./NEW/"+orig_name,"Below 6/"+title)
			else:
				shutil.move("./NEW/"+orig_name,str(rating)+"/"+title)
		else:
			err.append(str(movie_name)+" NOT IN IMDB DATABASE")
	else:
		err.append(movie_name)
print str(len(err))+" Movies Not Found "
for i in err:
    print i