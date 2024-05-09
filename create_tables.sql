-- Movies table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title TEXT,
    year INT,
    genre TEXT,
    mpaa_rating TEXT,
    director TEXT
);

-- Users table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username TEXT,
    birthdate DATE,
    account_creation_date DATE
);

-- Favorites table
CREATE TABLE Favorites (
    user_id INT,
    movie_id INT,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- Watchlist table
CREATE TABLE Watchlist (
    user_id INT,
    movie_id INT,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);
