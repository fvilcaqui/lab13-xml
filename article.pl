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

my $owner = $q->param("userName");
my $title = $q->param("title");
my $sth = $dbh->prepare("SELECT text FROM Articles WHERE (owner=?,titulo=?)");
$sth->execute($owner,$title);

while(my @row = $sth->fetchrow_array ){
print "<?xml versio '1.0' encoding='UTF-8'?>";
print <<XML;
<article>
  <owner>$owner</owner>
  <title>$title</tile>
  <text> @row </text>
XML
}
print "</article>";
$sth->finish;
$dbh->disconnect;
