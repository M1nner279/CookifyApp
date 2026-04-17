# CookifyApp
Репозиторий приложения Cookify. Приложение создается как огромная база данных различных рецептов дополняемая пользователями приложения.

## Test running
To run tests you need to install Python

### 1. Install uv
(uv is pocket manager, you can run this command from any place)
on windows
```bash
pip install uv
```
on Mac
```bash
brew install uv
```

### 2. Download all project dependency

Run this commands INSIDE "tests" folder
```bash
uv sync
```
### 3. Run tests
To run test you need to run docker-compose

#### 3.1 Run all tests
```bash
uv run pytest test_files/ -v -s
```
#### 3.2 Run one test
```bash
uv run pytest test_files\test_recipes_api.py -v -s
```
****