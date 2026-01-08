---
name: pdata
description: Use when creating a pdata. 
---

# Creating a pdata

## Overview

A pdata simply is a node script that patches data.

**Announce at start:** "I'm using the creating-a-pdata skill to create a pdata."

## Location and filenames

Patch data are located in applications/plato/scripts/pdata and are split into calendar months.
They include the jira issue number.
They are written in Typescript.
Examples of legit pathnames :
    - applications/plato/scripts/pdata/2026-01/PROD-28660.ts
    - applications/plato/scripts/pdata/2025-12/ML-20963.ts
    - applications/plato/scripts/pdata/2025-11/ML-17662.ts

## Duck generator

It's recommended to use the Pdata Generator to generate new pdata.
```bash
cd applications/plato/scripts/pdata && duck generate pdata
```

It will ask for the 3 question 
✔ Enter the pdata name [THE_ISSUE_ID]
✔ Select a template "generic"
✔ Do you want to initialize the message broker? "no"

## Logging

All actions must properly be logged with the loglevel according to the severity of the issue, in order for the script to properly report events, using $services/logger

```ts
import logger from "#src/services/logger.ts";
````

Each log must be written in English and contain the ISSUE_ID in its context.

### Connecting to a database

For now, the way to connect to a database is to use its model.
Example below with the 'rgiCompensation' model

```ts
import { RgiCompensationModel } from "#models/rgiCompensation.ts";
```

### Running it

```bash
cd applications/plato/scripts/pdata && pnpm pdata scripts/pdata/2026-01/PROD-28616.ts
```
