FD stamtavle q queries
---------------
kat. 4 stats til Charly 2017-10-15

#Find alle Kat. 4 katte med FD nummer og en fødselsdato, sorteret efter fødselsdato
# NOTE: substr(c5,7,4)||substr(c5,4,2)||substr(c5,1,2) as DOB
# for at konvertere dato til sorterbart format.

q   -d ';' -e UTF-8  "SELECT  substr(c5,7,4)||substr(c5,4,2)||substr(c5,1,2) as DOB, *  FROM all_kat4.csv WHERE  substr(c6,1,3)  IN ('FD ','(DK') AND C5 != '...' AND substr(c5,7,4) > '19890000' ORDER BY DOB"

# Kat.4 med FD nummer of fødselsdato - Antal katte registreret per år siden 1990
# Note: brugt substr(c6,1,3)  IN ('FD ','(DK') da reg nr. fra 2010 og frem hedder '(DK)FD '

q   -d ';' -e UTF-8  "SELECT  count(*),substr(c5,7,4) as DOB  FROM all_kat4.csv WHERE  substr(c6,1,3)  IN ('FD ','(DK') AND C5 != '...' AND DOB > '19890000' group by substr(DOB,1,4)"





---------------
# find alle OSH med sjældne farver (n < 4) 
q -e UTF-8  "SELECT c4,c3 FROM comp*.csv WHERE c4 IN (SELECT c4 FROM comp*.csv WHERE c4 LIKE 'OSH%'  GROUP BY c4 HAVING COUNT(*) < 4) ORDER BY c4"

# find alle OLH med sjældne farver (n < 4) 
q -e UTF-8  "SELECT c4,c3 FROM comp*.csv WHERE c4 IN (SELECT c4 FROM comp*.csv WHERE c4 LIKE 'OLH%'  GROUP BY c4 HAVING COUNT(*) < 4) ORDER BY c4"

# Find alle unikater i en race
q -e UTF-8  "SELECT COUNT(*),c4,c3 FROM comp*.csv WHERE c4 LIKE 'OLH%'  GROUP BY c4 HAVING COUNT(*) =1 "

# find sorteret hyppighed af EMS koder for en race (her ABY)
q -e UTF-8  "SELECT COUNT(*),c4 FROM comp*.csv WHERE c4 LIKE 'ABY%'  GROUP BY c4 ORDER BY COUNT(*) ASC  "
	1,ABY x b
	1,ABY x f
	3,ABY ps
	4,ABY x c
	18,ABY as
	132,ABY os
	234,ABY p
	446,ABY ns
	603,ABY a
	1984,ABY o
	4352,ABY n



# antal af hver race (virker kun i den nye pipe-separeret udgave pipe_all.csv)
q -e UTF-8 -b "SELECT COUNT(*),substr(c4,1,3) FROM pipe_all.csv  GROUP BY substr(c4,1,3) ORDER BY COUNT(*)" 
#send til wc -l for at finde ud at der er 54 racer + "..." = ukendt

1    |ACS
1    |ASS
1    |BOM
1    |SFL
1    |SYL
7    |NEM
7    |THA
18   |AMS
27   |SNO
33   |CYM
39   |GRX
53   |SFS
56   |ACL
58   |SYS
62   |DSP
65   |KBS
69   |...
69   |SIN
69   |SRL
81   |SRS
141  |JBT
149  |PEB
172  |XLH
176  |MAU
184  |SOK
221  |OLH
289  |CHA
312  |XSH
313  |MAN
319  |KBL
459  |KOR
518  |TUA
769  |BAL
950  |TUV
1091 |OCI
1103 |BML
1155 |DRX
1374 |EUR
1413 |SPH
1421 |SIB
1751 |CRX
2425 |RUS
2914 |BEN
3535 |SOM
3815 |OSH
4461 |EXO
4635 |RAG
5746 |BUR
8006 |ABY
8071 |SIA
13934|BRI
15134|SBI
25361|NFO
34655|MCO
46601|PER

#Find matador-hanner i hele stambogen
jq -b "SELECT c7, COUNT(*) FROM pipe_all.csv GROUP BY c7  HAVING COUNT(*) > 50 ORDER BY COUNT(*) DESC"

