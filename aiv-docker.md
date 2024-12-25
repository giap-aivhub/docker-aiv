# AIV6 Installation Guide

Welcome to the AIV6 installation guide. Follow the steps below to set up AIV6 on your local machine.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Installation Steps

1. **Install Docker and Docker Compose**  
   You need to install Docker and Docker Compose to set up AIV6 on your machine. Follow the official installation guides:
   - [Install Docker](https://docs.docker.com/get-docker/)
   - [Install Docker Compose](https://docs.docker.com/compose/install/)

2. **Open Command Prompt and Navigate to the AIV Directory**  
   Once Docker and Docker Compose are installed, open a command prompt (or terminal) and navigate to the directory where the `docker-aiv` folder is located.

   ```bash
   cd path/to/docker-aiv
   ```

3. **Run Docker Compose**  
   To set up AIV6, run the following command in the terminal:

   ```bash
   docker compose up -d
   ```

   This will pull the necessary images and start the containers required to run AIV6.

4. **Wait for Setup Completion**  
   Once you run the above command, Docker Compose will set up AIV6 on your machine. Wait until all services are up and running.

5. **Access AIV6**  
   After the setup is complete and all services are started, open your web browser and navigate to:

   ```text
   http://localhost:9090/aiv
   ```

   AIV6 should now be available for you to use.

## Troubleshooting

- If you encounter any issues during installation, ensure Docker and Docker Compose are correctly installed and running.
- Make sure you have enough system resources (CPU, RAM, and storage) to run the Docker containers.
- Contact [support@aivhub.com](mailto:support@aivhub.com) if the issue is not resolved.

---

Thank you for using AIV6!
