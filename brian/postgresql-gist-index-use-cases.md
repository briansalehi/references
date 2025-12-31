# What are the use cases of GiST index?

GiST (Generalized Search Tree) is a balanced tree structure similar to B-tree, but much more flexible in comparison operations. B-tree only understands greater than `>` or less than `<` operators, but GiST can handle concepts like *is near*, *contains*, or *overlaps*.

The first use case of GiST is geometry and spatial data. GiST is the engine to help solving questions like "find all restaurants within 1 kilometer", or "does this polygon overlap an area".

Comparison operator `<->` can be used to apply algorithms like **K-Nearest Neighbors**:

```sql
select * from places order by location <-> point(0, 0) limit 5;
```
