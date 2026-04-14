# CookifyApp
Репозиторий приложения Cookify. Приложение создается как огромная база данных различных рецептов дополняемая пользователями приложения.

## Test running
To run tests you need to install Python

**1. Install uv (pocket manager, you can run this command from any place)**
on windows
```bash
pip install uv
```
on Mac
```bash
brew install uv
```

**2. Download all project dependency**
Run this command inside "tests" folder
```bash
uv sync
```
**3_1. Run all tests**
```bash
uv run pytest -v
```
**3_2. Run one test**
```bash
uv run pytest test_recipes_api.py -v
```