BEGIN;


CREATE TABLE IF NOT EXISTS "shipment" (
  "shipment_id" BIGINT NOT NULL UNIQUE,
  PRIMARY KEY ("shipment_id"),
  "delivery_order_id" BIGINT NOT NULL,
  "courier_id" BIGINT NOT NULL,
  "tracking_number" VARCHAR(100) UNIQUE,
  "shipped_at" DATETIME NOT NULL,
  "delivered_at" DATETIME
);


CREATE TABLE IF NOT EXISTS "delivery_route" (
  "delivery_route_id" BIGINT NOT NULL UNIQUE,
  PRIMARY KEY ("delivery_route_id"),
  "route_name" VARCHAR(255) NOT NULL,
  "origin" VARCHAR(255) NOT NULL,
  "destination" VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS "courier" (
  "courier_id" BIGINT NOT NULL UNIQUE,
  PRIMARY KEY ("courier_id"),
  "courier_name" VARCHAR(255) NOT NULL,
  "phone" VARCHAR(50) UNIQUE,
  "vehicle_type" VARCHAR(100) NOT NULL
);


CREATE TABLE IF NOT EXISTS "customer" (
  "customer_id" BIGINT NOT NULL UNIQUE,
  PRIMARY KEY ("customer_id"),
  "customer_name" VARCHAR(255) NOT NULL,
  "customer_email" VARCHAR(255) UNIQUE
);


CREATE TABLE IF NOT EXISTS "address" (
  "address_id" BIGINT NOT NULL UNIQUE,
  PRIMARY KEY ("address_id"),
  "street" VARCHAR(255) NOT NULL,
  "city" VARCHAR(100) NOT NULL,
  "postal_code" VARCHAR(20) NOT NULL
);


CREATE TABLE IF NOT EXISTS "delivery_order" (
  "delivery_order_id" BIGINT NOT NULL UNIQUE,
  PRIMARY KEY ("delivery_order_id"),
  "customer_id" BIGINT NOT NULL,
  "address_id" BIGINT NOT NULL,
  "order_date" DATETIME NOT NULL,
  "status" VARCHAR(50) NOT NULL
);


CREATE TABLE IF NOT EXISTS "order_item" (
  "order_item_id" BIGINT NOT NULL UNIQUE,
  PRIMARY KEY ("order_item_id"),
  "delivery_order_id" BIGINT NOT NULL,
  "product_id" BIGINT NOT NULL,
  "quantity" INT NOT NULL,
  "unit_price" DECIMAL(10, 2) NOT NULL
);


CREATE TABLE IF NOT EXISTS "product" (
  "product_id" BIGINT NOT NULL UNIQUE,
  PRIMARY KEY ("product_id"),
  "product_name" VARCHAR(255) NOT NULL,
  "sku" VARCHAR(100) UNIQUE,
  "unit_price" DECIMAL(10, 2) NOT NULL
);


ALTER TABLE "delivery_order"
ADD CONSTRAINT "FK_delivery_order_customer" FOREIGN KEY ("customer_id") REFERENCES "customer" ("customer_id");


ALTER TABLE "delivery_order"
ADD CONSTRAINT "FK_delivery_order_address" FOREIGN KEY ("address_id") REFERENCES "address" ("address_id");


ALTER TABLE "order_item"
ADD CONSTRAINT "FK_order_item_delivery_order" FOREIGN KEY ("delivery_order_id") REFERENCES "delivery_order" ("delivery_order_id");


ALTER TABLE "order_item"
ADD CONSTRAINT "FK_order_item_product" FOREIGN KEY ("product_id") REFERENCES "product" ("product_id");


ALTER TABLE "shipment"
ADD CONSTRAINT "FK_shipment_delivery_order" FOREIGN KEY ("delivery_order_id") REFERENCES "delivery_order" ("delivery_order_id");


ALTER TABLE "shipment"
ADD CONSTRAINT "FK_shipment_courier" FOREIGN KEY ("courier_id") REFERENCES "courier" ("courier_id");


ALTER TABLE "shipment"
ADD CONSTRAINT "FK_shipment_delivery_route" FOREIGN KEY ("delivery_order_id") REFERENCES "delivery_route" ("delivery_route_id");


COMMIT;