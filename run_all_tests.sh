#!/bin/bash

EXIT_CODE=0 # Success by default
trap EXIT_CODE=1 ERR # Failure if any command fails

for i in ./src/*.vhdl; do
  ENTITY=${i%*.vhdl}
  ENTITY=$(basename $ENTITY)

  ghdl -i "$i"
  ghdl -m "$ENTITY"
  ghdl --synth --out=none "$ENTITY"
done

for i in ./tests/*.vhdl; do
  ENTITY=${i%*.vhdl}
  ENTITY=$(basename $ENTITY)

  mkdir -p wave-files/

  ghdl -i "$i"
  ghdl -m "$ENTITY"
  echo testing $ENTITY...
  ghdl -r "$ENTITY" --assert-level=error --wave="wave-files/$ENTITY.ghw"

  echo done
done

ghdl remove

exit $EXIT_CODE