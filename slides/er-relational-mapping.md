% ER to Relational Mapping
% CS 4400

# ER to Relational Mapping

Algorithm

# Step 1: Mapping Regular (Strong) Entity Types

A strong entity type is modeled as a relation schema.

- Each simple attribute of the entity type becomes an attribute of the relation schema
    - For composite attributes, only the simple component attributes are present in the relation schema
- Choose a key of the entity type to be the primary key of the relation schema

A tuple of a relation is an entity instance.

# Strong Entity Mapping Example

# Step 2: Mapping Weak Entity Types

Map the attributes of the weak entity type to a relation schema as you wold do for a strong entity type.

Add the primary key attribute(s) of the identifying relationship to the attributes of the weak entity type's relation schema. These attributes should be foreign keys to the identifying relation's primary key.

The primary key of the weak entity types relation schema is a combination of the foreign keys to the identifying relation schema and the weak entity's partial key. If no partial key, then the whole attribute list is the primary key.

# Weak Entity Mapping Example


# Step 3: Mapping Binary 1:1 Relationship Types

Three approaches:

1. Foreign keys
2. Merged relation
3. Cross-reference or relationship relation

Favor the foreign key approach

# Binary 1:1 Relationships - Foreign Key Approach

Include the primary key of one relation schema as a foreign key of the other relation schema, as well as all the simple attributes of the relationship type. If there is a total participation constraint on only one entity type, that entity type's relation schema should be the one with the foreign key.

# Binary 1:1 Relationships - Merged Relation Schema Approach

If the relationship type has a total participation constraint with both entity types in the relationship, then both entity types and the relationsip type can be merged into a single table.

# Binary 1:1 Relationships - Cross-reference or Relationship Relation Scheam Approach

Set up a third relation schema to represent the relationship, with foreign keys to both participating relation schemas' primary keys. One foreign key becomes the primary key of the relationship schema and the other is a unique key. This approach isn't necessary in 1:1 relationships but is required for M:N relationships.

# Step 4: Mapping Binary 1:N Relationship Types

Two approaches:

1. Foriegn keys
2. Relationship relation schema

# Binary 1:N Relationships - Foreign Key Approach

Give the relation schema on the N side of the relationship a foriegn key to the primary key of the relation schema on the 1 side of the relationship.

# Binary 1:N Relationships - Relationship Relation Schema Approach




# Step 5: Mapping Binary M:N Relationship Types

# Step 6: Mapping Multivalued Attributes

# Step 7: Mapping of N-ary Relationship Types

# Step 8: Mapping Specializations and Generalizations

# Step 9: Mapping Union Types (Categories)