% Basic Relational Database Design
% CS 4400

# Basic Relational Design

- Basic design approaches.
- What makes a good design better than a bad design?
- How do we tell we have a "good" design?
- How to we go about creating a good design?

# Basic Design Approaches

- Bottom-up, a.k.a. *synthethis*

    - Start with individual attributes and large set of binary relationship among attributes
    - Unpopular


- Top-down, a.k.a. *analysis*

    - Start with groupings of attributes, e.g., a schema derived from ER-relational mapping
    - Decompose until design properties are met

We'll focus on analysis.

# Relational Design Desiderata

- The sematics of relation schemas and their attributes should be clear
- There should be little or no redundant information in tuples
- The should be few or no NULL values in tuples
- It should be impossible to generate spurious (invalid) tuples

# Clear Semantics of Relation Schemas


# Guideline 1: Convey cohesive meaning in relational schemas

# Redundant Information in Tuples

Redundant information in schemas:

- wastes storage space, and
- leads to data manipulation anomalies.

One way to think of schemas with redundancy: they are joined tables from well-designed schemas.

# Insertion Anomalies

# Deletion Anomalies

# Update (Modification) Anomalies

# Guideline 2: Eliminate data manipulation anomalies

# NULL Values in Tuples

# Guideline 3: Minimize the need for NULL values in tuples

# Spurious Tuples

# Guideline 4: Design relation schemas for natural joins

Design relation schemas to be naturally joined on attributes that are related by foreign key-primary key relationships.

# Functional Dependencies

A generalization of superkeys.