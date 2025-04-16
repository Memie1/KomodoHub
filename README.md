## KomodoHub Backend Service Setup

The KomodoHub backend is built with **Python 3.8**, **Flask**, **uWSGI**, and **MySQL**. Follow the steps below to set
up and run the server:

1. Ensure you're using **Python 3.8**.
2. Navigate to the `./backend/` directory.
    ```bash
    cd ./backend/
    ```
3. Install the required dependencies:

    ```bash
    pip install -r requirements.txt
    ```

   (Make sure to update the `requirements.txt` with any new libraries and versions when adding dependencies).

4. Ensure the MySQL database exists. If not, create it by running the following command in the MySQL client:

    ```sql
    CREATE DATABASE  if not exists komodo_hub CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
    ```

5. For development purposes, run the application using:

    ```bash
    python app.py
    ```

6. For production, run the application with uWSGI:

    ```bash
    uwsgi --ini uwsgi.ini
    ```

---

## Project Structure

- `app.py`: The main application file where the Flask app is initialized.
- `config.py`: Contains all configuration settings for the app, including the database URI and secret keys.
- `models.py`: Defines the database schema (tables and relationships).
- `routes.py`: Contains all the route definitions for the RESTful API.
- `uwsgi.ini`: Configuration for uWSGI to serve the app in production.
- `wsgi.py`: Entry point for the uWSGI server to run the Flask app.
- `requirements.txt`: Lists all the Python dependencies required for the project.

**Note:**  
The `init.sql` file (located in the root directory) contains the full database schema with English comments.  
It serves as a reference structure and can be adapted based on business requirements.  
Tables may be added, modified, or removed as needed.


---
## Interface curl call case
1. Register interface case
    ```bash
    curl --request POST \
      --url http://localhost:9898/register \
      --header 'Content-Type: application/json' \
      --data '{
       "username": "alice123",
       "password": "securepassword",
       "email": "alice@example.com",
       "role": "STUDENT",
       "full_name": "Alice Zhang",
       "age": 25,
       "gender": "F",
       "bio": "AI lover and Python developer.",
       "avatar_url": "https://example.com/avatar.jpg"
      }'
    ```

    
## Register Page Enhancement by weix20

This update adds a complete role-based registration experience to the KomodoHub platform.

### Key Features:
- Email, password, and confirm password input fields
- Role selection dropdown (User/Admin)
- Privacy policy agreement checkbox (must be checked to register)
- Real-time input validation and friendly error messages

### Technologies Used:
- Vue 3 with `<script setup>`
- Tailwind CSS for styling
- Vite + TypeScript
- Git for version control (branch: `Register_Page`)

### Deployment:
The system has been deployed via Vercel to test the registration UI:  
[Live Demo](https://komodo-hub-nu.vercel.app)

---

Contributed by **weix20**
