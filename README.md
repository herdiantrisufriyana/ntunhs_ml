# NTUNHS Data Mining Course

This repository provides the programming environment for the NTUNHS Data Mining course.

You do NOT need to install R, RStudio, or Python manually. Everything runs inside Docker.

---

# 1. First-Time Setup (Do Once Only)

## Step 1 — Create a GitHub Account

Go to:

https://github.com

Create a free account.

---

## Step 2 — Install Git

Download:

https://git-scm.com/downloads

After installation, verify in terminal:

```bash
git --version
```

---

## Step 3 — Install Docker Desktop

Download:

https://docs.docker.com/get-started/get-docker/

After installation:
- Open Docker Desktop
- Make sure it is running

---

## Step 4 — Install VS Code

Download:

https://code.visualstudio.com/download

---

# 2. Get the Course Repository

## Step 1 — Fork the Repository

Go to:

https://github.com/herdiantrisufriyana/ntunhs_dm

Click **Fork** to create your own copy.

---

## Step 2 — Clone Your Fork

Open VS Code.

Click:

**Clone Git Repository**

Change YOUR_GITHUB_USERNAME below your our own user name then copy and paste into the bar:

```
https://github.com/YOUR_GITHUB_USERNAME/ntunhs_dm.git
```

Open the cloned folder.

---

## Step 3 — Connect to Instructor Repository (For Updates)

Open terminal in VS Code:

Terminal → New Terminal

Run:

```bash
git remote add upstream https://github.com/herdiantrisufriyana/ntunhs_dm.git
```

---

# 3. Build and Run the Environment

In the project root folder, run:

```bash
docker compose up -d --build
```

First build may take several minutes.

---

# 4. Access the Applications

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

# 5. Stop the Environment

```bash
docker compose down
```

---

# 6. Update from Instructor

When the instructor updates the repository:

```bash
git fetch upstream
git merge upstream/master
docker compose up -d --build
```

---

# Important Rules

- Do NOT upload large datasets (>25 MB) to GitHub.
- Only push code.
- Keep your data inside your local project folder.

---

You are now ready to use R and Python in a fully reproducible environment.