#List matadorhanner med alle data
jq -b "SELECT c1,c2,c3 ,c4,c5,c6 FROM pipe_all.csv WHERE c1 IN (SELECT c7 FROM pipe_all.csv GROUP BY c7  HAVING COUNT(*) > 50)"

#antal matador-hanner (over 100 afkom) per race
jq -b "SELECT substr(c4,1,3), count(*) FROM pipe_all.csv WHERE c1 IN (SELECT c7 FROM pipe_all.csv GROUP BY c7  HAVING COUNT(*) > 100) GROUP BY substr(c4,1,3)"
BRI|5
MCO|4
NFO|10
PER|8
SBI|6
SIA|4

og ved > 50 afkom:
ABY|3
BEN|3
BML|2
BRI|41
BUR|9
EUR|3
EXO|3
MCO|55
NFO|74
OSH|5
PER|78
RAG|5
RUS|6
SBI|42
SIA|13

(=63867) ~/Documents/github/Pedigraph/grab/fd_data/temp> grep SIA FD_matador_over50.csv 
520   |M|(N)Hesno-Briom's Cutty Sark           |SIA c 21    |28-09-1990|FD LO 73732        
8051  |M|Ayanth Diacanthus                     |SIA a       |18-06-2000|FD LO 107275       
19780 |M|Chiton Romeo                          |SIA n       |05-03-1996|FD RX 11386        
23107 |M|Dan-Thai's Ieyasu                     |SIA b       |01-07-1991|FD LO 64050        
28903 |M|DK Aslan's Balder                     |SIA b       |26-04-1996|FD LO 85473        
30347 |M|DK Balsatzar's Archontos              |SIA a       |15-04-1990|FD LO 58970        
57916 |M|DK Haslund's Tato                     |SIA n 21    |26-07-1999|FD LO 101333       
144282|M|Loui Braun Brimiso                    |SIA n       |13-05-1989|FD LO 54837        
150036|M|Melinar Sweet Prince                  |SIA n       |24-06-1990|FD LO 61086        
156617|M|Nissen's Vimmer                       |SIA a       |15-04-1998|FD LO 94786        
157602|M|Okonor Hakuna Matata                  |SIA b       |17-01-1995|FD LO 101599       
182246|M|Sweet Cat's Nights In White Satin, JW |SIA n       |24-04-2003|FD LO 121606       
185971|M|Tiptap-Tomtom's Asterion              |SIA n       |03-05-1995|FD LO 82522        
(=63867) ~/Documents/github/Pedigraph/grab/fd_data/temp> grep OSH FD_matador_over50.csv 
10727 |M|Bellamis' Finlandia                   |OSH b       |07-07-2001|FD LO 111191       
113903|M|DK Wee-Ko's Against all odds          |OSH n       |25-01-1994|FD LO 74974        
123137|M|FIN*Feanorian Bow Wow                 |OSH c       |14-07-2007|FD LO 153253       
175971|M|Sepp 92-150                           |OSH n 24    |08-09-1992|FD LO 69184        
180217|M|Sphinx Boy Wonder                     |OSH n       |11-05-1991|FD LO 63294 

#JOIN with parents
jq "SELECT cat.c1,cat.c2,cat.c3, sire.c1,sire.c2,sire.c3, dam.c1,dam.c2,dam.c3 from sbi.csv as cat JOIN sbi.csv as sire ON cat.c7 = sire.c1 JOIN sbi.csv as dam ON cat.c8 = dam.c1" |wc -l

#UNION
#one select of all "parents"
jq "select distinct c8 from sbi.csv union select distinct c7 from sbi.csv"

#Måske: hvor mange afkom er gået videre i avl fra hver top matador i SBI:
jq "select c7, count(*) from sbi.csv WHERE c7 in (select c7 from sbi.csv group by c7 having count(*) > 100) AND c1 in (select distinct c8 from sbi.csv union select distinct c7 from sbi.csv) group by c7" 
130475|22
167978|30
62063|19
72024|30
8027|26
8446|14

DK Jente's Sonny Boy Auranu		144	19
	DK Silky Sox Nugget			 92	19
		DK Søkjærs Grinni		 57	 7
			DK Shengo Ali Baba 	 30	 3
				Awak Sinklair	125	26
								448	74

