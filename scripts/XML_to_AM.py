# encoding=utf8
import sys
#reload(sys)
from importlib import reload
#sys.setdefaultencoding('utf8')

import xml.etree.ElementTree as ET
tree = ET.parse('gamelist.xml')
root = tree.getroot()

import re
a = open('my_text_file.txt', 'w')
a.write ("#Name;Title;Emulator;CloneOf;Year;Manufacturer;Category;Players;Rotation;Control;Status;DisplayCount;DisplayType;AltRomname;AltTitle;Extra;Buttons" + '\n')
a.close()

for game in root.iterfind('game'):
	path = game.find('path').text
	if path == None:
		path = ''
	else:
		path = re.sub("\.[^.]*$", "", path)

	name = game.find('name').text
	if name == None: name = ''

	developer = game.find('developer')
	if developer == None:
		developer = ''
	else:
		developer = developer.text
	if developer == None:
		developer = ''

	genre = game.find('genre')
	if genre == None:
		genre = ''
	else:
		genre = genre.text
	if genre == None:
		genre = ''

	players = game.find('players')
	if players == None:
		players = ''
	else:
		players = players.text
	if players == None:
		players = ''

	releasedateX = game.find('releasedate')
	if releasedateX == None: 
		releasedate = ''
	else:
		releasedateY = releasedateX.text
	#if releasedateY == None: 
	#	releasedate = ''
	#else:
		a = re.finditer("^[0-9]{4}", releasedateY) 
		releasedate = next(a).group()

	f = open('my_text_file.txt', 'a+')
	f.write (path + ';' + name + ';' + "EMULATOR-REPLACE" + ';' + ';' + releasedate + ';' + developer + ';' + genre + ';' + players + ';;;;;;;;;;;;;;;;;;' + '\n')
	f.close()
