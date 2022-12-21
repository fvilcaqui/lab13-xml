#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use CGI;

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.56.102";
my $dbh = DBI-> connect($dsn,$user,$password) or die ("No se pudo conectar!");

my $q = CGI->new;
print $q->header('text/xml;charset=UTF-8');

my $userName = $q->param("userName");
my $passwords = $q->param("password");
my $sth = $dbh->prepare("SELECT password FROM Users WHERE userName=?");
$sth->execute($userName);
my $contrasena;
while(my @row = $sth->fetchrow_array){
  $contrasena = $row[0];
}
my $sth2 = $dbh->prepare("SELECT firstName FROM Users WHERE userName=?");
$sth2->execute($userName);
my $firstName;
while(my @row = $sth2->fetchrow_array){
  $firstName = $row[0];
}
my $sth3 = $dbh->prepare("SELECT lastName FROM Users WHERE userName=?");
$sth3->execute($userName);
my $lastName;
while(my @row = $sth3->fetchrow_array){
  $lastName = $row[0];
}

if($contrasena = $passwords){
  print "holi";
  print "<?xml version='1.0' encoding='utf-8'?>";
  print <<XML;
  <user>
    <owner>$userName</owner>
    <firstName>$firstName</firstName>
    <lastName>$lastName</lastName>
  </user>
XML
}
else{
  print "<?xml version='1.0' encoding='utf-8'?>";
  print <<XML;
  <user>
    <owner></owner>
    <firstName></firstName>
    <lastName></lastName>
  </user>
XML
}
