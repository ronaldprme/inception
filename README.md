## What I Learned and Why I Loved This Project 🚀

### 🧠 Key Topics Learned

- **Docker & Docker Compose**  
  Learned to create and orchestrate multiple Docker containers using `docker-compose.yml`, avoiding ready-made images and writing custom `Dockerfile`s for each service.

- **Infrastructure as Code**  
  Structured an entire infrastructure as code, using a `Makefile` to automate the full setup, including building images and launching services.

- **Multi-service Architecture**  
  Implemented a service-oriented system with:
  - **NGINX** with TLS 1.2/1.3 as a secure entrypoint
  - **MariaDB** as the database backend
  - **WordPress (with php-fpm)** served through NGINX
  - **Persistent volumes** for both website files and the database

- **Security Best Practices**  
  Gained awareness of secure container configuration:
  - Used `.env` files for sensitive credentials
  - Avoided hardcoded passwords
  - Learned to separate secrets and environment variables

- **Custom Networking**  
  Built and managed a Docker network manually to ensure secure inter-container communication — avoiding deprecated options like `--link` and `network: host`.

- **System Admin Foundations**  
  Practiced essential sysadmin skills like service isolation, automated restarts and proper file structure.

- **Domain Configuration (Local DNS)**  
  Configured a custom domain (`login.42.fr`) to point to my local IP and correctly route traffic via NGINX.

---

### ❤️ Why I Loved This Project

- **Hands-On DevOps**  
  This project bridges the gap between development and system administration, offering a real-world experience of setting up infrastructure from scratch.

- **Complete Ownership**  
  From Dockerfile to DNS, I had full control over the stack. It felt like building my own mini-cloud infrastructure.

- **Reinforced Best Practices**  
  Enforced clean code structure, security-conscious design, and modern containerization techniques.

- **High Value for Learning**  
  It pushed me to go beyond tutorials and read official documentation. I now understand not just *how* things work, but also *why* they’re designed that way.

- **A Foundation for Real Projects**  
  I can now confidently set up a secure, modular, and maintainable container-based environment — a critical skill in modern software development.

---

🎯 This was one of the most rewarding projects in my journey so far — technically rich, practically useful, and deeply satisfying to complete.
