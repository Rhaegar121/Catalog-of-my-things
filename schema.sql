create table Books (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(250),
    publisher VARCHAR(250),
    cover_state VARCHAR(1),
    publish_date DATE,
    genre_id INT,
    label_id INT,
    author_id INT,
    FOREIGN KEY(genre_id) REFERENCES genres(id),
    FOREIGN KEY(label_id) REFERENCES labels(id),
    FOREIGN KEY(author_id) REFERENCES authors(id)
);

CREATE TABLE music_albums (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    on_spotify BOOLEAN,
    publish_date DATE,
    genre_id INT,
    label_id INT,
    author_id INT,
    FOREIGN KEY(genre_id) REFERENCES genres(id),
    FOREIGN KEY(label_id) REFERENCES labels(id),
    FOREIGN KEY(author_id) REFERENCES authors(id)
);

CREATE TABLE games (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    last_played_at DATE NOT NULL,
    multiplayer BOOLEAN NOT NULL,
    publish_date DATE,
    genre_id INT REFERENCES genres(id),
    author_id INT REFERENCES authors(id),
    label_id INT REFERENCES labels(id),
    PRIMARY KEY (id),
);

create table labels (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(250)
    color VARCHAR(7)
);

CREATE TABLE genres (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250)
);

CREATE TABLE authors (
    id INT GENERATED ALWAYS AS IDENTITY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    PRIMARY KEY (id),
);