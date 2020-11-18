{{config(materialized='table')}}

WITH orders AS (

    SELECT * FROM {{ ref('stg_orders') }}

),

payments AS (

    SELECT * FROM {{ ref('stg_payments') }}
),

final_cte as (

    SELECT

        orders.order_id
        , orders.customer_id
        , orders.order_date
        , orders.status             AS order_status
        , payments.payment_id
        , payments.payment_method
        , payments.status           AS payment_status
        , payments.payment_amount
        , payments.created_at

    FROM orders
    INNER JOIN payments ON payments.order_id = orders.order_id

)

SELECT *
FROM final_cte