#!/usr/bin/perl
#
# USE, EDITE, COMPILE. MAS SEMPRE DISTRIBUA O CÓDIGO FONTE!
# CONHECIMENTO DEVE SER LIVRE E DE TODOS!
#
# CODED BY: HackerOrientado
#
# Me sigam no twitter -> @HackerOrientado
# Facebook -> facebook.com/CalsEvolution
# Página Ciência Hacker -> facebook.com/CienciaHacker
# Grupo Ciência Hacker -> facebook.com/groups/cienciahacker/
# Página no Facebook do Inurl Brasil -> facebook.com/InurlBrasil
# Blog Inurl Brasil -> blog.inurl.com.br/
#
# Obrigado ao GoogleINURL e ao @7mm5l pela força que me deram o conhecimento de como usar regex tanto nesse quanto no BypassCF
# Link do BypassCF -> github.com/HackerOrientado/BypassCF
#
# Obrigado ao meu amigo do Ciência Hacker, Franco Colombino por me ajudar no baner :D
#

############################ MÓDULOS QUE ESTÃO SENDO USADOS E SERÃO USADOS FUTURAMENTE
use warnings;
use strict;
use Net::Twitter;
use Data::Dumper;
use Scalar::Util 'blessed';
use WWW::Mechanize;
use Getopt::Long;
use utf8;

############################ CODIFICAÇÃO utf8 NA ENTRADA E SAÍDA DO SCRIPT
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

############################ CRIAÇÃO DE VARIÁVEIS
my ($baner, $SO, $limpar_tela, $url, $ajuda, $tuitar, $unfollow, $follow, $mech, $fav );
$baner = "
\e[1;34m
\t\t\t████████╗██╗    ██╗██╗
\t\t\t╚══██╔══╝██║    ██║██║
\t\t\t   ██║   ██║ █╗ ██║██║
\t\t\t   ██║   ██║███╗██║██║
\t\t\t   ██║   ╚███╔███╔╝██║
\t\t\t   ╚═╝    ╚══╝╚══╝ ╚═╝\e[0m
\t\t\t██████╗ ███████╗██████╗ ██╗
\t\t\t██╔══██╗██╔════╝██╔══██╗██║
\t\t\t██████╔╝█████╗  ██████╔╝██║
\t\t\t██╔═══╝ ██╔══╝  ██╔══██╗██║
\t\t\t██║     ███████╗██║  ██║███████╗
\t\t\t╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝
\t\t\t                              v1.1\n\n";

############################ VERIFICAÇÃO DO SISTEMA OPERACIONAL PARA LIMPEZA DE TELA
$SO = $^O;
if ( $SO eq "MSWin32" ) {
    $limpar_tela = "cls";
} else {
    $limpar_tela = "clear";
}

system ("$limpar_tela");

############################ KEYS DE DESENVOLVEDOR
my $consumer_key = 'ENTRE COM SUA CHAVE DE DESENVOLVEDOR AQUI';
my $consumer_secret = 'ENTRE COM SUA CHAVE DE DESENVOLVEDOR AQUI';
my $access_token = 'ENTRE COM SUA CHAVE DE DESENVOLVEDOR AQUI';
my $access_token_secret = 'ENTRE COM SUA CHAVE DE DESENVOLVEDOR AQUI';

############################ KEYS
my $nt = Net::Twitter->new (
    traits              => ['API::RESTv1_1', 'OAuth'],
    consumer_key        => $consumer_key,
    consumer_secret     => $consumer_secret,
    access_token        => $access_token,
    access_token_secret => $access_token_secret,
);

############################ INICIANDO AUTENTICAÇÃO COM O Net::Twitter
my $nt = Net::Twitter->new (
    traits              => ['API::RESTv1_1', 'OAuth'],
    consumer_key        => $consumer_key,
    consumer_secret     => $consumer_secret,
    access_token        => $access_token,
    access_token_secret => $access_token_secret,
);

############################ ARGUMENTOS
my $args = GetOptions (
    'ajuda'         => \$ajuda,
    'tuitar'        => \$tuitar,
    'unfollow'      => \$unfollow,
    'follow'        => \$follow,
    'fav'           => \$fav,
);

############################ CONDIÇÕES
if ( $ajuda ) {

  return ajuda();

} elsif ( $tuitar ) {

    return tuitar();

} elsif ( $unfollow ) {

    return unfollow();

} elsif ( $follow ) {

    return follow();

} elsif ( $fav ) {

    return fav();

} else {
    system "$limpar_tela";
    print $baner;

    print "Argumento não reconhecido D:\n";
    print "Digite o comando de ajuda ( -ajuda ) para saber os argumentos que podem ser usados :D\n\n";
    sleep 1;
    exit (0);

}


############################ SUB ROTINAS PARA SE USAR O CLIENTE
sub ajuda() {
    print $baner;

    print "\t\t\t  [\?] COMANDO DE AJUDA [\?]\n\n";
    print "Modo de usar:\n";
    print "perl TwiPerl.pl -[ARGS]\n\n\n";

    print "\t\t  [\!] ARGUMENTOS QUE PODEM SER USADOS [\!]\n\n";
    print "-tuitar          Tuíta na sua linha do tempo\n";
    print "-follow          Segue um usuário ( Ex: HackerOrientado )\n";
    print "-unfollow        Des-segue um usuário ( Ex: HackerOrientado )\n";
    print "-fav             Favorita um tweet de algum usuário\n";
    print "\n";
    exit (0);
}

sub tuitar () {
    print $baner;

    print "Digite uma tweet de ate 140 caracteres!\n";
    print "-> ";
    my $tuitar = <STDIN>; chomp $tuitar;

    print "\n";
    print "Publicando tweet...";

    $nt -> update ({ status => "$tuitar" });

    print "\n";
    print "Tweet publicado com sucesso!\n\n";
    print "Essa e sua mensagem -> $tuitar\n\n";
    exit (0);
}

sub unfollow () {
    print $baner;

    print "Digite o ID do usuario a ser des-seguido\n";
    print "--> ";
    $unfollow = <STDIN>; chomp $unfollow;

    $url = "http://gettwitterid.com/?user_name=".$unfollow."0&submit=GET+USER+ID";
    $mech = WWW::Mechanize->new();

    $mech->get ( $url );
    $mech->content ( format => 'text' );


    if ( $mech =~ /Twitter User ID: (\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9})/ ) {
        $unfollow = $1;
    }

    $nt -> unfollow ({ id => "$unfollow" });

    print "Twitter ID $unfollow foi des-seguido\n\n";
    exit (0);
}

sub follow () {
    print $baner;

    print "Digite o usuario do usuario a ser seguido\n";
    print "--> ";
    $follow = <STDIN>; chomp $follow;

    $url = "http://gettwitterid.com/?user_name=".$follow."0&submit=GET+USER+ID";
    $mech = WWW::Mechanize->new();

    $mech->get ( $url );
    $mech->content ( format => 'text' );

    if ( $mech =~ /Twitter User ID: (\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9}\d{1,9})/ ) {
        $follow = $1;
    }

    $nt->follow ({ id => "$follow" });

    print "Twitter ID $follow foi seguido\n\n";
    exit (0);
}

sub fav () {
    print $baner;

    print "Digite o ID do status para favoritar\n";
    print "--> ";
    $fav = <STDIN>; chomp $fav;

    $nt -> create_favorite ({ id => $fav });

    print "Tweet ID $fav foi 'favoritado'\n\n";
    exit (0);
}
