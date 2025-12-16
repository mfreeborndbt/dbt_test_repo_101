with customers as (

    select *
    from {{ ref('stg_TPCH__CUSTOMER') }}

),

nations as (

    select *
    from {{ ref('stg_TPCH__NATION') }}

),

customer_enriched as (

    select
        -- customer fields
        c.c_custkey      as customer_id,
        c.c_name         as customer_name,
        c.c_address      as customer_address,
        c.c_phone        as customer_phone,
        c.c_acctbal      as account_balance,
        c.c_mktsegment   as market_segment,
        c.c_comment      as customer_comment,

        -- nation fields
        n.n_name         as nation_name,
        n.n_regionkey    as region_key,
        n.n_comment      as nation_comment

    from customers c
    left join nations n
        on c.c_nationkey = n.n_nationkey

)

select *
from customer_enriched
