import json
from sqlalchemy import create_engine, Column, Integer, String, Date, func
from sqlalchemy.orm import declarative_base, sessionmaker
from datetime import datetime

# 📥 Зчитування логіну і пароля з config.json
with open('config.json', 'r') as file:
    data = json.load(file)
    login = data['login']
    password = data['password']

# 🔌 Створення engine для SQLAlchemy
engine = create_engine(f"postgresql+pg8000://{login}:{password}@localhost:5432/people", echo=False)
Session = sessionmaker(bind=engine)
session = Session()

Base = declarative_base()

# 📋 Модель таблиці
class Person(Base):
    __tablename__ = 'people'
    id = Column(Integer, primary_key=True)
    name = Column(String)
    birth_date = Column(Date)
    country = Column(String)

# ⚠️ Створити таблицю, якщо ще не існує
Base.metadata.create_all(engine)

# ➕ Додати людину
def add_person(name, birth_date_str, country):
    birth_date = datetime.strptime(birth_date_str, "%Y-%m-%d").date()
    person = Person(name=name, birth_date=birth_date, country=country)
    session.add(person)
    session.commit()

# 🔤 Імена з певної літери
def get_people_by_letter(letter):
    return session.query(Person).filter(func.lower(Person.name).like(letter.lower() + "%")).all()

# 📅 Народжені після дати
def get_people_born_after(date_str):
    dt = datetime.strptime(date_str, "%Y-%m-%d").date()
    return session.query(Person).filter(Person.birth_date > dt).all()

# 🌍 Кількість людей у країні
def count_people_in_country(country):
    return session.query(func.count()).filter(func.lower(Person.country) == country.lower()).scalar()

# 🧪 Меню
if __name__ == "__main__":
    while True:
        print("\n1. Додати")
        print("2. Пошук по літері")
        print("3. Після дати")
        print("4. Порахувати по країні")
        print("0. Вихід")

        choice = input("Виберіть дію: ")

        if choice == "1":
            n = input("Ім'я: ")
            b = input("Дата народження (YYYY-MM-DD): ")
            c = input("Країна: ")
            add_person(n, b, c)
            print("✅ Додано")

        elif choice == "2":
            l = input("Літера: ")
            results = get_people_by_letter(l)
            for r in results:
                print(r.name, r.birth_date, r.country)

        elif choice == "3":
            d = input("Дата (YYYY-MM-DD): ")
            results = get_people_born_after(d)
            for r in results:
                print(r.name, r.birth_date, r.country)

        elif choice == "4":
            c = input("Країна: ")
            print(f"🔢 Кількість: {count_people_in_country(c)}")

        elif choice == "0":
            break

        else:
            print("❌ Невірний вибір.")
