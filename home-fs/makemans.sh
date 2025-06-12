#!/bin/bash

mandir=${HOME}/.dotfiles/man
for file in $( ls -t $mandir ); do
	cp $mandir/$file $mandir/$file.1
	gzip $mandir/$file.1
	sudo mv $mandir/$file.1.gz /usr/share/man/man1
done
