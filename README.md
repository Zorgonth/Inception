# Inception

## Table of Contents
- [Overview](#overview)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Services](#services)
  - [MariaDB](#mariadb)
  - [Nginx](#nginx)
  - [WordPress](#wordpress)
- [Setup and Usage](#setup-and-usage)
- [Author](#author)

## Overview

The Inception project is part of the 42 curriculum, focusing on system administration and containerization. The goal of this project is to build a multi-container environment using Docker and Docker Compose. The services include a web server (Nginx), a relational database (MariaDB), and a dynamic content management system (WordPress). 

This project emphasizes container orchestration, automation, and applying DevOps best practices for deploying and managing a small web infrastructure.

## Technologies Used
- **Docker**: Containerization platform for packaging services.
- **Docker Compose**: Tool for defining and running multi-container Docker applications.
- **MariaDB**: Open-source relational database.
- **Nginx**: High-performance HTTP server and reverse proxy.
- **WordPress**: Popular open-source CMS for creating websites.

## Project Structure

```bash
inception/
├── Makefile
├── srcs/
│   ├── docker-compose.yml
│   ├── requirements/
│   │   ├── mariadb/
│   │   │   ├── 50-server.cnf
│   │   │   ├── Dockerfile
│   │   │   ├── db_init.sql
│   │   │   └── script.sh
│   │   ├── nginx/
│   │   │   ├── Dockerfile
│   │   │   └── conf/
│   │   │       └── default
│   │   ├── wordpress/
│   │       ├── Dockerfile
│   │       ├── setup.sh
│   │       └── wp-config.php
└── data/
    ├── mariadb/
    └── wordpress/
```

## Services

### MariaDB
MariaDB is used to manage the database for WordPress, handling the storage of all user data. The service includes a custom configuration to optimize performance and security.

- **Dockerfile**: Based on `debian:bullseye`, installs and configures MariaDB.
- **db_init.sql**: A script that sets up the database, user, and permissions when the container is launched.
- **Configuration**: The `50-server.cnf` file adjusts server settings like the socket path and charset.
- **Data Persistence**: Database data is stored in a volume to retain data across container restarts.

### Nginx
Nginx is configured to serve as the web server and reverse proxy, managing incoming requests and ensuring secure connections through SSL.

- **Dockerfile**: Installs `nginx` and configures SSL certificates.
- **SSL**: Self-signed certificates are generated and stored in `/etc/nginx/ssl/`.
- **Configuration**: The config file located at `nginx/conf/default` specifies how Nginx handles HTTP and HTTPS traffic and forwards requests to the WordPress PHP service.

### WordPress
WordPress provides the content management system (CMS) for the website. This service allows users to manage content, posts, and pages easily through a web-based interface.

- **Dockerfile**: Sets up WordPress with PHP and necessary extensions like `php-fpm` and `php-mysqli`.
- **Setup Script**: The `setup.sh` script automates the WordPress installation, setting up database credentials and initial configurations.
- **Configuration**: `wp-config.php` contains the necessary credentials for database connections and WordPress configurations.

## Setup and Usage

### Prerequisites
Ensure the following tools are installed on your system before running the project:
- **Docker**: [Get Docker](https://docs.docker.com/get-docker/)
- **Docker Compose**: [Install Docker Compose](https://docs.docker.com/compose/install/)

### Steps to Run

1. **Clone the Repository**
   Download the repository to your local machine:
   ```bash
   git clone https://github.com/zorgonth/Inception.git
   cd inception
   ```
2. ***Build and Run Services**
   To build and start all services using Docker Compose, run:
   ```
   make
   ```
3. ***Stop and Remove Services***
   To stop and remove all containers, networks, and volumes:
   ```
   make down
   ```
## Author

This project was completed as part of the 42 Network's curriculum at 42 Heilbronn. It was designed and implemented by:

- **Saadoun Al-zubaidi**  
  Full-Stack Developer with a passion for cloud-native applications and systems architecture.
   

