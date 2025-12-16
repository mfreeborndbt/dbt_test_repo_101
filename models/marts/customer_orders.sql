{{ config(
    materialized = 'table'
) }}

with order_items as (

    select *
    from {{ ref('order_items') }}

),

customer_enriched as (

    select *
    from {{ ref('enriched_customers') }}

),

final as (

    select
        -- keep all order/line-level fields
        oi.*,

        -- add customer enrichment
        c.customer_name,
        c.customer_address,
        c.customer_phone,
        c.account_balance,
        c.market_segment,
        c.customer_comment,
        c.nation_name,
        c.region_key,
        c.nation_comment

    from order_items oi
    left join customer_enriched c
        on oi.customer_id = c.customer_id
)

select *
from final
