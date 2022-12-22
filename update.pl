#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.56.102";
my $dbh = DBI-> connect($dsn,$user,$password) or die ("No se pudo conectar!");
my $q = CGI->new;
print $q->header('text/xml;charset=UTF-8');
my $owner = $q->param("owner");
my $title = $q->param("title");
my $text = $q->param("text");
my $sth = $dbh->prepare("UPDATE Articles SET text=? WHERE owner=? AND title=?");
$sth->execute($text,$owner,$title);
print "<?xml verion='1.0' encoding='UTF-8'?>";
print <<XML;
<article>
 <title>$title</title>
 <text>$text</text>
</article>
XML


