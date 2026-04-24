from conftest import BASE_URL
import requests
import pytest

# Эндпоинты
TAGS_SEARCH = f"{BASE_URL}/api/search/tags"
INGREDIENTS_SEARCH = f"{BASE_URL}/api/search/ingredients"
RECIPES_SEARCH = f"{BASE_URL}/api/search/recipes"


# ==========================================
# 1. ПОИСК ТЕГОВ (TAGS)
# ==========================================

def test_search_tags_by_name_success():
    """Позитивный тест: Поиск тегов по части имени"""
    params = {"name": "за"}  # Например, "завтрак", "закуска"
    response = requests.get(TAGS_SEARCH, params=params)

    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, list)
    if len(data) > 0:
        assert "id" in data[0]
        assert "name" in data[0]
        assert "за" in data[0]["name"].lower()


# ==========================================
# 2. ПОИСК ИНГРЕДИЕНТОВ (INGREDIENTS)
# ==========================================

def test_search_ingredients_by_name_success():
    """Позитивный тест: Поиск ингредиентов и проверка КБЖУ в ответе"""
    params = {"name": "кур"}  # Например, "курица"
    response = requests.get(INGREDIENTS_SEARCH, params=params)

    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, list)

    if len(data) > 0:
        ingredient = data[0]
        assert "id" in ingredient
        assert "name" in ingredient
        # Проверяем наличие КБЖУ (как было указано в ТЗ)
        expected_fields = ["calories", "proteins", "fats", "carbs"]
        for field in expected_fields:
            assert field in ingredient, f"Поле {field} отсутствует в ингредиенте"


# ==========================================
# 3. ПОИСК РЕЦЕПТОВ (RECIPES)
# ==========================================

def test_search_recipes_by_title_success():
    """Позитивный тест: Базовый поиск рецепта по названию"""
    params = {"name": "Паста"}
    response = requests.get(RECIPES_SEARCH, params=params)

    assert response.status_code == 200
    data = response.json()

    assert "items" in data
    assert "last_id" in data
    assert isinstance(data["items"], list)

    if len(data["items"]) > 0:
        assert "Паста" in data["items"][0]["title"]


def test_search_recipes_complex_filters():
    """Позитивный тест: Поиск со всеми фильтрами (КБЖУ, сложность, время, теги)"""
    params = {
        "name": "Постный",
        "maxCookingTime": 60,
        "minCalories": 10,
        "maxCalories": 1000,
        "minProtein": 0,
        "maxProtein": 100,
        "minFat": 0,
        "maxFat": 100,
        "minCarb": 0,
        "maxCarb": 200,
        "difficulty": 0,  # Легко
        "tagIds": "1,2",  # Теги строкой через запятую (согласно описанию апи)
        "ingredientIds": "5,10"
    }

    response = requests.get(RECIPES_SEARCH, params=params)

    assert response.status_code == 200
    data = response.json()
    assert "items" in data

    # Если результаты есть, проверяем, что они соответствуют фильтрам (например, по времени)
    for item in data["items"]:
        assert item["cooking_time_min"] <= 60
        assert item["difficulty"] == 0


def test_search_recipes_empty_results():
    """Позитивный тест: Поиск несуществующего рецепта"""
    params = {"name": "несуществующий_рецепт_12345"}
    response = requests.get(RECIPES_SEARCH, params=params)

    assert response.status_code == 200
    data = response.json()
    assert len(data["items"]) == 0


# ==========================================
# 4. НЕГАТИВНЫЕ ТЕСТЫ И ВАЛИДАЦИЯ
# ==========================================

@pytest.mark.parametrize("param_name", [
    "maxCookingTime", "minCalories", "maxProtein", "difficulty"
])
def test_search_recipes_invalid_types(param_name):
    """Негативный тест: Передача строки вместо числа в числовые фильтры"""
    params = {param_name: "привет_я_строка"}
    response = requests.get(RECIPES_SEARCH, params=params)

    # Ожидаем 400 Bad Request из-за ошибки валидации типов
    assert response.status_code == 400


def test_search_recipes_logic_error_calories():
    """Негативный тест: Мин. калории больше макс. калорий"""
    params = {
        "minCalories": 500,
        "maxCalories": 100
    }
    response = requests.get(RECIPES_SEARCH, params=params)

    # Либо сервер вернет 400, либо пустой список.
    # Если бэкенд умный — вернет 400.
    assert response.status_code in [200, 400]
    if response.status_code == 200:
        assert len(response.json()["items"]) == 0


def test_search_recipes_extreme_values():
    """Крайний случай: Сверхдлинный запрос в имени"""
    params = {"name": "A" * 1000}
    response = requests.get(RECIPES_SEARCH, params=params)

    # Сервер должен либо отработать (200), либо вернуть ошибку о слишком длинном URI (414)
    assert response.status_code in [200, 414]
    if response.status_code == 200:
        assert isinstance(response.json()["items"], list)