You can grab the database connection directly from the Laravel console (`php artisan tinker`) using the `DB` facade. Here are some useful commands:

### 1. **Get the Current Database Connection**
```php
DB::connection();
```
This returns the current database connection instance.

### 2. **Check the Database Name**
```php
DB::connection()->getDatabaseName();
```
This will return the name of the database Laravel is connected to.

### 3. **Get Connection Configuration**
To get the details of the current database connection:
```php
DB::connection()->getConfig();
```
This will return an array with details like `host`, `port`, `database`, `username`, etc.

### 4. **Run a Raw Query**
To test if the database connection is working, run:
```php
DB::select('SELECT DATABASE()');
```
This should return the currently connected database.

### 5. **Check Active Database Driver**
```php
DB::connection()->getDriverName();
```
This will return the database driver (e.g., `mysql`, `pgsql`, `sqlite`).

Would you like to log this info from a custom Artisan command?