BEGIN;

        CREATE TABLE PART (
                P_PARTKEY               SERIAL8,
                P_NAME                  VARCHAR(55),
                P_MFGR                  CHAR(25),
                P_BRAND                 CHAR(10),
                P_TYPE                  VARCHAR(25),
                P_SIZE                  INTEGER,
                P_CONTAINER             CHAR(10),
                P_RETAILPRICE   DECIMAL,
                P_COMMENT               VARCHAR(23)
        ) with (APPENDONLY=true,BLOCKSIZE=2097152,ORIENTATION=COLUMN,COMPRESSTYPE=QUICKLZ,CHECKSUM=true,OIDS=false);

        COPY part FROM '/tmp/dss-data/part.csv' WITH csv DELIMITER '|';

COMMIT;

BEGIN;

        CREATE TABLE REGION (
                R_REGIONKEY     SERIAL8,
                R_NAME          CHAR(25),
                R_COMMENT       VARCHAR(152)
        ) with (APPENDONLY=true,BLOCKSIZE=2097152,ORIENTATION=COLUMN,COMPRESSTYPE=QUICKLZ,CHECKSUM=true,OIDS=false);

        COPY region FROM '/tmp/dss-data/region.csv' WITH csv DELIMITER '|';

COMMIT;

BEGIN;

        CREATE TABLE NATION (
                N_NATIONKEY             SERIAL8,
                N_NAME                  CHAR(25),
                N_REGIONKEY             BIGINT NOT NULL,  -- references R_REGIONKEY
                N_COMMENT               VARCHAR(152)
        ) with (APPENDONLY=true,BLOCKSIZE=2097152,ORIENTATION=COLUMN,COMPRESSTYPE=QUICKLZ,CHECKSUM=true,OIDS=false);

        COPY nation FROM '/tmp/dss-data/nation.csv' WITH csv DELIMITER '|';

COMMIT;

BEGIN;

        CREATE TABLE SUPPLIER (
                S_SUPPKEY               SERIAL8,
                S_NAME                  CHAR(25),
                S_ADDRESS               VARCHAR(40),
                S_NATIONKEY             BIGINT NOT NULL, -- references N_NATIONKEY
                S_PHONE                 CHAR(15),
                S_ACCTBAL               DECIMAL,
                S_COMMENT               VARCHAR(101)
        ) with (APPENDONLY=true,BLOCKSIZE=2097152,ORIENTATION=COLUMN,COMPRESSTYPE=QUICKLZ,CHECKSUM=true,OIDS=false);

        COPY supplier FROM '/tmp/dss-data/supplier.csv' WITH csv DELIMITER '|';

COMMIT;

BEGIN;

        CREATE TABLE CUSTOMER (
                C_CUSTKEY               SERIAL8,
                C_NAME                  VARCHAR(25),
                C_ADDRESS               VARCHAR(40),
                C_NATIONKEY             BIGINT NOT NULL, -- references N_NATIONKEY
                C_PHONE                 CHAR(15),
                C_ACCTBAL               DECIMAL,
                C_MKTSEGMENT    CHAR(10),
                C_COMMENT               VARCHAR(117)
        ) with (APPENDONLY=true,BLOCKSIZE=2097152,ORIENTATION=COLUMN,COMPRESSTYPE=QUICKLZ,CHECKSUM=true,OIDS=false);

        COPY customer FROM '/tmp/dss-data/customer.csv' WITH csv DELIMITER '|';

COMMIT;

BEGIN;

        CREATE TABLE PARTSUPP (
                PS_PARTKEY              BIGINT NOT NULL, -- references P_PARTKEY
                PS_SUPPKEY              BIGINT NOT NULL, -- references S_SUPPKEY
                PS_AVAILQTY             INTEGER,
                PS_SUPPLYCOST   DECIMAL,
                PS_COMMENT              VARCHAR(199)
        ) with (APPENDONLY=true,BLOCKSIZE=2097152,ORIENTATION=COLUMN,COMPRESSTYPE=QUICKLZ,CHECKSUM=true,OIDS=false);

        COPY partsupp FROM '/tmp/dss-data/partsupp.csv' WITH csv DELIMITER '|';

COMMIT;

BEGIN;

        CREATE TABLE ORDERS (
                O_ORDERKEY              SERIAL8,
                O_CUSTKEY               BIGINT NOT NULL, -- references C_CUSTKEY
                O_ORDERSTATUS   CHAR(1),
                O_TOTALPRICE    DECIMAL,
                O_ORDERDATE             DATE,
                O_ORDERPRIORITY CHAR(15),
                O_CLERK                 CHAR(15),
                O_SHIPPRIORITY  INTEGER,
                O_COMMENT               VARCHAR(79)
        ) with (APPENDONLY=true,BLOCKSIZE=2097152,ORIENTATION=COLUMN,COMPRESSTYPE=QUICKLZ,CHECKSUM=true,OIDS=false);

        COPY orders FROM '/tmp/dss-data/orders.csv' WITH csv DELIMITER '|';

COMMIT;

BEGIN;

        CREATE TABLE LINEITEM (
                L_ORDERKEY              BIGINT NOT NULL, -- references O_ORDERKEY
                L_PARTKEY               BIGINT NOT NULL, -- references P_PARTKEY (compound fk to PARTSUPP)
                L_SUPPKEY               BIGINT NOT NULL, -- references S_SUPPKEY (compound fk to PARTSUPP)
                L_LINENUMBER    INTEGER,
                L_QUANTITY              DECIMAL,
                L_EXTENDEDPRICE DECIMAL,
                L_DISCOUNT              DECIMAL,
                L_TAX                   DECIMAL,
                L_RETURNFLAG    CHAR(1),
                L_LINESTATUS    CHAR(1),
                L_SHIPDATE              DATE,
                L_COMMITDATE    DATE,
                L_RECEIPTDATE   DATE,
                L_SHIPINSTRUCT  CHAR(25),
                L_SHIPMODE              CHAR(10),
                L_COMMENT               VARCHAR(44)
        ) with (APPENDONLY=true,BLOCKSIZE=2097152,ORIENTATION=COLUMN,COMPRESSTYPE=QUICKLZ,CHECKSUM=true,OIDS=false);

        COPY lineitem FROM '/tmp/dss-data/lineitem.csv' WITH csv DELIMITER '|';

COMMIT;