Felis Britannica Stamtavle DB
#search
http://www.felisbritannica.co.uk/cgi-bin/breeding.pl?op=search&pattern=Mandix&gens=4&db=FB.dbw
http://www.felisbritannica.co.uk/cgi-bin/geneal.pl?op=tree&index=56853&gens=2&db=FB.dbw
http://www.felisbritannica.co.uk/cgi-bin/pedigree.pl?op=tree&index=56853&gens=2&db=FB.dbw
http://www.felisbritannica.co.uk/cgi-bin/breeding.pl?op=breeding&index=56853&gens=2&db=FB.dbw
http://www.felisbritannica.co.uk/cgi-bin/reverse.pl?op=tree&index=56853&gens=2&db=FB.dbw
http://www.felisbritannica.co.uk/cgi-bin/trial.pl?db=FB.dbw

#Find average littersize (first query should also be qualified by FD LO/RX to avoid misleading numbers due to imports)
jq -b "select count(*),c7,c8,c5 from pipe_all.csv where substr(c4,1,3) = 'SBI' group by c7,c8,c5" >> littersize_sbi.csv
#then
jq -b "select avg(c1) from littersize_sbi.csv"



## Kat. 4
#####################################################
Find alle katte der ikke er Kat. 4 men har Kat.4 som forældre
#####################################################
Først med Kat.4 mødre
q "select c1,c2,c3,c4,c5,c6,c7,c8 from all.csv where c8 in (select c1 from all.csv where substr(c4,1,3) in ('OLH', 'OSH', 'SIA', 'BAL','SYS','SYL','PEB')) and NOT substr(c4,1,3) in ('OLH', 'OSH', 'SIA', 'BAL','SYS','SYL','PEB')" 
#####################################################
791|F|(N)Manhunter's Define The World|XSH n 09|02-03-2012|(DK)FD RX 210670|121992|799
797|M|(N)Manhunter's Mygodwhata Face|XSH  b 03|02-03-2012|(DK)FD RX 210673|121992|799
805|M|(N)Manhunter's Year In Review|XSH  b 09|02-03-2012|(DK)FD RX 210671|121992|799
3416|M|Alf Rusty Rushik|XSH d 21|...|SL-039/06/PBD|156659|177556
3998|M|Alosaka of Shaman's Desires|ACL fy 23|02-07-2006|LOS 06-23963|190174|176476
5232|F|Angelica's Campari|XSH n|13-01-1994|FD RX REG 1724|7309|5242
5272|M|Angelica's Quark|XSH n|13-01-1994|FD RX REG 1726|7309|5242
5273|F|Angelica's Quille|XSH b|13-01-1994|FD RX REG 1723|7309|5242
5281|M|Angelica's Samson|XSH b|13-01-1994|FD RX REG 1722|7309|5242
5283|M|Angelica's Siam|XSH n|13-01-1994|FD RX REG 1725|7309|5242
5599|F|Annabell del Iris|NFO g 09 24|31-07-2006|SRK RX 90343|193263|4094
6459|F|Ariadne v. Ayudhya|RUS|...|1.DEKZV EXP 1195|136143|144501
28346|M|DK Arjuna's Aqua|SIB fs 09 24|09-11-2007|FD LO 153787|50260|28363
28360|M|DK Arjuna's Fætter Lavben|SIB fs 09 24|04-03-2010|(DK)FD LO 159147|28354|28367
51685|M|DK Filihankats Durrdana|SBI b|06-09-2013|(DK)FD LO 215813|51711|118921
86755|M|DK Nyx Illidan Stormrage|SRL non f|24-10-2008|FD LO 156079|131565|131564
90273|M|DK Petheaven Captain James Kelly|XSH b br|11-03-2012|(DK)FD RX 209201|132095|90282
95369|F|DK Sacala's Delta Delight|SIB fs 09 24|29-10-2007|FD LO 153598|192299|50248
111466|M|DK Uthsen's Rollo|SIB ny 09 23|08-02-2008|FD LO 153933|129233|141275
114000|F|DK Wee-Ko's Vanilla MadeForPleasure|GRX n 03|14-06-2008|FD LO 155050|122874|113989
114003|F|DK Wee-Ko's Wanna Be Me|XSH n 22|14-06-2008|FD LO 155048|122874|113989
119681|F|Elca of The Talking Cats|...|...|MMOE LO 944222|133393|193046
136111|F|Jympems Chocolato Dream|XSH b 22|...|GCCF CSREF 003381|140485|155270
155391|F|Nebetta Chudesnaya Koshka|TUA d 09 21|...|(RUS)PR-4/02/00024|15622|121964
156899|F|Nora del Iris|TUA a 09 22|...|HK-157/06-PBD|18239|128194
161714|F|Pippastro Peaceblossum|EXO gs 03 23|...|1.DEKZV RX 324131|161717|161713
162122|M|Poker-Face von Begrow|EXO cs|...|DRV 043337-LH Bd.XXII|13957|179057
165311|M|Red Bull of Ene's|SPH d 21|...|SNVK 03-11-005K|22315|135303
166326|F|Romanxx Ridgette|MAN x d 09 22|14-05-2000|CFA 3621-1339062 V0602|166321|167077
167863|M|S*Azoo Dobby|NFO gs 09 21|05-05-2007|FD RX 153435|189109|167883
167870|M|S*Azoo Frost|ACL as 33|12-03-2007|FD RX 153387|137284|50250
167871|M|S*Azoo Griphook|TUV a 21 62|05-05-2007|FD RX 153436|189109|167883
167877|M|S*Azoo Kreacher|NFO gs 09 21|05-05-2007|FD RX 153434|189109|167883
167882|F|S*Azoo Maximelle af Yum-Yum|MCO g 02|10-08-2007|FD LO 153385|120958|167890
179584|M|Solitaire Coqo|XSH bs 09|...|GCCF EX 64946|4494|179586
180473|F|Sphinx Vesper Lynd|MCO ns 01|05-05-2006|FD RX 152244|1474|180364
180479|F|Sphinx White Cloud|MCO ns 01|05-05-2006|FD RX 152245|1474|180364
183209|F|Tachimas' Arsene, JW|DRX c 21 32|...|(D)DEKZV RX 312308|119601|183210
183785|F|Tari|SPH n 22|...|DVDK LOB 25.411|150749|187727
189177|F|Venera Feona|TUA n 24|...|(RUS)KTF 00160/02-PBD|23042|126288
190174|M|Voltan de Memam Chao Phraya|ACL a|...|CFB 05/20050017|6274|188111
193008|F|Yashma Black|PER n|...|HK-E/170/03-PBD|15587|22147

