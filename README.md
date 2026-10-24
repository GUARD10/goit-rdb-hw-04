# goit-rdb-hw-04

Домашнє завдання 4: створення таблиць і зв’язків, JOIN та групування даних у MySQL.

Репозиторій: [GUARD10/goit-rdb-hw-04](https://github.com/GUARD10/goit-rdb-hw-04).

## Структура

```text
goit-rdb-hw-04/
├── database/
│   ├── csv/                              # 8 CSV із даними ДЗ 3
│   ├── init/                             # Автоматична ініціалізація MySQL
│   │   ├── 01_hw03_schema.sql            # Структура торгової БД
│   │   ├── 02_hw03_seed.sql              # Завантаження CSV
│   │   ├── 03_create_library.sql         # Завдання 1: структура бібліотеки
│   │   └── 04_seed_library.sql           # Завдання 2: тестові дані
│   └── queries/                          # Окремий файл для кожного запиту
│       ├── task_3_join_all_tables.sql
│       ├── task_4_1_count_inner.sql
│       ├── task_4_2_count_left.sql
│       ├── task_4_2_count_right.sql
│       ├── task_4_3_filter_employees.sql
│       ├── task_4_4_group_categories.sql
│       ├── task_4_5_having_quantity.sql
│       ├── task_4_6_sort_categories.sql
│       └── task_4_7_limit_offset.sql
├── screenshots/
│   ├── task_1/                           # Структура бібліотеки
│   ├── task_2/                           # Тестові дані бібліотеки
│   ├── task_3/                           # Результат JOIN восьми таблиць
│   └── task_4/                           # Результати підпунктів завдання 4
│       ├── task_4_2_explenation.txt       # Пояснення зміни кількості рядків
│       └── …_result.png                  # Скриншоти відповідних запитів
├── goit-rdb.compose.yaml                  # MySQL 8.4, порт і том даних
└── README.md
```

Початкові CSV з попереднього завдання збережені. Їх копія завантажується в `goit_rdb_hw_03`; бібліотека має окрему назву `LibraryManagement`, як вимагає умова.

## Запуск

Команди виконуйте з кореня проєкту із запущеним Docker Desktop.

Кожен запит у `database/queries` має окремий файл із власним `USE`, тому його можна відкрити й виконати незалежно у Workbench. Назви запитів містять номер завдання без порядкового префікса; відповідні скриншоти мають таку саму назву з постфіксом `_result`. У `init` збережено префікси `01`–`04` для порядку виконання. Init-файли містять створення та наповнення БД для пунктів 1–2 і дані попереднього завдання.

```powershell
docker compose -f goit-rdb.compose.yaml up -d
docker compose -f goit-rdb.compose.yaml logs -f mysql
```

Дочекайтеся завершення init-скриптів і повідомлення `ready for connections` з портом `3306`. Вийти з перегляду логів можна через Ctrl+C.

Параметри підключення у MySQL Workbench або DBeaver:

| Параметр | Значення |
| --- | --- |
| Host | `127.0.0.1` |
| Port | `3308` |
| User | `goit_hw_04` |
| Password | `goit_hw_04_local` |
| Схеми | `goit_rdb_hw_03`, `LibraryManagement` |

Контейнер `goit-rdb-hw-04-mysql` і том `goit-rdb-hw-04_mysql_data` належать цьому завданню. Порт `3308` дозволяє працювати поряд з попереднім проєктом на порту `3307`. Паролі в Compose призначені для локального навчального середовища.

Init-скрипти виконуються автоматично лише під час першого запуску з порожнім томом. Повторний запуск `up -d` зберігає дані. Після автоматичної ініціалізації повторно виконувати INSERT із seed-файлів не потрібно.

Запуск перевірок через консоль:

```powershell
docker compose -f goit-rdb.compose.yaml exec mysql mysql -u goit_hw_04 -p
```

Після введення пароля виконайте в клієнті MySQL:

```sql
SOURCE /queries/task_3_join_all_tables.sql;
SOURCE /queries/task_4_1_count_inner.sql;
SOURCE /queries/task_4_2_count_left.sql;
SOURCE /queries/task_4_2_count_right.sql;
SOURCE /queries/task_4_3_filter_employees.sql;
SOURCE /queries/task_4_4_group_categories.sql;
SOURCE /queries/task_4_5_having_quantity.sql;
SOURCE /queries/task_4_6_sort_categories.sql;
SOURCE /queries/task_4_7_limit_offset.sql;
```

Зупинка зі збереженням даних:

```powershell
docker compose -f goit-rdb.compose.yaml down
```

### Повна повторна ініціалізація

Щоб розгорнути бази заново з актуальних init-скриптів і CSV, видаліть контейнер разом із томом даних та запустіть проєкт повторно:

```powershell
docker compose -f goit-rdb.compose.yaml down --volumes
docker compose -f goit-rdb.compose.yaml up -d
docker compose -f goit-rdb.compose.yaml logs -f mysql
```

**Увага:** `down --volumes` видаляє том `goit-rdb-hw-04_mysql_data` з усіма даними схем `goit_rdb_hw_03` та `LibraryManagement`. Зміни, зроблені вручну в БД, буде втрачено. SQL-файли, CSV і скриншоти в проєкті залишаться. Після запуску на новому порожньому томі всі чотири init-скрипти виконаються автоматично.

## Результати перевірки

Перевірено на локальному MySQL 8.4. Усі дев’ять файлів із `database/queries` виконуються без помилок. Результати відповідають наданим скриншотам і початковим CSV.

| Пункт | SQL-файл у `database/queries` | Результат |
| --- | --- | --- |
| 3 | `task_3_join_all_tables.sql` | 518 рядків після об’єднання восьми таблиць |
| 4.1 | `task_4_1_count_inner.sql` | COUNT = 518 |
| 4.2 | `task_4_2_count_left.sql` | COUNT = 518; лише два JOIN замінено на LEFT |
| 4.2 | `task_4_2_count_right.sql` | COUNT = 535; збережено 17 клієнтів без замовлень |
| 4.3 | `task_4_3_filter_employees.sql` | 317 рядків із `employee_id > 3 AND employee_id <= 10` |
| 4.4 | `task_4_4_group_categories.sql` | 8 категорій, COUNT і AVG(quantity) |
| 4.5 | `task_4_5_having_quantity.sql` | 7 категорій із середньою кількістю понад 21 |
| 4.6 | `task_4_6_sort_categories.sql` | 7 категорій за спаданням COUNT |
| 4.7 | `task_4_7_limit_offset.sql` | 4 категорії після пропуску першої |

Фінальний результат:

| category_name | row_count | average_quantity |
| --- | --- | --- |
| Dairy Products | 58 | 27.4655 |
| Confections | 51 | 23.8627 |
| Seafood | 40 | 22.7000 |
| Meat/Poultry | 31 | 21.5806 |

## Скриншоти

У проєкті є 11 скриншотів:

- [Структура бібліотеки](screenshots/task_1/create_library_result.png) — п’ять таблиць та їхні поля.
- [Дані бібліотеки](screenshots/task_2/seed_library_result.png) — об’єднаний результат із даними всіх п’яти таблиць.
- [Завдання 3](screenshots/task_3/task_3_join_all_tables_result.png) — SQL та результат JOIN.
- [Завдання 4](screenshots/task_4/) — вісім скриншотів SQL і результатів; назва кожного відповідає запиту з постфіксом `_result`.
