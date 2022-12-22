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

my $owner = $q->param("owner");
my $title = $q->param("title");
my $text = $q->param("text");
my $sth = $dbh->prepare("INSERT INTO Articles(title,owner,text) VALUES(?,?,?)");
$sth->execute($title,$owner,$text);
my $sth2 = $dbh->prepare("SELECT owner FROM Articles WHERE owner=?");
$sth2->execute($owner);
my $probar;
while(my @row = $sth2->fetchrow_array){
  $probar = $row[0];
}
if($owner = $probar){
print "<?xml version='1.0' encoding='UTF-8'?>";
print <<XML;
<article>
  <title>$title</title>
  <text>$text</text>
</article>
XML
}else{
print "<?xml version='1.0' encoding='UTF-8'?>";
print <<XML;
<article>
  <title></title>
  <text></text>
</article>
XML

}

