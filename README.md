# Relational Database Learning Journey

This repository documents my structured learning journey in **Relational Database Management Systems (RDBMS)**.

It contains my hands-on practice, notes, SQL queries, ER diagrams, and mini-projects covering both fundamental and intermediate database concepts.

The main goals of this repository are to:

- Track my RDBMS learning progress in one place
- Practice database concepts with real SQL examples
- Build a strong foundation in database design and querying
- Showcase my growth from beginner to advanced database topics

# 📚 Topics Covered

- Database Fundamentals
- RDBMS Concepts
- Relationships
- Database Design Practice
- ER Diagrams
- Normalization
- SQL Basics
- CRUD Operations
- Constraints
- Joins
- Aggregate Functions
- Transactions

# 📂 Repository Structure

```text
learn-rdbms/
├── er-diagrams/      # ER diagrams and database design practice
├── resources/        # Learning resources, references, and documentation
├── sql-practice/     # SQL queries and practice exercises
├── mini-projects/    # Small database projects for hands-on learning
└── README.md
```

# 🛠 Technologies & Tools

- SQL
- MySQL
- MySQL Workbench

A database-management system (DBMS) is a collection of interrelated data and a set
of programs to access those data. The collection of data, usually referred to as the
database, contains information relevant to an enterprise. The primary goal of a DBMS
is to provide a way to store and retrieve database information that is both convenient
and efficient.

# Introduction
**Data** are the collection of facts, values, numbers,  video and text, sound, picture or which carry a certain meaning in a context.
A **database** is a large collection of interrelated data.
A **database-management system (DBMS)** is a collection of interrelated data and a set of programs to access those data.

 he primary goal of a DBMS is to provide a way to store and retrieve database information that is both ``convenient``
and ``efficient``.

a database system provides a simpler, abstract view of the information so that users and application programmers do not need to be aware of the underlying details of how data are stored and organized. By providing a high level of abstraction, a database system makes it possible for an enterprise to combine data of various types into a unified repository of the information needed to run the enterprise.

## Purpose of Database Systems
A major purpose of a database system is to provide users with an abstract view of the data. Database systems were also developed to solve the following problems of traditional file-processing systems:
- Reduce data redundancy
- Maintain data consistency
- Improve data access
- Ensure data integrity
- Support atomic transactions
- Handle concurrent users safely
- Provide better security
- Simplify data management

## Data Models
a collection of conceptual tools for describing data, data relationships, data semantics, and consistency constraints.
The data models can be classified into four different categories:
- **Relational Model:** The relational model uses a collection of tables to represent both
data and the relationships among those data. Each table has multiple columns,and each column has a unique name. Tables are also known as relations.
- **Entity-Relationship Model:** The entity-relationship(ER) data model uses a collection of basic objects, called entities,and relationships among these objects. *An `entity` is a “thing” or “object” in the real world that is distinguishable from other objects.*
- **Semi-Structured Data Model:** The Semi-Structured Data Model is a type of data model where:
    - data does not need a fixed structure
    - records of the same type can have different attributes (fields)  

    Unlike relational databases, every row does not need to contain the exact same columns.
    JSON and Extensible Markup Language (XML) are widely used semi-structured data representations.
- **Object-Oriented Data Model:** In the Object-Oriented Data Model, data and their relationships are contained in a single structure which is referred to as an object in this data model. All objects have multiple relationships between them. Basically, it is a combination of Object Oriented programming and a Relational Database Model.

## Data Abstraction (Hand Note)
Data abstraction is a technique used in database systems to hide the complexity of data storage from users and provide a simple way to interact with data.  
It helps users work with the database easily without knowing how data is physically stored.
### Levels of Data Abstraction  
Database systems use **three levels of abstraction**:
- Physical Level (Lowest Level)

    - Describes **how data is actually stored**
    - Includes storage details like:
        - files
        - indexes
         - data structures
    - Very complex and handled by the system

    *Users do NOT interact with this level*
- Logical Level (Conceptual Level)

    - Describes **what data is stored**
    - Shows relationships between data
    - Defines database structure using tables  

    *This level is used by database designers and DBAs*
- View Level (Highest Level)
    - Shows only a **part of the database**
    - Different users see different views
    - Simplifies user interaction

## Instances and Schemas
A **database instance** is the **actual data stored in the database at a specific moment in time**.
A **database schema** is the **overall structure (design) of the database**.
It defines:
- tables
- attributes (columns)
- relationships
Types of Schemas in DBMS

Database systems have different schemas:

1. Physical Schema
Describes how data is stored internally
Includes files, indexes, storage methods
Hidden from users
2. Logical Schema (Most Important)
Describes what data is stored
Defines tables and relationships
Used by application developers

👉 Most important for software development

3. View Schema (Subschema)
Shows only part of the database
Different users see different views

📌 Example:
Students see grades
Admin sees full data

## Database Languages
A database system provides a data-definition language (DDL) to specify the database
schema and a data-manipulation language (DML) to express database queries and up
dates. 
There are basically two types of data-manipulation language:
• Procedural DMLs require a user to specify what data are needed and how to get
those data.
• Declarative DMLs (also referred to as nonprocedural DMLs)require a user to specify what data are needed without specifying how to get those data.

A query is a statement requesting the retrieval of information. The portion of a
DML that involves information retrieval is called a query language.

# Database Design
Database design mainly involves the design of the database schema.
In terms of the relational model, the conceptual-design process involves decisions
on what attributes we want to capture in the database and how to group these attributes
to form the various tables. The “what” part is basically a business decision, and we
shall not discuss it further in this text. The “how” part is mainly a computer-science
problem. There are principally two ways to tackle the problem. The first one is to use
the entity-relationship model (Chapter 6); the other is to employ a set of algorithms
(collectively known as normalization that takes as input the set of all attributes and
generates a set of tables (Chapter 7).

# Database Engine
Adatabasesystem ispartitioned into modulesthatdealwitheachoftheresponsibilities
of the overall system. The functional components of a database system can be broadly
divided into the storage manager, the query processor components, and the transaction
management component.

Atransaction is a collection of operations that performs a single logical function
in a database application. Each transaction is a unit of both atomicity and consistency.

# Introduction to the Relational Model
 In mathematical terminology, a tuple is simply a sequence
(or list) of values. A relationship between n values is represented mathematically by an
n-tuple of values, that is, a tuple with n values, which corresponds to a row in a table.
Thus, in the relational model the term relation is used to refer to a table, while the
term tuple is used to refer to a row. Similarly, the term attribute refers to a column of a
table.

For each attribute of a relation, there is a set of permitted values, called the domain
of that attribute.

A domain is atomic if elements of the domain are considered to be indivisible units.
The null value is a special value that signifies that the value is unknown or does not exist.

## Clarification of Some Common Database Terms
| Common Term | Relational Model | ER Model |
|---|---|---|
| Table ≈| Relation ≈| Entity Set |
| Row / Record ≈| Tuple ≈| Entity |
| Column / Field ≈| Attribute ≈| Attribute |

Keys are fundamental elements of the relational database model that ensure uniqueness, data integrity, and efficient data access.
- They uniquely identify each row in a table.
- They prevent data duplication and maintain consistency.
- They create relationships between different tables.

A super key is a set of one or more attributes that, taken collectively, allow us to identify uniquely a tuple in the relation.