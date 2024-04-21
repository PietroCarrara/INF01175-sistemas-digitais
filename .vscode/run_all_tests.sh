#!/bin/bash

for i in ./src/*.vhdl; do
  ghdl -i "$i"
done

for i in ./tests/*.vhdl; do
  ENTITY=${i%*.vhdl}
  ENTITY=$(basename $ENTITY)


  mkdir -p wave-files/

  ghdl -i "$i"
  ghdl -m "$ENTITY"
  echo testing $ENTITY...
  ghdl -r "$ENTITY" --wave="wave-files/$ENTITY.ghw"

  echo done
done

ghdl remove