#####################################################
Så med Kat 4 fædre 
(=63867) ~/Documents/github/Pedigraph/grab/fd_data/temp/graphgist> q "select c1,c2,c3,c4,c5,c6,c7,c8 from all.csv where c7 in (select c1 from all.csv where substr(c4,1,3) in ('OLH', 'OSH', 'SIA', 'BAL','SYS','SYL','PEB')) and NOT substr(c4,1,3) in ('OLH', 'OSH', 'SIA', 'BAL','SYS','SYL','PEB')" 
#####################################################
791|F|(N)Manhunter's Define The World|XSH n 09|02-03-2012|(DK)FD RX 210670|121992|799
797|M|(N)Manhunter's Mygodwhata Face|XSH  b 03|02-03-2012|(DK)FD RX 210673|121992|799
805|M|(N)Manhunter's Year In Review|XSH  b 09|02-03-2012|(DK)FD RX 210671|121992|799
5599|F|Annabell del Iris|NFO g 09 24|31-07-2006|SRK RX 90343|193263|4094
13957|M|Bodyguard von Begrow|EXO es 03|...|DRV 041279-LH|122466|122468
16389|M|Calenacat's Oscar|BML es 11|...|(D)DEKZV LO 335286|157661|183209
20973|F|Coldenufforsnow Elmau|NFO nt s 22|...|GB CA RX 00064413|150035|21822
25013|F|Djesika|KBL f 03|...|AC-KBT/04-0410|134799|193164
28346|M|DK Arjuna's Aqua|SIB fs 09 24|09-11-2007|FD LO 153787|50260|28363
28360|M|DK Arjuna's Fætter Lavben|SIB fs 09 24|04-03-2010|(DK)FD LO 159147|28354|28367
51685|M|DK Filihankats Durrdana|SBI b|06-09-2013|(DK)FD LO 215813|51711|118921
86755|M|DK Nyx Illidan Stormrage|SRL non f|24-10-2008|FD LO 156079|131565|131564
90273|M|DK Petheaven Captain James Kelly|XSH b br|11-03-2012|(DK)FD RX 209201|132095|90282
95369|F|DK Sacala's Delta Delight|SIB fs 09 24|29-10-2007|FD LO 153598|192299|50248
111466|M|DK Uthsen's Rollo|SIB ny 09 23|08-02-2008|FD LO 153933|129233|141275
114000|F|DK Wee-Ko's Vanilla MadeForPleasure|GRX n 03|14-06-2008|FD LO 155050|122874|113989
114003|F|DK Wee-Ko's Wanna Be Me|XSH n 22|14-06-2008|FD LO 155048|122874|113989
119681|F|Elca of The Talking Cats|...|...|MMOE LO 944222|133393|193046
133549|M|Jack in the Box vom Grutholz|SRL non c 09|...|EC-SEL-R-0503-215|186282|164064
156899|F|Nora del Iris|TUA a 09 22|...|HK-157/06-PBD|18239|128194
161714|F|Pippastro Peaceblossum|EXO gs 03 23|...|1.DEKZV RX 324131|161717|161713
167870|M|S*Azoo Frost|ACL as 33|12-03-2007|FD RX 153387|137284|50250
167882|F|S*Azoo Maximelle af Yum-Yum|MCO g 02|10-08-2007|FD LO 153385|120958|167890
168266|F|S*Bonfamille's Nora Norella|SBI a|29-04-2003|(SE)SVERAK LO 190276|121502|168264
172400|M|S*Rovårexen's Alvin Coolcat|DRX as 24|31-01-2003|SVERAK RX 188032|170929|173333
174803|F|Sangeorge Miss Bronte|DRX fs 09|...|(GB)GCCF CS 392595|176678|183365
176360|M|Shango Natural Elegance|NFO gs 03|...|(RUS)IPR-2/04/00103|123378|155391
180473|F|Sphinx Vesper Lynd|MCO ns 01|05-05-2006|FD RX 152244|1474|180364
180479|F|Sphinx White Cloud|MCO ns 01|05-05-2006|FD RX 152245|1474|180364
183209|F|Tachimas' Arsene, JW|DRX c 21 32|...|(D)DEKZV RX 312308|119601|183210
183509|F|Tamila of Natural Elegance|NFO gs 09 21|...|(RUS)IPR-4/03/00034|192895|189177
189177|F|Venera Feona|TUA n 24|...|(RUS)KTF 00160/02-PBD|23042|126288
190174|M|Voltan de Memam Chao Phraya|ACL a|...|CFB 05/20050017|6274|188111
193008|F|Yashma Black|PER n|...|HK-E/170/03-PBD|15587|22147

