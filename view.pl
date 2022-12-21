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
my $owner = $q->param("userName");
my $title = $q->param("title");
my $sth = $dbh->prepare("SELECT text FROM Articles WHERE owner=?");
$sth->execute($owner);

while(my @row = $sth->fetchrow_array){
  my @nuevo = split("\n",$row[0]);
  my $filas = " ";
  foreach my $i (@nuevo){
        $filas .= markdown($i);
 } 
print renderPagina($filas);
}

sub markdown{
 my $line = $_[0];
 if($line =~ /^#([^#].*)/){
   return "<h1>".$1."</h1>\n";
 }elsif($line =~ /^##([^#].*)/){
   return "<h2>".$1."</h2>\n";
 }elsif($line =~ /^######([^#].*)/){
   return "<h6>".$1."</h6>\n";
 }elsif($line =~ /^\*\*([^#].*)\*\*$/){
   return "<p><strong>".$1."<strong><p>\n";
 }elsif($line =~ /^\*([^#].*)\*$/){
   return "<p><em>".$1."</em></p>\n";
 }elsif($line =~ /^~~([^#].*)~~$/){
   return "<p>~".$1."~~</p>\n";
 }elsif($line =~ /^\*\*\*([^#].*)\*\*\*$/){
   return "<p><strong><em>".$1."</em></strong></p>\n";
 }elsif($line =~ /git status/){
 }elsif($line =~ /git add/){
 }elsif($line =~ /git commit/){
 }elsif($line =~ /^\*([^#].*)\*$/){
   return "<p>".$1."<a href='".$2.">" .$3."</a.</p>\n";
 }else{
    return $_[0];
 }
}
sub renderpagina{
  my $body = $_[0];
  print "<?xml version='1.0' encoding='UTF-8'?>";
  my $xml = <<XML;
     $body;
XML
  return $xml
}
