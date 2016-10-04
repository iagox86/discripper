#!/bin/bash

echo "Title = $2"
echo "Year = $3"
echo "Device = $1"
DIR=`echo "$2-$3" | tr ' ' '-'`
mkdir "$DIR"
rm -fv "$DIR"/*
echo "------------"

until makemkvcon --minlength=300 --decrypt --directio=true mkv dev:$1 all $DIR/; do
  echo 'Waiting...'
  sleep 5
done

eject $1
BIGGEST=`ls -S $DIR/ | head -n1`
mv -iv $DIR/*.mkv "./$2 [$3].mkv" || cp -iv $DIR/$BIGGEST "$DIR/$2 [$3].mkv"
rmdir "$DIR"