#####################################################
Find alle Kat. 4 katte med en mor der ikke er Kat. 4
#####################################################
 q "select c1,c2,c3,c4,c5,c6,c7,c8 from all.csv where substr(c4,1,3) in ('OLH', 'OSH', 'SIA', 'BAL','SYS','SYL','PEB') AND NOT c8 = '' AND NOT c8 in (select c1 from all.csv where substr(c4,1,3) in ('OLH', 'OSH', 'SIA', 'BAL','SYS','SYL','PEB')) "
#####################################################
2554|F|African Moon Shadow of Golden Haze DK|PEB c 21 33|22-05-2010|(DK)FD RX 159059|135928|59603
4094|F|Alvina del Iris|PEB a 33|...|HK-165/06-PBD|121770|193008
12809|F|Black Silk of Golden Haze DK|PEB c 21 33|04-05-2010|(DK)FD RX 159055|135928|177155
12840|F|Black Velvet of Golden Haze DK|PEB c 21 33|04-05-2010|(DK)FD RX 159056|135928|177155
16385|F|Calenacat's I-xtreme of Okonor|OSH n 03|...|(DE)DEKZV LO 330714|157661|183209
16723|F|Candy Akkari Ainu|OLH ns 23|...|(RUS)AB-194/KBT/2006|193842|147669
18630|F|Chanteur Choco Chanel|OLH o 24|...|1.DEKZV RX 324132|129591|161714
27255|M|DK Amorito's Black Sabbath|PEB a 21|03-05-2010|(DK)FD RX 158837|150456|1049
33090|F|DK Birkehøj's Black Diamond|PEB c 21 33|06-11-2008|FD RX 155874|178130|143826
36387|M|DK Cajmajs Kenzo|OLH b 03 23|17-06-2008|FD RX 155197|8213|70336
66770|F|DK Kivi star's Asta|PEB f 21|17-10-2008|FD LO 155773|84937|39405
72063|F|DK Ligaen Gucci|OSH as 25|26-03-2010|(DK)FD RX 158722|123063|72071
84322|M|DK Need Fur? Chunky Monkey|OLH b 03|28-04-2008|FD LO 155130|17295|84338
85544|F|DK Noer's golden delight|OLH x w 63|14-04-2007|FD RX 152187|151223|72913
95271|F|DK Rønholms Choko|SIA n|...|FD RX 4182|131833|7515
120597|M|Enrico from Sham|PEB d 33|...|Kat ID: 317441|144148|166021
122925|F|FIN*Birregin No Doubt|PEB b 21 33|05-08-2007|FD RX 153251|142775|5599
126670|F|Getera|PEB n 21 33|...|(RUS)KTF 00222/03-PBD|15589|118384
128947|F|Gyurtsutarjan Twilight|SIA h|...|NKFV RVT 48.641|155970|128946
131263|F|Honda del Iris|PEB b 21 33|07-02-2005|HK-158/06-PBD|145272|156899
137851|F|Kiara from Sham|PEB c 21|...|EC-SEL-LO-8231RIEX/6.06|120603|140667
143476|M|Linkret Arctic Slippers|SYS a 03|...|CA RX 88081030|16253|143478
157130|F|Nyx of Golden Haze DK|PEB c 21 33|10-02-2010|(DK)FD RX 158601|135928|7669
161717|M|Pippastro Silversmith|OLH ns 22|...|1.DEKZV RX 324129|161715|6154
163642|M|Python of Golden Haze DK|PEB c 21 33|10-02-2010|(DK)FD RX 158599|135928|7669
170929|M|S*Lur Per's Jonathan Rex|OSH g 03 25|08-11-2001|SVERAK RX 175063|173453|170928
175649|F|Scintilla Pied Piper|OSH n 03|...|CA RX 85022103|175635|175137
175651|F|Scintilla Pot Pourri|OSH f 03 24|...|CA RX 85022104|175635|175137
179057|F|Smoky Ultra von Begrow|PEB e 33|...|DRV 041113-LH|122466|119277
180405|F|Sphinx Pussy Galore|OSH f 23|10-04-2007|FD LO 152397|122814|180473
180457|F|Sphinx Tiffany Case, JW|OSH g 24|10-04-2007|FD LO 152398|122814|180473
183607|M|Tanholt' Kompromis|OSH d 25|...|FD RX 4484|183587|183586
#####################################################
Find alle Kat. 4 katte med en mor der ikke er Kat. 4
#####################################################
 q "select c1,c2,c3,c4,c5,c6,c7,c8 from all.csv where substr(c4,1,3) in ('OLH', 'OSH', 'SIA', 'BAL','SYS','SYL','PEB') AND NOT c7 = '' AND NOT c7 in (select c1 from all.csv where substr(c4,1,3) in ('OLH', 'OSH', 'SIA', 'BAL','SYS','SYL','PEB')) "
