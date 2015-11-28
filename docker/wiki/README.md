Labor Semantic Mediawiki
========================

Preparation
-----------

Uses Mediawiki from volume on /var/www/html.  The volume should be
prepared like this (TODO: Create a git repository with all this, using
submodules).

$ git clone https://gerrit.wikimedia.org/r/p/mediawiki/core.git .
$ # cp LocalSettings.php FROM BACKUP
$ cd images # FILL FROM BACKUP
$ cd skins # FILL Labor FROM BACKUP
$ git clone https://gerrit.wikimedia.org/r/p/mediawiki/skins/Vector.git
$ cd ../extensions
$ git clone https://github.com/jmnote/SimpleMathJax.git
$ git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ParserFunctions.git
$ git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/LdapAuthentication.git
$ git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ImageMap.git
$ git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ConfirmEdit.git
$ git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/WikiEditor.git
$ git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/YouTube.git

diff --git a/composer.json b/composer.json
index 0f8da12..8988a9a 100644
--- a/composer.json
+++ b/composer.json
@@ -35,7 +35,10 @@
                "wikimedia/running-stat": "1.1.0",
                "wikimedia/utfnormal": "1.0.3",
                "wikimedia/wrappedstring": "2.0.0",
-               "zordius/lightncandy": "0.21"
+               "zordius/lightncandy": "0.21",
+                "mediawiki/semantic-media-wiki": "@dev",
+                "mediawiki/semantic-forms": "@dev",
+                "mediawiki/semantic-result-formats": "~2.0"
        },
        "require-dev": {
                "jakub-onderka/php-parallel-lint": "0.9",

Installation
------------

Through "docker exec", because there is no php on the host.

$ docker exec -ti wiki bash -c "curl -sS https://getcomposer.org/installer | php"
$ docker exec -ti wiki php composer.phar install --no-dev

Update
------

$ docker exec -ti wiki git pull
$ docker exec -ti wiki php composer.phar update --no-dev
$ docker exec -ti wiki php maintenance/update.php

Migration
---------

$ rsync -avzP das-labor.org:/srv/www.das-labor.org/htdoc/w/images/ images
$ rsync -avzP das-labor.org:/srv/www.das-labor.org/htdoc/w/extensions/S3 extensions
$ ssh das-labor.org mysqldump -u laborwiki -pxxxxxxxx laborwiki | docker exec -i  wiki-mysql mysql -ptest mediawiki
$ docker exec -ti wiki php maintenance/update.php

Testing
-------

$ docker exec -ti wiki curl http://localhost/wiki/LABOR_Wiki
