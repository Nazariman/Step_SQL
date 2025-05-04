from Academe_DB import AcademyDB, AcademyApp

def main():
    db_config = {
        'dbname': 'academy2',
        'user': 'postgres',
        'password': 'root',
        'host': 'localhost',
        'port': '5432'
    }

    db = AcademyDB(db_config)
    db.create_database()

    app = AcademyApp(db_config)

    while True:
        print("\n1. Додати факультет")
        print("2. Показати всі групи")
        print("3. Показати всіх викладачів")
        print("4. Показати всі кафедри")
        print("5. Показати кафедри та їхні групи")
        print("0. Вийти")
        
        choice = input("Оберіть опцію: ")
        if choice == '1':
            name = input("Назва факультету: ")
            app.insert_faculty(name)
        elif choice == '2':
            app.list_all_groups()
        elif choice == '3':
            app.list_all_teachers()
        elif choice == '4':
            app.list_all_departments()
        elif choice == '5':
            app.groups_by_department()
        elif choice == '0':
            break
        else:
            print("Невірний вибір")

if __name__ == "__main__":
    main()
