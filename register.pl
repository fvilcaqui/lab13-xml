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
my $firstName = $q->param("firstName");
my $lastName = $q->param("lastName");
my $sth = $dbh->prepare("INSERT INTO Users(userName,password,lastName,firstName) VALUES(?, ?, ?, ?)");
$sth->execute($userName,$passwords,$lastName,$firstName);
print "<?xml version='1.0' encoding='UTF-8'?>\n";
print <<XML;
<user>
  <userName>$userName</userName>
  <firstName>$firstName</firstName>
  <lastName>$lastName</lastName>
</user>
XML
