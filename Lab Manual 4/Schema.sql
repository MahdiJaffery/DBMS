-- Create Users Table
CREATE TABLE Users (
    User_ID SERIAL PRIMARY KEY,
    UserName VARCHAR(20) UNIQUE NOT NULL,
    Age INT,
    Country VARCHAR(20),
    Privacy INT
);

-- Insert Data into Users Table
INSERT INTO Users (UserName, Age, Country, Privacy) VALUES
('Ali123', 18, 'Pakistan', 1),
('Aliza', 40, 'USA', 1),
('Aysha', 19, 'Iran', 0),
('DonaldTrump', 60, 'USA', 0),
('ImranKhan', 55, 'Pakistan', 0),
('Natasha', 28, 'USA', 0),
('Samuel', 37, 'Australia', 0),
('Sara', 30, 'Iran', 1);

-- Create Following Table
CREATE TABLE Following (
    FollowerUserName VARCHAR(20) REFERENCES Users(UserName),
    FollowedUserName VARCHAR(20) REFERENCES Users(UserName),
    PRIMARY KEY (FollowerUserName, FollowedUserName)
);

-- Insert Data into Following Table
INSERT INTO Following (FollowerUserName, FollowedUserName) VALUES
('Ali123', 'DonaldTrump'),
('Aliza', 'Ali123'),
('Aliza', 'DonaldTrump'),
('Aliza', 'ImranKhan'),
('Aysha', 'ImranKhan'),
('DonaldTrump', 'ImranKhan'),
('ImranKhan', 'DonaldTrump'),
('Natasha', 'ImranKhan'),
('Samuel', 'DonaldTrump'),
('Samuel', 'ImranKhan'),
('Sara', 'DonaldTrump');

-- Create Tweets Table
CREATE TABLE Tweets (
    TweetID SERIAL PRIMARY KEY,
    UserName VARCHAR(20) REFERENCES Users(UserName),
    Text VARCHAR(140)
);

-- Insert Data into Tweets Table
INSERT INTO Tweets (UserName, Text) VALUES
('Ali123', 'Pakistan’s largest-ever population #Census starts today in 63 districts after 19 years.'),
('ImranKhan', 'Pakistan’s largest-ever population #Census starts today in 63 districts after 19 years.'),
('Sara', 'Take the soldier who come to our door for #Census as A ThankYou from Pakistan Army for our devotion. #CensusWithSupportOfArmy'),
('ImranKhan', 'Pakistan is going to experience 6th #Census 2017.'),
('Sara', 'Only #census can reveal where this aunty lives'),
('ImranKhan', 'Quand tu te lèves 3h en avance (littéralement) pour la #massecritique'),
('Sara', 'Over 1 million decrypted Gmail and Yahoo accounts allegedly up for sale on the Dark Web https://geekz0ne.fr/shaarli/?wQRSoQ #piratage'),
('Sara', 'Harry pot-head and the Sorcerer''s stoned'),
('DonaldTrump', 'LSDespicable Me #DrugMovies'),
('ImranKhan', 'Forrest Bump #DrugMovies @midnight'),
('DonaldTrump', 'Quand tu te lèves 3h en avance (littéralement) pour la #massecritique'),
('Sara', '#DrugMovies'),
('DonaldTrump', 'Quand tu te lèves 3h en avance (littéralement) pour la #massecritique'),
('Aliza', 'Quand tu te lèves 3h en avance (littéralement) pour la #massecritique');

-- Create Likes Table
CREATE TABLE Likes (
    TweetID INT REFERENCES Tweets(TweetID),
    LikeByUserName VARCHAR(20) REFERENCES Users(UserName),
    LikeOnDate DATE,
    PRIMARY KEY (TweetID, LikeByUserName)
);

-- Insert Data into Likes Table
INSERT INTO Likes (TweetID, LikeByUserName, LikeOnDate) VALUES
(1, 'Aliza', '2017-03-02'),
(2, 'Aliza', '2017-03-02');

-- Create Interests Table
CREATE TABLE Interests (
    InterestID SERIAL PRIMARY KEY,
    Description VARCHAR(30)
);

-- Insert Data into Interests Table
INSERT INTO Interests (Description) VALUES
('Politics'),
('Sports'),
('Movies'),
('Education'),
('Video Games');

-- Create UserInterests Table
CREATE TABLE UserInterests (
    UserName VARCHAR(20) REFERENCES Users(UserName),
    InterestID INT REFERENCES Interests(InterestID),
    PRIMARY KEY (UserName, InterestID)
);

-- Insert Data into UserInterests Table
INSERT INTO UserInterests (UserName, InterestID) VALUES
('Ali123', 1),
('Ali123', 3),
('Ali123', 4),
('Aliza', 1),
('Aliza', 3),
('Aliza', 4),
('ImranKhan', 1);

-- Create Hashtags Table
CREATE TABLE Hashtags (
    HashtagID SERIAL PRIMARY KEY,
    Hashtag VARCHAR(30)
);

-- Insert Data into Hashtags Table
INSERT INTO Hashtags (Hashtag) VALUES
('#Census'),
('#ClassiqueMatin'),
('#MasseCritique'),
('#piratage'),
('#DrugMovies');

-- Select Statements
SELECT * FROM Following;
SELECT * FROM Hashtags;
SELECT * FROM Interests;
SELECT * FROM Tweets;
SELECT * FROM UserInterests;
SELECT * FROM Users;
