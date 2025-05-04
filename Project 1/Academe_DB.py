# === 1. Створення бази даних (PostgreSQL) ===
import psycopg2

class AcademyDB:
    def __init__(self, db_config):
        self.db_config = db_config

    def connect(self):
        return psycopg2.connect(**self.db_config)

    def create_database(self):
        with self.connect() as conn:
            with conn.cursor() as cursor:
                cursor.execute('''CREATE TABLE IF NOT EXISTS faculties (
                    id SERIAL PRIMARY KEY,
                    name TEXT NOT NULL
                )''')

                cursor.execute('''CREATE TABLE IF NOT EXISTS departments (
                    id SERIAL PRIMARY KEY,
                    name TEXT NOT NULL,
                    faculty_id INTEGER REFERENCES faculties(id)
                )''')

                cursor.execute('''CREATE TABLE IF NOT EXISTS groups (
                    id SERIAL PRIMARY KEY,
                    name TEXT NOT NULL,
                    department_id INTEGER REFERENCES departments(id)
                )''')

                cursor.execute('''CREATE TABLE IF NOT EXISTS teachers (
                    id SERIAL PRIMARY KEY,
                    first_name TEXT NOT NULL,
                    last_name TEXT NOT NULL,
                    department_id INTEGER REFERENCES departments(id)
                )''')

                cursor.execute('''CREATE TABLE IF NOT EXISTS subjects (
                    id SERIAL PRIMARY KEY,
                    name TEXT NOT NULL
                )''')

                cursor.execute('''CREATE TABLE IF NOT EXISTS lectures (
                    id SERIAL PRIMARY KEY,
                    teacher_id INTEGER REFERENCES teachers(id),
                    subject_id INTEGER REFERENCES subjects(id),
                    group_id INTEGER REFERENCES groups(id)
                )''')
                
                conn.commit()
                print("Базу даних створено або вже існує.")


# === 2. Робота з базою ===
class AcademyApp:
    def __init__(self, db_config):
        self.db_config = db_config

    def connect(self):
        return psycopg2.connect(**self.db_config)

    def insert_faculty(self, name):
        with self.connect() as conn:
            with conn.cursor() as cursor:
                cursor.execute("INSERT INTO faculties (name) VALUES (%s)", (name,))
                conn.commit()

    def list_all_groups(self):
        with self.connect() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT * FROM groups")
                rows = cursor.fetchall()
                for row in rows:
                    print(row)

    def list_all_teachers(self):
        with self.connect() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT * FROM teachers")
                rows = cursor.fetchall()
                for row in rows:
                    print(row)

    def list_all_departments(self):
        with self.connect() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT name FROM departments")
                rows = cursor.fetchall()
                for row in rows:
                    print(row[0])

    def groups_by_department(self):
        with self.connect() as conn:
            with conn.cursor() as cursor:
                cursor.execute('''
                    SELECT d.name, g.name 
                    FROM departments d
                    JOIN groups g ON d.id = g.department_id
                ''')
                rows = cursor.fetchall()
                for row in rows:
                    print(f"Кафедра: {row[0]} — Група: {row[1]}")
