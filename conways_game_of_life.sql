with recursive start (alive, x, y) as (
    values
        (false,  0, 0), (false,  1, 0), (false, 2, 0), (false, 3, 0),
        (false,  0, 1), (true,   1, 1), (true,  2, 1), (true,  3, 1),
        (true,   0, 2), (true,   1, 2), (true,  2, 2), (false, 3, 2),
        (false,  0, 3), (false,  1, 3), (false, 2, 3), (false, 3, 3)
),
cgol (alive, x, y, n, nei) as (
        select alive, x, y, 0, 0
        from start s1
    union
        select (
            case
            when c1.alive
                then nei.num between 2 and 3
                else nei.num = 3
            end
        ), c1.x, c1.y, c1.n+1 as n, nei.num
        from start, cgol c1, (
            select count(*) as num
            from cgol c2
            where c2.n = c1.n
                and not (
                    c2.x = c1.x and c2.y = c1.y
                )
                and (
                    abs(c2.x - c1.x) <= 1
                    and abs(c2.y - c1.y) <= 1
                )
                and c2.alive = true
        ) as nei
        where c1.n < 20
)

select *
from cgol
where n = 5
order by n, y, x;