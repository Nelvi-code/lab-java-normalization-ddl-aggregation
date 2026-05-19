CREATE  DATABASE blog_database;
USE blog_database;

CREATE TABLE authors(
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        name VARCHAR(100)NOT NULL
);

CREATE TABLE posts(
                      id INT PRIMARY KEY AUTO_INCREMENT,
                      title VARCHAR(255) NOT NULL,
                      word_count INT NOT NULL,
                      views INT NOT NULL,
                      author_id INT,
                      FOREIGN KEY (author_id) REFERENCES authors(id)

);

INSERT INTO authors(name)
VALUES
    ('Maria Charlotte'),
    ('Juan Perez'),
    ('Gemma Alcocer');

SELECT *  FROM authors;
ALTER TABLE authors AUTO_INCREMENT = 1;
DELETE FROM authors;

INSERT INTO posts(title,word_count,views,author_id)
VALUES
    ('Best Paint Colors',814,14,1),
    ('Small Space Decorating Tips',1146,221,2),
    ('Hot Accessories',986,105,1),
    ('Mixing Textures',765,22,1),
    ('Kitchen Refresh',1242,307,2),
    ('Homemade Art Hacks',1002,193,1),
    ('Refinishing Wood Floors',1571,7542,3);

SELECT * FROM posts;

SELECT authors.name, posts.title
FROM posts
         JOIN authors
              ON posts.author_id = authors.id;

