-- Movies table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title TEXT,
    year INT,
    genre TEXT,
    mpaa_rating TEXT,
    director TEXT
);

/*
3 example rows:
SELECT * FROM Movies LIMIT 3;
movie_id    title                       year    genre                       mpaa_rating     director
1   Star Wars: Episode IV - A New Hope  1977    Action, Adventure, Fantasy  PG  George Lucas
2   The Matrix  1999    Action, Sci-Fi  R   The Wachowskis
3   Back to the Future  1985    Adventure, Comedy, Sci-Fi   PG  Robert Zemeckis

*/

-- Users table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username TEXT,
    birthdate DATE,
    account_creation_date DATE
);

/*
3 example rows:
SELECT * FROM Users LIMIT 3;
user_id username    birthdate   account_creation_date
1   TheSilverScreenLover    1999-02-14  2023-09-30
2   MovieMaverick   1997-11-22  2023-12-02
3   CinephileGuru   1996-08-03  2023-07-18

*/

-- Favorites table
CREATE TABLE Favorites (
    user_id INT,
    movie_id INT,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

/*
3 example rows:
SELECT * FROM Favorites LIMIT 3;
user_id movie_id
1   22
2   11
3   4

*/

-- Watchlist table
CREATE TABLE Watchlist (
    user_id INT,
    movie_id INT,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

/*
3 example rows:
SELECT * FROM Watchlist LIMIT 3;
user_id movie_id
1   8
2   4
3   14

*/

