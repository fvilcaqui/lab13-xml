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
my $sth = $dbh->prepare("SELECT text FROM Articles WHERE (owner=?,title=?)");
$sth->execute($owner,$title);
my $texto = <STDIN>;
my $sth2 = $dbh->prepare("UPDATE Articles SET text=?");
$sth2->execute($texto);

