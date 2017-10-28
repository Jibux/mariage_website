#!/bin/bash


source ../bin/activate

PELICAN_LOG=/tmp/pelican.log
THEME=custom-jb-theme

cleancss themes/$THEME/src/static/css/main.css -o themes/$THEME/static/css/main.css

rm -rf output
pelican content/ -s pelicanconf.py 2> $PELICAN_LOG

[ "$(grep ERROR $PELICAN_LOG | wc -l)" != "0" ] && cat $PELICAN_LOG && exit 1
[ "$(grep WARNING $PELICAN_LOG | wc -l)" != "0" ] && cat $PELICAN_LOG && exit 1

rsync -a --delete output/ /home/www/jb_dedi_web/public_html/mariage/
chmod -R o+rX /home/www/jb_dedi_web/public_html/mariage
#mv /home/www/jb_dedi_web/public_html/mariage/images/favicon.ico /home/www/jb_dedi_web/public_html/mariage/
chown -R jb_dedi_web:jb_dedi_web /home/www/jb_dedi_web/public_html/mariage

