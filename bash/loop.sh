#!/bin/bash

SetOne=(One Two Three)
SetTwo=(First Second Third)

for i in ${SetOne[@]}
do
    for j in ${SetTwo[@]}
    do
        echo ${i}_${j}
    done
done

echo "Done"

