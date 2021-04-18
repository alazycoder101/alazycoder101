# Tree
## PostgreSQL

 parent_id  |  child_id
------------+------------
     2      |     3
     1      |     4
     1      |     3
     4      |     8
     4      |     5
     5      |     6
     6      |     7

```
create table nodes(id integer, parent_id integer, child_id integer);
insert into table nodes(parent_id, child_id) values
    (2, 3),
    (1, 4),
    (1, 3),
    (4, 8),
    (4, 5),
    (5, 6),
    (6, 7);
```

### connectby

```
select parent_keyid::int, keyid::int, level, number
from connectby('nodes', 'child_id', 'parent_id', 'id', 0, '~')
as t(keyid int, parent_keyid int, level int, branch text);
```


### RECURSIVE
```
WITH RECURSIVE c AS (
   SELECT 1 AS id
   UNION ALL
   SELECT sa.child_id
   FROM nodes AS sa
      JOIN c ON c.id = sa.parent_id
)
SELECT id FROM c;
```


# Graph

## Sqlite3
```
create table edges(fromNode integer, toNode integer);
insert into edges(fromNode, toNode) values
    (1, 2),
    (1, 3),
    (2, 4),
    (3, 4),
    (4, 5),
    (4, 6),
    (5, 7),
    (6, 7);

with bfs_tree(startat, endat, visited, distance)
  as (
         select 1, 1, '/' || 1 || '/', 0
      union all
         select startat, toNode, visited || toNode || '/', distance + 1
           from edges, bfs_tree
          where fromNode == endat
            and instr(visited, '/' || toNode || '/') == 0
      union all
         select startat, fromNode, visited || fromNode || '/', distance + 1
           from edges, bfs_tree
          where toNode == endat
            and instr(visited, '/' || fromNode || '/') == 0
    )
  select *
    from bfs_tree
order by startat, endat, distance;
```

## PostgreSQL
```
WITH RECURSIVE search_graph(id, link, data, depth) AS (
    SELECT g.id, g.link, g.data, 1
    FROM graph g
  UNION ALL
    SELECT g.id, g.link, g.data, sg.depth + 1
    FROM graph g, search_graph sg
    WHERE g.id = sg.link
)
SELECT * FROM search_graph;
```


Reference:
[1] https://sqlite.org/forum/forumpost/febcd6c922
[2] https://github.com/Andrew-Chen-Wang/postgres-connectby-vs-recursive
[3] https://www.postgresql.org/docs/13/tablefunc.html
[4] https://www.alibabacloud.com/blog/postgresql-graph-search-practices---10-billion-scale-graph-with-millisecond-response_595039
[5] https://www.postgresql.org/docs/13/queries-with.html
