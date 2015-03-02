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

############################ MÓDULOS QUE ESTÃO SENDO USADOS E SERÃO USADOS FUTURAMENTE
use warnings;
use strict;
use Net::Twitter;
use Data::Dumper;
use Scalar::Util 'blessed';
use WWW::Mechanize;
use Getopt::Long;
use utf8;
use Term::ANSIColor;

############################ CODIFICAÇÃO utf8 NA ENTRADA E SAÍDA DO SCRIPT
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

############################ CRIAÇÃO DE VARIÁVEIS
my ($baner1, $baner2, $SO, $limpar_tela, $url, $tuitar, $unfollow, $follow, $mech );
$baner1 = "
\t\t\t████████╗██╗    ██╗██╗
\t\t\t╚══██╔══╝██║    ██║██║
\t\t\t   ██║   ██║ █╗ ██║██║
\t\t\t   ██║   ██║███╗██║██║
\t\t\t   ██║   ╚███╔███╔╝██║
\t\t\t   ╚═╝    ╚══╝╚══╝ ╚═╝";

$baner2 = "
\t\t\t██████╗ ███████╗██████╗ ██╗     
\t\t\t██╔══██╗██╔════╝██╔══██╗██║     
\t\t\t██████╔╝█████╗  ██████╔╝██║     
\t\t\t██╔═══╝ ██╔══╝  ██╔══██╗██║     
\t\t\t██║     ███████╗██║  ██║███████╗
\t\t\t╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝
\t\t\t                              v1.0\n\n";

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
    'tuitar'        => \$tuitar,
    'unfollow'      => \$unfollow,
    'follow'        => \$follow,
);

############################ CONDIÇÕES
if ( $tuitar ) {

    return tuitar();

} elsif ( $unfollow ) {

    return unfollow();

} elsif ( $follow ) {
    
    return follow();
    
} else {
    print color ('bold blue');
    print $baner1;
    print color ('reset');
    print $baner2;

    print "Digite o comando de ajuda para saber os argumentos que podem ser usados\n";
    exit (0);

}


############################ SUB ROTINAS PARA SE USAR O CLIENTE
sub tuitar () {
    print color ('bold blue');
    print $baner1;
    print color ('reset');
    print $baner2;

    print "Digite uma tweet de ate 140 caracteres!\n";
    print "-> ";
    my $tuitar = <STDIN>; chomp $tuitar;

    print "\n";
    print "Publicando tweet...";

    $nt -> update ({ status => "$tuitar" });

    print "\n";
    print "Tweet publicado com sucesso!\n\n";
    print "Essa e sua mensagem -> $tuitar\n";
    exit (0);
}

sub unfollow () {
    print color ('bold blue');
    print $baner1;
    print color ('reset');
    print $baner2;

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

    $nt->unfollow ({ id => "$unfollow" });

    print "Twitter ID $unfollow foi des-seguido\n";
    exit (0);    
}

sub follow () {
    print color ('bold blue');
    print $baner1;
    print color ('reset');
    print $baner2;

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
    
    print "Twitter ID $follow foi seguido\n";
    exit (0);
}