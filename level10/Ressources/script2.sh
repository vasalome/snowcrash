#!/bin/bash
while true;
do
	rm -f /tmp/link
	touch /tmp/link
	ln -fs ~/token /tmp/link
done