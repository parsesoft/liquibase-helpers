# Liquibase command-line helpers


## Features

- Opinionated **boilerplate structure** for Liquibase projects with **context-aware configuration**.
- Friendly Liquibase **command-line wrappers** (Windows only). Configure once and then just call `do <command>` (usually, without any more arguments). There's also a command-line `menu` including the most common commands.
- Generation of Microsoft SQL Server objects (**procedures**, **functions** and **views**) in formatted SQL which can be edited and tested using the usual tools (eg. Management Studio).


## Dependencies

### Java runtime

Download from [https://java.com/en/download/manual.jsp](https://java.com/en/download/manual.jsp)

### SqlCmd.exe

This comes with SQL Server, but can be installed independently. Select *SqlCmdLnUtils.msi* and *sqlncli.msi* for your platform either from:

- [Microsoft SQL Server 2008 R2 SP1 Feature Pack](http://www.microsoft.com/en-us/download/details.aspx?id=26728)
- [Microsoft SQL Server 2012 SP1 Feature Pack](http://www.microsoft.com/en-us/download/details.aspx?id=35580) (recommended)

Then, first run `sqlncli.msi` and then `SqlCmdLnUtils.msi`.

### Liquibase

Included in *tools* directory.


## Liquibase basics
Pointers to Liquibase documentation:

- [Quickstart](http://www.liquibase.org/quickstart.html)
- [Adding Liquibase on an existing project](http://www.liquibase.org/documentation/existing_project.html)
- [Bundled Liquibase changes](http://www.liquibase.org/documentation/changes/)
- [Column tag](http://www.liquibase.org/documentation/column.html)


## Helpers

- `do.bat <command>`: Runs a `<command>` over *main.xml* in both common and specific contexts. See [Liquibase commands](http://www.liquibase.org/documentation/command_line.html).
- `generate.bat`: Generates baseline changelog and database objects in common context.
- `menu.bat`: Launches common Liquibase tasks
- `diff.bat <db1> <db2>`: Generates a changelog between databases `<db1>` and `<db2>` (in the same server) to standard output. Use redirection operator `>` to save it to a file.

## Workflows

### Create a new project

- Clone this repository.
- Copy *contexts\common\config.bat.template* to *config.bat* (which is *.gitignore*'d) and complete settings. You don't need to directly execute *config.bat*.
- Create at least one empty context. This is used to validate context prompt. See next section.

### Create a new context

- Create a new directory under *contexts\\* (eg. `mkdir contexts\name_of_the_context`)
- Create an empty *config.bat* file under your new directory.

### Create a baseline for an existing database

- Run `generate.bat`.
- Run `do changelogSync`.

### Configure a context

After you create more than one context, you'll want to differentiate them.

- Edit *config.bat* so it overwrites some or all settings of common *config.bat*.
- Copy *contexts\common\main.xml* to *contexts\name_of_the_context\main.xml* and customize.
- Create a *changelog-nnn.xml* file and reference it in *main.xml*, if needed.
- Create subdirectories for scripts and reference them in *main.xml*, if needed.
- TO-DO: Implement an automated task.

### Add a change

- Edit *changelog-001.xml* or scripts in *procedures*, *views* and *functions* directories.
- Run `do validate`.
- Run `do updateSQL` to preview your changes.
- Run `do update` to apply your chanages.

**Tip:** There are sample changesets in *changelog-000.xml.template*.

### Check pending changes

- Run `do status` to get a count of pending changes.
- Or run `do status --verbose` to get also a list of pending changes.

### Reset scripts

If there seems to be no pending changes but you still think source and database objects are not properly synchronized:

- Run `exec reset_scripts`.
- Run `do update`.

### Tag database state

- Run `do tag <tag_name>`.

Note you can also [create a tag in the changelog](http://www.liquibase.org/documentation/changes/tag_database.html).

### Rollback to tag

- Run `do rollbackSQL <tag_name>` to preview the rollback changes.
- Run `do rollback <tag_name>` to rollback to the state when the tag was applied.

### Rollback last N changes

- Run `do rollbackCountSQL <N>` to preview the rollback the last N changes.
- Run `do rollbackCount <N>` to rollback the last N changes.


## Best practices

Adapted from [here](http://www.liquibase.org/bestpractices.html).

### Managing Stored Procedures

Try to maintain separate changelog for Stored Procedures and use `runOnChange="true"`. 

This flag forces Liquibase to check if the changeset was modified. 

If so, Liquibase executes the change again.

### One Change per ChangeSet

As far as possible, avoid multiple changes per changeset 
to avoid failed autocommit statements that can leave the database in an unexpected state.

### ChangeSet Ids

Choose what works for you. 

Some use a sequence number starting from 1 and unique within the changelog, some choose a descriptive name (e.g. `new-address-table`).

### Document ChangeSets

Use `<comments>` in the change sets. They say “A stitch in time saves nine!”

### Always think about rollback

Try to write changesets in a way that they can be rolled back. 
e.g. use relevant change clause instead of using custom `<sql>` tag. 

Include a `<rollback>` clause whenever a change doesn’t support out of box rollback. (e.g. `<sql>`, `<insert>`, etc)

### Reference Data Management

Leverage Liquibase to manage your Reference Data. 
Environment separation (DEV, QA, PROD) can be achieved using `context`.

### Workflow for the developer

- Using your favorite IDE or editor, create a new local changeSet containing the change;
- Run Liquibase to execute the new changeSet (this tests the SQL code);
- Perform the corresponding changes in the application code (e.g., Java code);
- Test the new application code together with the database change;
- Commit both the changeSet and the application code.

