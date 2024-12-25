# AIV6 Application Installation and Configuration

## Prerequisites
Before proceeding, ensure you have the following installed and configured on your system:
- **Java 17 or above** installed and set as the default `JAVA_HOME`.
- **PostgreSQL** installed and configured.

---

## Step 1: Install Java 17 or Above

1. Download the appropriate version of Java 17 or higher from the [Oracle JDK download page](https://www.oracle.com/java/technologies/javase-jdk17-downloads.html) or use OpenJDK.
2. Install it on your system by following the installation instructions specific to your operating system.
3. After installation, set the `JAVA_HOME` environment variable:
    - **Windows**:
      - Open **System Properties** > **Advanced System Settings**.
      - Click on **Environment Variables**.
      - Add a new system variable called `JAVA_HOME` and set the value to the installation path (e.g., `C:\Program Files\Java\jdk-17`).
      - Add `JAVA_HOME\bin` to your `PATH` variable.
    - **Linux/macOS**:
      - Open your terminal and edit the `~/.bashrc` or `~/.bash_profile` file (depending on the shell you use).
      - Add the following lines:
        ```bash
        export JAVA_HOME=/path/to/java17
        export PATH=$JAVA_HOME/bin:$PATH
        ```
      - Run `source ~/.bashrc` or `source ~/.bash_profile` to apply the changes.

4. Verify the installation by running:
    ```bash
    java -version
    ```

---

## Step 2: Install PostgreSQL

### Option 1: Installing PostgreSQL (General)
1. **Download PostgreSQL**:  
   - Visit the [official PostgreSQL website](https://www.postgresql.org/download/) and select the version appropriate for your OS.
   - Follow the instructions provided on the download page.

2. **Install PostgreSQL**:
    - **Windows**:
        1. Download the installer.
        2. Run the installer, choose the default settings, and set the password for the PostgreSQL superuser (default user: `postgres`).
    - **macOS**:
        1. Use `Homebrew` to install PostgreSQL:
            ```bash
            brew install postgresql
            ```
        2. Start the PostgreSQL service:
            ```bash
            brew services start postgresql
            ```
    - **Linux**:
        1. On Debian/Ubuntu:
            ```bash
            sudo apt update
            sudo apt install postgresql postgresql-contrib
            ```
        2. On RedHat/CentOS:
            ```bash
            sudo yum install postgresql-server postgresql-contrib
            ```

3. **Verify Installation**:
    After installation, confirm that PostgreSQL is installed and running:
    ```bash
    psql --version
    ```

---

## Step 3: Download and Install the AIV6 Application

1. Download the AIV6 application from [this link](https://dist.aivhub.com/aiv.zip).

---

## Step 4: Configure Installation Inside `install.sh`

To configure the installation, you'll need to update specific fields in the `install.sh` file. Follow these steps:

1. **Edit the `install.sh` File**: Open the `install.sh` file in a text editor.
2. **Update the Database Configuration**: Modify the following variables to reflect your database host, port, database name, user, and password:

    ```bash
    # Set the variables
    aiv_db_url="jdbc:postgresql://localhost:5432/aiv6"
    aiv_db_user="postgres"
    aiv_db_password="xy6ffnVb\$qNf7pYz8T"
    
    security_db_url="jdbc:postgresql://localhost:5432/aiv6?currentSchema=security"
    security_db_user="postgres"
    security_db_password="xy6ffnVb\$qNf7pYz8T"
    ```
3. **Create Database in Postgres if it is other than postgres**: In step 2 here it is aiv6 so make sure you create database aiv6 in postgres database.

### Important Note:
#### Special Character Handling for Passwords:
- If your password contains the `$` character or any other special characters, you need to escape them with a backslash (`\`).
- For example, if your password is `xy6ffnVb$qNf7pYz8T`, you should set it as: `xy6ffnVb\$qNf7pYz8T`.

This configuration ensures your installation script is properly set up with the correct database connection details, including special character handling for passwords.

## Step 5: Start Your AIV Application (`aiv.sh`)

1. **Run the `aiv.sh` Script**: 
    - In the terminal, navigate to the `aiv` folder where the `aiv.sh` file is located.
    - Run the following command:
        ```bash
        ./aiv.sh
        ```

2. **Handling Permission Denied Errors**:
    - If you encounter a "Permission denied" error, it means the script does not have execute permissions.
    - Resolve this by granting execute permissions with the following command:
        ```bash
        chmod +x aiv.sh
        ```

3. **Re-run the Script**:
    - After setting the permissions, re-run the installation script:
        ```bash
        ./aiv.sh
        ```

This process will start the AIV application.
