@echo off
git clone https://github.com/brute4s99/competitive
git clone https://github.com/brute4s99/games
md DotCTheProgrammingClub
cd DotCTheProgrammingClub
git clone https://github.com/DotC-TheProgrammingClub/assignment_sols
git clone https://github.com/DotC-TheProgrammingClub/in_sessions
cd ..
md PyJAMAx64
cd PyJAMAx64
git clone https://github.com/brute4s99/PyJAMAx64/
ren PyJAMAx64 master
git clone https://github.com/brute4s99/PyJAMAx64/
cd PyJAMAx64
git checkout SWITCHES
cd ..
ren PyJAMAx64 SWITCHES

git clone https://github.com/brute4s99/PyJAMAx64/
cd PyJAMAx64
git checkout misc
cd ..
ren PyJAMAx64 misc

git clone https://github.com/brute4s99/PyJAMAx64/
cd PyJAMAx64
git checkout CLEANER
cd ..
ren PyJAMAx64 CLEANER
cd ..
git clone https://github.com/brute4s99/scripting
git clone https://github.com/brute4s99/webd

sleep 10s
cls
echo ALL DONE !
sleep 2s