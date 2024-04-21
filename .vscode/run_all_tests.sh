#!/bin/bash

for i in ./tests/*.vhdl; do
  ENTITY=${i%*.vhdl}
  ENTITY=$(basename $ENTITY)

  echo testing $ENTITY...

  ghdl -a "$i"
  ghdl -e "$ENTITY"
  ghdl -r "$ENTITY"
  ghdl remove

  echo done
done