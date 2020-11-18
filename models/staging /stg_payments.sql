WITH payments AS (

    SELECT
        id                      AS payment_id,
        orderid                 AS order_id,
        paymentmethod           AS payment_method,
        status,
        amount / 100 :: FLOAT  AS payment_amount,
        created                 AS created_at,
        _batched_at
    
    FROM raw.stripe.payment

)

SELECT * 
FROM payments