#####################################################
2554|F|African Moon Shadow of Golden Haze DK|PEB c 21 33|22-05-2010|(DK)FD RX 159059|135928|59603
7057|F|Ashti Dea Merkaba*PL|PEB c|19-04-2010|(DK)FD RX 201020 RR|20838|8705
12809|F|Black Silk of Golden Haze DK|PEB c 21 33|04-05-2010|(DK)FD RX 159055|135928|177155
12840|F|Black Velvet of Golden Haze DK|PEB c 21 33|04-05-2010|(DK)FD RX 159056|135928|177155
15588|M|Bronislav|PEB n 21 33|...|TARC CBA-635-PD/EXP|18219|
16723|F|Candy Akkari Ainu|OLH ns 23|...|(RUS)AB-194/KBT/2006|193842|147669
18084|M|Celandine's Brian Arno Jack|PEB g|19-09-2007|FD RX 154897|129275|
27255|M|DK Amorito's Black Sabbath|PEB a 21|03-05-2010|(DK)FD RX 158837|150456|1049
27279|F|DK Amorito's Over the Rainbow|OLH n 21|24-01-2010|(DK)FD LO 158419|7412|158709
27281|M|DK Amorito's That's Amoré|OLH x|24-01-2010|(DK)FD LO 158420|7412|158709
33090|F|DK Birkehøj's Black Diamond|PEB c 21 33|06-11-2008|FD RX 155874|178130|143826
36387|M|DK Cajmajs Kenzo|OLH b 03 23|17-06-2008|FD RX 155197|8213|70336
66770|F|DK Kivi star's Asta|PEB f 21|17-10-2008|FD LO 155773|84937|39405
72063|F|DK Ligaen Gucci|OSH as 25|26-03-2010|(DK)FD RX 158722|123063|72071
84322|M|DK Need Fur? Chunky Monkey|OLH b 03|28-04-2008|FD LO 155130|17295|84338
85544|F|DK Noer's golden delight|OLH x w 63|14-04-2007|FD RX 152187|151223|72913
120597|M|Enrico from Sham|PEB d 33|...|Kat ID: 317441|144148|166021
137851|F|Kiara from Sham|PEB c 21|...|EC-SEL-LO-8231RIEX/6.06|120603|140667
142468|F|Laura von Amor|BAL g|...|DEKZV 299069|16401|150958
157130|F|Nyx of Golden Haze DK|PEB c 21 33|10-02-2010|(DK)FD RX 158601|135928|7669
158709|F|Osaka Akkari Ainu|OLH b 23|02-12-2007|(DK)FD RX 158195|143916|16723
163642|M|Python of Golden Haze DK|PEB c 21 33|10-02-2010|(DK)FD RX 158599|135928|7669
167853|M|S*Azoo Bogrod|PEB b|05-05-2007|FD RX 153438|189109|167883
167891|M|S*Azoo Ragnok|PEB b 33|05-05-2007|FD RX 153437|189109|167883
170929|M|S*Lur Per's Jonathan Rex|OSH g 03 25|08-11-2001|SVERAK RX 175063|173453|170928
177372|F|Siamesis I Love You|OSH n|25-04-2009|FD LO 156982|16389|16387
186282|M|Tom Cruise vom Grutholz|PEB g|...|EC-SEL-0702-091|7779|
189099|F|vDerAltenWeide Penelope|OLH g|07-06-2007|FD LO 153250|3998|177163





Graph gist arbejde:
Find alle kat4 katte og børn:
q "select c1,c2,c3,c4,c5,c6,c7,c8 from all.csv where substr(c4,1,3) in ('OLH', 'OSH', 'SIA', 'BAL','SYS','SYL','PEB') OR c7 in (select c1 from all.csv where substr(c4,1,3) in ('OLH', 'OSH', 'SIA', 'BAL','SYS','SYL','PEB')) OR c8 in (select c1 from all.csv where substr(c4,1,3) in ('OLH', 'OSH', 'SIA', 'BAL','SYS','SYL','PEB'))" > kat4all.csv

head -50 kat4.csv >> k4test.csv


q "select '(c'||c1||':Cat {id:#'||c1||'#, gender:#'||c2||'#}), (c'||c1||')-[:IS_BREED]->('||lower(substr(c4,1,3))||'),' from kat4all.csv" | sed -e 's/#/\"/g' > all_kat4_cats_n_breed.cypher

q "select '(c'||c1||')-[:SIRE]->(c'||c7||'),' from kat4all.csv where not c7 = ''" > all_kat4_sire_relations.cypher

