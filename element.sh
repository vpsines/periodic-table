#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ $1 ]]
  then
  # check whether argument is number
  if [[ $1 =~ ^[0-9]+$ ]]
    then
    ELEMENT_QUERY_RESULT=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$1;")
  else
    ELEMENT_QUERY_RESULT=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE symbol='$1' OR name='$1';")
  fi  

  if [[ -z $ELEMENT_QUERY_RESULT ]]
    then
      echo "I could not find that element in the database."
  else  
    echo $ELEMENT_QUERY_RESULT | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR MELTING_POINT BAR BOILING_POINT BAR ATOMIC_MASS BAR TYPE
    do
      # print element information
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
  
else
  echo "Please provide an element as an argument."
fi
