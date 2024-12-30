#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Remove all the data of the database
echo $($PSQL "TRUNCATE games, teams;")


cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS 
do 
  # Check if it is the first row of the csv and ignores it if it is true
  if [[ $WINNER != 'winner' ]]
  then 

    # Insert teams into the teams table
    # Get team_id of the winner
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    # If not found, insert winner into teams table
    if [[ -z $WINNER_ID ]]
    then
      echo $($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    
      # Get new team_id of the winner
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi

    # Get team_id of the opponent
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # If not found, insert opponent into teams table
    if [[ -z $OPPONENT_ID ]]
    then
      echo $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
    
      # Get new team_id of the opponent
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi

    # Insert data into the games table

    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE winner_id=$WINNER_ID AND opponent_id=$OPPONENT_ID")

    # If not found, insert game into games table
    if [[ -z $GAME_ID ]]
    then
    echo $($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")

    # Get new game_id
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE winner_id=$WINNER_ID AND opponent_id=$OPPONENT_ID")
    fi
  fi
done

echo "Insertion completed"