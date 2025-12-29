## Database schema

```mermaid
erDiagram
  LOCATION ||--o{ DEPARTMENT : "location_id"
  DEPARTMENT ||--o{ EMPLOYEE : "department_id"
  JOB ||--o{ EMPLOYEE : "job_id"
  EMPLOYEE ||--o{ EMPLOYEE : "manager_id"
  EMPLOYEE ||--o{ CUSTOMER : "salesperson_id"
  CUSTOMER ||--o{ SALES_ORDER : "customer_id"
  SALES_ORDER ||--o{ ITEM : "order_id"
  PRODUCT ||--o{ ITEM : "product_id"
  PRODUCT ||--o{ PRICE : "product_id"

  LOCATION {
    SERIAL location_id PK
    VARCHAR regional_group
  }

  DEPARTMENT {
    SERIAL department_id PK
    VARCHAR name
    INTEGER location_id FK
  }

  JOB {
    SERIAL job_id PK
    VARCHAR function
  }

  EMPLOYEE {
    SERIAL employee_id PK
    VARCHAR last_name
    VARCHAR first_name
    VARCHAR middle_initial
    INTEGER manager_id FK
    INTEGER job_id FK
    TIMESTAMP hire_date
    NUMERIC salary
    NUMERIC commission
    INTEGER department_id FK
  }

  CUSTOMER {
    SERIAL customer_id PK
    VARCHAR name
    VARCHAR address
    VARCHAR city
    VARCHAR state
    VARCHAR zip_code
    SMALLINT area_code
    INTEGER phone_number
    INTEGER salesperson_id FK
    NUMERIC credit_limit
    VARCHAR comments
  }

  SALES_ORDER {
    SERIAL order_id PK
    TIMESTAMP order_date
    INTEGER customer_id FK
    TIMESTAMP ship_date
    NUMERIC total
  }

  PRODUCT {
    SERIAL product_id PK
    VARCHAR description
  }

  ITEM {
    INTEGER order_id PK, FK
    INTEGER item_id PK
    INTEGER product_id FK
    NUMERIC actual_price
    INTEGER quantity
    NUMERIC total
  }

  PRICE {
    INTEGER product_id PK, FK
    TIMESTAMP start_date PK
    TIMESTAMP end_date
    NUMERIC list_price
    NUMERIC min_price
  }
```

### Notes on the implementation

- The script in `sql/postgres_schema.sql` matches the relationships above and also sets foreign-key constraints for every link shown.
- The `item` table uses a composite primary key of `(order_id, item_id)` to align with the original data; this still enforces the relationships shown in the diagram.
- The `price` table accepts `end_date` as nullable to accommodate open-ended pricing rows while keeping `(product_id, start_date)` unique.
- All identifier columns are declared as `SERIAL` (or integer) with sequences reset to the maximum seeded values for seamless additional inserts.
