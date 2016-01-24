% Database Concepts
% CS 4400

# Database Concepts

- Data models, schemas, instances
- Three-schema architecture and data independence
- Database languages and interfaces
- Database systems
- DBMS Architectures
- Classification of DBMSes

# Data Models

- Abstraction: selective ignorance

    - Essential attributes of an entity for a particular application

- Data model: collection of concepts describing a database

    - Structure of database: entities, attributes, data types, relationships
    - Operations on the data: updates and retrievals

# Categories of Data Models

- High level conceptual models

    - The end users' conception of their data
    - A tool for understanding user data in enough detail to derive an implementaion model from it (think ER models)

- Representational (implementation) models

    - Understandable by end users
    - Rigorous, mechanically translatable to physical model (think SQL)

- Low-level physical models

    - How data are stored on disk (the code inside a DBMS)

# Conceptual Data Model: Entity-Relationship

- Entity: a real world object or concept that will be modeled in the database

- Attribute: a property of interest of some entity

- Relationship: an association between two or more entities

# Representational (Implementation) Models

- Most common: relational data model (focus of this class)

- Others:

    - Legacy: network, hierarchical
    - Object data models: never gained widespread adoption
    - Self-describing:  XML, JSON (e.g., MongoDB) - a.k.a. NOSQL (Not Only SQL)

- Graph models: major emphasis today, e.g., social networks

# Schemas and Databases

- A schema is a description of the data in a database (metadata), typically depicted in a schema diagram

    - Constructs, e.g., STUDENT, COURSE, that specify elemets of the data model
    - Constraints, e.g., STUDENT.GTID must be unique

- Database state is set of instances of entities specified in the schema

- As data loaded into databse, DBMS ensures valid states by ensuring data instances conform to schema and meet constraints

- Sometimes schema called *intension*, state called *extension*

# Three-Schema Architecure

- Internal level: internal schema -- physical storage structures

- Conceptual level: conceptual schema

    - Conceptual schema corresponds to represeantational (implementation) model, not conceptual model

- External level: external schemas

    - An external schema also representational, but tailored to particular (class of) user(s)

- Transformations of data between levels is called mapping; may be computationally expensive

# Data Independence

- Goal of Three-Schema Architecure is separate user applications from physical database. We call this *data independence*: isolation of changes at one level from levels above

    - Logical data independence: changes to the conceptual schema don't requre changes to external schemas

        - Mappings, e.g., view definitions, may need to change

    - Physical data independence: changes to internal schema don't require changes to conceptual schema

# Database Languages

- Data definition language (DDL) specifies conceptual and internal schemas

    - Some systems have a seaprate storage definition language (SDL) to specify internal schemas

- View definition language (VDL) specifies user views (external schema)
- Data manipulation language (DML) used to insert, retrieve, update, and delete data from database

Modern DBMS systems don't have distinct languages. For example, SQL has DDL, VDL, and DML

# Database System Architectures

- Centralized
- Client/Server
- Three-tier and n-tier

# DBMS Classification Criteria

- Type of data model supported

    - relational, key-value, document-based, graph-based

- Number of users supported -- single user vs. multi-user

- Number of sites

    - Centralized vs. distributed
    - Homogeneous, heterogeneous
    - middleware
    - federated multi-database systems

- Cost
