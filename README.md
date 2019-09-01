# Debug perl coding for client, which annoy me, he said you should fix this issue within a day.

# Shit ,Since your code over 5000 lines; I never touch your code before,  even through it's sample logic,I am not a expert programmer!

```
jimmy@jimmy-YOGA:~/Downloads/perl/resman$ cat /tmp/tc.cfg
redis    redisdb04      6789           eth0      716
redis    redisdb03      6789           eth0      716
redis    redisdb02      7779           eth0      793         
redis    redisdb01      6789           eth0      718         
jimmy@jimmy-YOGA:~/Downloads/perl/resman$ sh start.sh 
jimmy@jimmy-YOGA:~/Downloads/perl/resman$ -----------precheck------------
[RESULT]: Check redis instance redisdb02 cg resource successfully!
-----------precheck------------
[RESULT]: Check redis instance redisdb02 cg resource failed!
-----------doconfig------------
-----------donecheck------------
[RESULT]: Check redis instance redisdb02 cg resource successfully!
-----------precheck------------
[RESULT]: Check redis instance redisdb02 cg resource failed!
-----------doconfig------------
-----------donecheck------------
[RESULT]: Check redis instance redisdb02 cg resource successfully!

jimmy@jimmy-YOGA:~/Downloads/perl/resman$ cat /tmp/tc.cfg
redis    redisdb04      6789           eth0      716
redis    redisdb03      6789           eth0      716
redis    redisdb02      7779           eth0      798         
redis    redisdb01      6789           eth0      718         
jimmy@jimmy-YOGA:~/Downloads/perl/resman$ sh start.sh 
jimmy@jimmy-YOGA:~/Downloads/perl/resman$ -----------precheck------------
[RESULT]: Check redis instance redisdb02 cg resource failed!
-----------doconfig------------
-----------donecheck------------
[RESULT]: Check redis instance redisdb02 cg resource successfully!
-----------precheck------------
[RESULT]: Check redis instance redisdb02 cg resource failed!
-----------doconfig------------
-----------donecheck------------
[RESULT]: Check redis instance redisdb02 cg resource successfully!
-----------precheck------------
[RESULT]: Check redis instance redisdb02 cg resource failed!
-----------doconfig------------
-----------donecheck------------
[RESULT]: Check redis instance redisdb02 cg resource successfully!

jimmy@jimmy-YOGA:~/Downloads/perl/resman$ cat /tmp/tc.cfg
redis    redisdb04      6789           eth0      716
redis    redisdb03      6789           eth0      716
redis    redisdb02      7779           eth0      799         
redis    redisdb01      6789           eth0      718         
jimmy@jimmy-YOGA:~/Downloads/perl/resman$ cat start.sh 
./resman.pl redis redisdb02  7779 eth0 798 &
./resman.pl redis redisdb02  7779 eth0 799 &
./resman.pl redis redisdb02  7779 eth0 793 &

```
