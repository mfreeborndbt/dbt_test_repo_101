with orders as (

    select *
    from {{ ref('stg_TPCH__ORDERS') }}

),

lineitems as (

    select *
    from {{ ref('stg_TPCH__LINEITEM') }}

),

order_lines as (

    select
        -- order-level fields
        o.order_id,
        o.customer_id,
        o.order_status,
        o.total_price,
        o.order_date,
        o.order_priority,
        o.clerk,
        o.ship_priority,
        o.comment as order_comment,

        -- line-level fields
        l.line_number,
        l.part_id,
        l.supplier_id,
        l.quantity,
        l.extended_price,
        l.discount,
        l.tax,
        l.return_flag,
        l.line_status,
        l.ship_date,
        l.commit_date,
        l.receipt_date,
        l.ship_instructions,
        l.ship_mode,
        l.comment as line_comment

    from lineitems l
    left join orders o
        on l.order_id = o.order_id
)

select *
from order_lines
