#!/bin/bash

for i in ./src/*.vhdl; do
  ghdl -a "$i"
done

for i in ./tests/*.vhdl; do
  ENTITY=${i%*.vhdl}
  ENTITY=$(basename $ENTITY)

  echo testing $ENTITY...

  mkdir -p wave-files/

  ghdl -a "$i"
  ghdl -e "$ENTITY"
  ghdl -r "$ENTITY" --wave="wave-files/$ENTITY.ghw"

  echo done
done

ghdl remove
