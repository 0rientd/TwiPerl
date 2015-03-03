# TwiPerl v1.0

Script distribuído sobe licença GPL v3.
Leia sobre a licença para saber mais.

--------------

TwiPerl é um client de Twitter feito para linha de comando em linguagem Perl.

Ele conta com 3 funções por enquanto, como:

* Tuítar
* Seguir pessoas colocando o nome de usuário ( *SEM ARROBA* )
* Des-seguir pessoas colocando o nome de usuário ( *SEM ARROBA* )

Em breve colocarei mais funções.

--------------

# MODO DE USO

Para executar o script basta você caminhas até o diretório do TwiPerl no Terminal e digitar algum destes comandos:

* perl TwiPerl.pl -ajuda
* perl TwiPerl.pl -tuitar
* perl TwiPerl.pl -follow
* perl TwiPerl.pl -unfollow
* perl TwiPerl.pl -fav

--------------

# DEPENDÊNCIAS

* warnings
* strict
* Net::Twitter
* Data::Dumper
* Scalar::Util 'blessed'
* WWW::Mechanize
* Getopt::Long
* utf8

Para instala-los você pode digitar "sudo cpan [NOME DO MÓDULO]
PS: VOCÊ PRECISA USAR O SUDO POIS SE NÃO VAI DAR ERRO NA HORA DE INSTALAR OS MÓDULOS!
--------------

# COMO CONSEGUIR SUAS KEYS DE DESENVOLVEDOR

* Você terá que estar logado na Twitter via Browser ( Chrome, Mozilla, Opera e etc... ) e ir nesse link -> https://apps.twitter.com/
Este link é aonde você consegue suas keys para pode usar aplicações terceiras no Twitter.

* Após isso você clicar no botão "Create New App".

* Preencha os campos com o nome da aplicação, descrição, website ( pode colocar o seu Twitter ) e aceitar os termos e clicar no botão "Create your Twitter application".

* Acesse a aba "Keys and Access Tokens" e você já verá a sua Consumer Key (API Ke), sua Consumer Secret (API Secret) e Access Level. Basta trocar de "Read-only" para "Read, Write and Access direct messages" e clicar no botão "Update Settings".

* Feito isso, volte para a aba "Keys and Access Tokens" e clique no botão "Create my access token" quase que no final da página, para criação de mais chaves para acesso a sua conta.

* Basta copia-las, "Consumer Key", "Consumer Secret", "Access Token", "Access Token Secret" e colar no código fonte do scipt aonde ele pede para você inserir suas Keys e salvar o script.

* ATENÇÃO! NÃO PASSE ESSAS CHAVES PARA NINGUÉM POIS ELAS DÃO ACESSO AO SEU TWITTER!
--------------

Feito por Carlos Henrique ( HackerOrientado ) | Ciência Hacker
