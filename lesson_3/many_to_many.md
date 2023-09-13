# Many to Many Relationships

Many-to-many relationships exist when there can be multiple instances on both sides of the relationship. 

Example: 

Book and Category

Books can have many categories AND categories can have many books. 

Need the help of an additional table `books_categories` that is responsible for storing information about the relationship between specific books and categories. This is called a `join table`.



#

# Rules for Join Tables
Foreign Keys in join table..

Should always use `NOT NULL` and `ON DELETE CASCADE` constraints with foreign keys in join tables. 
  - this keeps out `NULL` keys and reduces chance of referencing non-existent row. 

Should make sure that the combination of foreign keys (book_id, category_id) are UNIQUE. 
  - this ensures that duplicate rows will not be represented in a query. 


SELECT categories.name, COUNT(books.id) AS book_count, string_agg(books.title, ', ')
FROM categories
JOIN books_categories ON categories.id = books_categories.category_id
JOIN books ON books.id = books_categories.book_id
GROUP BY categories.name
ORDER BY categories.name;