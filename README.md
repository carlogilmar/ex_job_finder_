# Take The Risk

## Previous steps:

* Intstall the next dependencies:
    * https://wkhtmltopdf.org/downloads.html

## For run in development mode


1. Download dependencies
```
  mix deps.get
  cd assets && npm install
```

2. Create the database and migrate
```
  mix ecto.create
```
```
  mix ecto.migrate
```

3. Run the seeds for store the admin user, check this file
```
  mix run priv/repo/seeds.exs
```

4. Set environments paths for external services (email and cloudinary)

5. Run the server

```
mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
