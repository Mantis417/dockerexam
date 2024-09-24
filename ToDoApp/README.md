# ToDoApp

This app is a simple todo app, built on ASP.NET Core Razor Pages, that uses CRUD operations to a NoSQL database.

It uses a local JSON file as database by default, but you can however make it use a MongoDB by setting an environment variable:

```bash
export TODO_SERVICE_IMPLEMENTATION=MongoDb
```

You can find the MongoDB settings for a local database instance in `appsettings.Development.json`
