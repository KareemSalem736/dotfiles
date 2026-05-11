[[ReadItLater]] [[Article]]

# [Navigating HikariCP Connection Pool Issues: When Your Database Says “No More Connections!”](https://medium.com/@raphy.26.007/navigating-hikaricp-connection-pool-issues-when-your-database-says-no-more-connections-3203217a14a0)

[

![Rafi Syed](ReadItLater%20Inbox/assets/Navigating%20HikariCP%20Connection%20Pool%20Issues%20When%20Your%20Database%20Says%20“No%20More%20Connections!”-3hMxZBC6ds.png)



](https://medium.com/@raphy.26.007?source=post_page---byline--3203217a14a0---------------------------------------)

Database connection management is a critical aspect of application performance and reliability. When your application suddenly can’t create new database connections — even though HikariCP’s connection pool is configured — it can lead to downtime, slow response times, or cascading failures. One common error message you might encounter in this scenario is:

> ***“remaining connection slots are reserved for non-replication superuser connections”***

This article dives into why this happens, how HikariCP settings like `idle-timeout` and `max-lifetime` influence connection reuse, and actionable steps to resolve these issues.

## Understanding HikariCP’s Idle Timeout and Max Lifetime

## Idle Timeout: The Parking Lot Rule

Imagine a parking lot (connection pool) where cars (database connections) park when unused. The **idle timeout** is like a rule that says: *“If a car isn’t driven for 10 minutes, tow it to free up space.”*

-   **What It Does**: Closes connections that remain idle (unused) for a configured duration.
-   **Example**: Setting `idle-timeout=600000` (10 minutes) ensures unused connections are closed after 10 minutes of inactivity.

## Max Lifetime: The Car Replacement Policy

Now imagine every car in the lot must be replaced after 30 minutes, regardless of usage. This is the **max lifetime** setting.

-   **What It Does**: Closes and replaces connections after a fixed duration, even if active.
-   **Example**: `max-lifetime=1800000` (30 minutes) refreshes connections to avoid staleness or network issues.

## Key Difference

-   **Idle Timeout** manages *unused* connections.
-   **Max Lifetime** manages *age* of connections, active or idle.

## Why New Connections Are Created Despite Idle Ones

If your application is creating new connections while idle ones exist, here’s why:

1.  **Connection Validation Failures**:  
    Idle connections are validated before reuse. If validation fails (e.g., network hiccup), HikariCP discards them and creates new ones.
2.  **High Concurrency Spikes**:  
    During traffic surges, if all idle connections are in use, HikariCP spawns new ones up to `maximum-pool-size`.
3.  **Misconfigured Pool Limits**:

`minimum-idle` too low: The pool may not retain enough warm connections.

`maximum-pool-size` exceeding the database’s `max_connections` limit.

4**. Connection Leaks**:  
Unclosed connections (e.g., unreturned to the pool) remain marked as “in use,” forcing new connections.

5**. Transaction Isolation**:  
Long-running transactions hold connections hostage, preventing reuse.

## Diagnosing the “Remaining Connection Slots” Error

This error occurs when your database (e.g., PostgreSQL) runs out of connection slots. Here’s how to troubleshoot:

## Step 1: Check Active Connections

Run this query to see who’s consuming connections:

```
SELECT datname, usename, state, COUNT(*)FROM pg_stat_activityGROUP BY datname, usename, state;
```

## Step 2: Identify Leaks or Long-Running Queries

Look for:

-   **Idle connections**: Connections unused but not closed.
-   **Active connections**: Queries taking too long (e.g., missing indexes).

## Step 3: Terminate Problematic Connections

Free slots by closing idle connections:

```
SELECT pg_terminate_backend(pid)FROM pg_stat_activityWHERE state = 'idle' AND now() - state_change > interval '10 minutes';
```

## Fixing the Root Cause: Configuration and Best Practices

## 1\. Tune HikariCP Settings

Align pool settings with your database’s capacity:

```
spring.datasource.hikari:  maximum-pool-size: 20       # Match DB's max_connections - reserved slots  minimum-idle: 5             # Keep some connections warm  idle-timeout: 60000         # Close idle connections after 1 minute  max-lifetime: 1800000       # Replace connections every 30 minutes  leak-detection-threshold: 2000  # Log leaks after 2 seconds
```

## 2\. Increase PostgreSQL’s `max_connections`

Edit `postgresql.conf` and restart:

```
max_connections = 200         # Default is typically 100
```

**Caution**: More connections = higher memory usage. Monitor your DB server’s RAM.

## 3\. Use PgBouncer for Efficient Pooling

PgBouncer acts as a middleware connection pooler, reducing the load on PostgreSQL:

```
max_client_conn = 500         # Client connections to PgBouncerdefault_pool_size = 20        # Actual PostgreSQL connections
```

## 4\. Fix Connection Leaks in Code

-   **Close resources explicitly**: Use `try-with-resources` for streams, resultsets, and connections.
-   **Avoid long transactions**: Keep `@Transactional` methods short; avoid external API calls inside transactions.

**Example Fix**:

```
// Before: Connection leak risk!Stream<Data> stream = jdbcTemplate.queryForStream("SELECT ...");
```

```
// After: Automatically close the streamtry (Stream<Data> stream = repository.getAllStream()) {    return stream.map(...).toList();}
```

## 5\. Monitor and Optimize Queries

-   Log slow queries:

```
ALTER DATABASE mydb SET log_min_duration_statement = 2000; # Log >2s queries
```

Use indexes to reduce query execution time.