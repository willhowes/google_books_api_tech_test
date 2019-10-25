# Planning and Notes

## Initial Domain Model

### Objects

#### QUERY OBJECT

##### Attributes

- text of query (i.e. the user's input)
- list (of 5 book objects max)

##### Methods

- receive query test (i.e. from user)
- make API request (to Google Books API)
- add result of API request to the list

#### BOOK OBJECT

##### Attributes

- Author
- Title
- Publishing Co

##### Methods

- Print attributes
- Save to reading list

#### READING LIST OBJECT

##### Atributes

- List

##### Methods

- Print list
