# NTUNHS Machine Learning Course

This repository provides the programming environment for the NTUNHS Machine Learning course.

You do NOT need to install R, RStudio, or Python manually. Everything runs inside Docker.

---

# 1. First-Time Setup (Do Once Only)

## Step 1 — Install Git

Download:

https://git-scm.com/downloads

After installation, verify in terminal:

```bash
git --version
```

---

## Step 2 — Install Docker Desktop

Download:

https://docs.docker.com/get-started/get-docker/

After installation:
- Open Docker Desktop
- Make sure it is running

---

## Step 3 — Install VS Code

Download:

https://code.visualstudio.com/download

---

# 2. Get the Course Repository

## Step 1 — Clone the Repository

Open VS Code.

Click:

**Clone Git Repository**

```
https://github.com/herdiantrisufriyana/ntunhs_ml.git
```

Open the cloned folder.

---

# 2. Build and Run the Environment

In the project root folder, run:

```bash
docker compose up -d --build
```

First build may take several minutes.

---

# 3. Access the Applications

## RStudio (No Login Required)

Open:

http://localhost:8787

Go to working directory:

```
~/project
```

---

## JupyterLab (No Token Required)

Open:

http://localhost:8888

---

# 4. Stop the Environment

```bash
docker compose down
```

---

# 5. Update from Instructor

When the instructor updates the repository, just start from step 1.

---

# Important Rules

- Create backup of index.Rmd and other intermediate files that you edit by yourself.

---

You are now ready to use R and Python in a fully reproducible environment.
