from conftest import BASE_URL
import requests
import pytest
import uuid
from datetime import datetime

# Эндпоинты
SIGNUP_ENDPOINT = f"{BASE_URL}/api/sign-up"
LOGIN_ENDPOINT = f"{BASE_URL}/api/login"
RECIPES_ENDPOINT = f"{BASE_URL}/api/recipes"


# ==========================================
# 1. ФИКСТУРЫ (PRE-CONDITIONS)
# ==========================================

@pytest.fixture(scope="module")
def auth_headers():
    """
    Регистрирует пользователя и возвращает заголовки с токеном доступа.
    """
    unique_id = str(uuid.uuid4())[:8]
    user_data = {
        "login": f"cook_{unique_id}",
        "email": f"cook_{unique_id}@test.com",
        "password": "Password123!"
    }
    # Регистрация
    requests.post(SIGNUP_ENDPOINT, json=user_data)
    # Вход
    login_res = requests.post(LOGIN_ENDPOINT, json={
        "login": user_data["login"],
        "password": user_data["password"]
    }).json()

    token = login_res["access_token"]
    return {"Authorization": f"Bearer {token}"}


# ==========================================
# 2. ПОЗИТИВНЫЕ ТЕСТЫ
# ==========================================

def test_publish_recipe_success(auth_headers):
    """Позитивный тест: Успешная публикация полного рецепта"""

    recipe_payload = {
        "title": f"Шедевр от шефа {uuid.uuid4()}",
        "cooking_time_minutes": 45,
        "servings": 4,
        "calories100g": 250,
        "protein100g": 15,
        "fat100g": 10,
        "carb100g": 30,
        "created_at": datetime.now().isoformat() + "Z",
        "description": "Очень вкусный рецепт, проверенный годами",
        "difficulty": 1,
        "images": [
            {"url": "https://image.com/main.jpg", "order": 0}
        ],
        "steps": [
            {
                "title": "Подготовка",
                "step_number": 1,
                "description": "Нарежьте овощи кубиками",
                "image_url": "https://image.com/step1.jpg"
            }
        ],
        "tags": ["ужин", "быстро"],
        "ingredients": [
            {
                "name": "Картофель",
                "calories100g": 77,
                "protein100g": 2,
                "fat100g": 0,
                "carb100g": 17,
                "amount": 500,
                "unit": "г"
            }
        ]
    }

    response = requests.post(RECIPES_ENDPOINT, json=recipe_payload, headers=auth_headers)

    assert response.status_code in [200, 201]
    data = response.json()

    # Проверка схемы ответа (наличие ID)
    assert data["id"] > 0
    assert data["author_id"] > 0
    assert data["title"] == recipe_payload["title"]
    assert len(data["steps"]) == 1
    assert data["steps"][0]["id"] > 0
    assert len(data["ingredients"]) == 1
    assert data["ingredients"][0]["id"] > 0


# ==========================================
# 3. НЕГАТИВНЫЕ ТЕСТЫ (ВАЛИДАЦИЯ)
# ==========================================

def test_publish_recipe_unauthorized():
    """Негативный тест: Публикация без токена авторизации"""
    payload = {"title": "Test"}
    response = requests.post(RECIPES_ENDPOINT, json=payload)

    assert response.status_code == 401


@pytest.mark.parametrize("field, value", [
    ("title", ""),  # Пустой заголовок
    ("cooking_time_minutes", -5),  # Отрицательное время
    ("difficulty", 10),  # Несуществующий уровень сложности
])
def test_publish_recipe_invalid_data(auth_headers, field, value):
    """Негативный тест: Проверка валидации полей"""
    # Базовый корректный пак
    payload = {
        "title": "Valid Title",
        "cooking_time_minutes": 10,
        "description": "Valid Description",
        field: value
    }

    response = requests.post(RECIPES_ENDPOINT, json=payload, headers=auth_headers)

    assert response.status_code == 400


def test_publish_recipe_missing_nested_fields(auth_headers):
    """Негативный тест: Отправка ингредиента без названия"""
    payload = {
        "title": "Recipe",
        "ingredients": [
            {"amount": 100}  # Пропущено имя и КБЖУ
        ]
    }
    response = requests.post(RECIPES_ENDPOINT, json=payload, headers=auth_headers)
    assert response.status_code == 400


# ==========================================
# 4. КРАЕВЫЕ СЛУЧАИ (EDGE CASES)
# ==========================================

def test_publish_recipe_extra_long_description(auth_headers):
    """Крайний случай: Сверхдлинное описание"""
    payload = {
        "title": "Long Desc Recipe",
        "description": "A" * 5000,  # 5000 символов
        "cooking_time_minutes": 10
    }
    response = requests.post(RECIPES_ENDPOINT, json=payload, headers=auth_headers)

    # Зависит от лимитов БД. Если лимит меньше 5000 - будет 400. Если TEXT - 200/201.
    assert response.status_code in [200, 201, 400]


def test_publish_recipe_no_tags_no_steps(auth_headers):
    """Крайний случай: Публикация с пустыми списками тегов, шагов и фото"""
    payload = {
        "title": "Minimal Recipe",
        "cooking_time_minutes": 5,
        "description": "Just a title and time",
        "images": [],
        "steps": [],
        "tags": [],
        "ingredients": []
    }
    response = requests.post(RECIPES_ENDPOINT, json=payload, headers=auth_headers)

    assert response.status_code in [400]