#!/bin/bash

for i in ./src/*.vhdl; do
  ghdl -a "$i"
done

for i in ./tests/*.vhdl; do
  ENTITY=${i%*.vhdl}
  ENTITY=$(basename $ENTITY)

  echo testing $ENTITY...

  ghdl -a "$i"
  ghdl -e "$ENTITY"
  ghdl -r "$ENTITY"

  echo done
done

ghdl remove
