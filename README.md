# World Cup Database

This project is a relational database designed to catalog and organize information about the matches from the FIFA World Cups of 2014 and 2018. It was developed as part of the [**Relational Database Course**](https://www.freecodecamp.org/learn/relational-database/) from FreeCodeCamp.

## Project Overview
The World Cup Database provides detailed information about the participating teams and the results of matches played during the 2014 and 2018 FIFA World Cups. It offers a normalized data structure that supports efficient querying and data analysis for research and educational purposes.

## Features
- **Team Information**: Stores data about teams that participated in the tournaments.
- **Match Results**: Includes details about each match, such as year, round, goals scored by each team, and match outcomes.
- **Relational Structure**: Tables are properly normalized with primary and foreign keys for efficient data handling.
- **Query Capability**: SQL queries to retrieve and analyze data, such as the number of matches won by a specific team or the highest-scoring games.

## Database Schema
The database contains the following tables:

### 1. `teams`
Stores information about the teams participating in the tournaments.

- `team_id` (integer): Unique identifier for each team.
- `name` (varchar): Name of the team (up to 15 characters).

### 2. `games`
Stores information about the matches played.

- `game_id` (integer): Unique identifier for each match.
- `year` (integer): Year of the World Cup (2014 or 2018).
- `round` (varchar): Round of the tournament (e.g., "Final", "Semi-Final").
- `winner_id` (integer): Identifier of the team that won the match.
- `opponent_id` (integer): Identifier of the opposing team.
- `winner_goals` (integer): Goals scored by the winning team.
- `opponent_goals` (integer): Goals scored by the opposing team.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/apenas-will/World-Cup-Database.git
   ```
2. Navigate to the project directory:
   ```bash
   cd World-Cup-Database
   ```
3. Load the database schema into your SQL server (compatible with PostgreSQL, MySQL, or SQLite).
   ```bash
   psql -U postgres < worldcup.sql
   ```

## Usage
- Use SQL queries to interact with the database. Example queries are provided in the [`queries.sql`](./queries.sh) file.
- Add new data to the database using SQL `INSERT` statements or a dedicated API (if implemented).
- Perform analyses, such as finding the team with the most goals or the number of games played in a specific round.

## Example Query
1. Get the year and team name of all the champions:
```sql
SELECT year, name 
FROM games 
INNER JOIN teams 
ON games.winner_id = teams.team_id 
WHERE round='Final' 
ORDER BY year;
```

2. Get the biggest score in a single game by one team:
```sql
SELECT MAX(winner_goals) 
FROM games;
```

## Contributing
Contributions are welcome! Please fork the repository and submit a pull request with your improvements.

## License
This project is licensed under the [MIT License](LICENSE).

---

### Acknowledgments
This project was made for the FreeCodeCamp Relational Database Course. Special thanks to the open-source community for providing valuable tools and resources.