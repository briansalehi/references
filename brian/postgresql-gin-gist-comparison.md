# What are the differences between GIN and GiST indexes?

GIN (Generalized Inverted Index) makes it easy to search based on similarity, while GiST (Generalized Search Tree) is a nested map holding smaller regions grouped inside larger regions making it easy to find distances.

GIN is almost x3 faster in lookup but slower in writing compared to GiST.
