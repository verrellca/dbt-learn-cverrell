{{config(materialized='table')}}

WITH customers AS (

    SELECT 
        customer_id
        , first_name
        , last_name

    FROM {{ ref('stg_customers') }}
),


customers_orders_payments AS (

    SELECT * FROM {{ ref('orders') }} 

),

final AS (

    SELECT
        customers.customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(CASE WHEN payment_status = 'success' THEN payment_amount END) as life_time_value

    FROM customers 
    INNER JOIN customers_orders_payments ON customers_orders_payments.customer_id = customers.customer_id

    GROUP BY 1

)

SELECT * 
FROM final