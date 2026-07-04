#!/bin/bash

mandir=${HOME}/.dotfiles/man
for file in $( ls -t $mandir ); do
	echo "making manual page for "$file""
	cp $mandir/$file $mandir/$file.1
	gzip $mandir/$file.1
	sudo mv $mandir/$file.1.gz /usr/share/man/man1
	rm -f $mandir/$file.1.gz # remove it if it's still there for some reason
done
