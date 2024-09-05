#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else 
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    #number input/atomic number
    ELEMENT_INFO=$($PSQL "SELECT * FROM elements WHERE atomic_number=$1;")
    if [[ -z $ELEMENT_INFO ]]
    then
      echo I could not find that element in the database.
    else
      echo $ELEMENT_INFO | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME
      do
        #echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL)."
        ELEMENT_INFO_2=$($PSQL "SELECT type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM properties LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
        echo $ELEMENT_INFO_2 | while IFS="|" read TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      done
    fi
  else
    if [[ ${#1} < 3 ]]
    then
      #string input/symbol
      INPUT_SYMBOL=$($PSQL "SELECT * FROM elements WHERE symbol='$1';")
      if [[ -z $INPUT_SYMBOL ]]
      then
        echo I could not find that element in the database.
      else
        echo $INPUT_SYMBOL | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME
        do
          #echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL)." 
          INPUT_SYMBOL2=$($PSQL "SELECT type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM properties LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
          echo $INPUT_SYMBOL2 | while IFS="|" read TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
          do
            echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
          done
        done
      fi  
    else
      #string input/name
      INPUT_NAME=$($PSQL "SELECT * FROM elements WHERE name='$1';")
      if [[ -z $INPUT_NAME ]]
      then
        echo I could not find that element in the database.
      else
        echo $INPUT_NAME | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME
        do
          #echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL)." 
          INPUT_NAME2=$($PSQL "SELECT type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM properties LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
          echo $INPUT_NAME2 | while IFS="|" read TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
          do
            echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
          done
        done
      fi
    fi
  fi
fi
