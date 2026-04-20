from conftest import BASE_URL
import requests
import pytest
import uuid

SIGNUP_ENDPOINT = f"{BASE_URL}/api/sign-up"

# ==========================================
# 1. ПОДГОТОВКА ДАННЫХ (ФИКСТУРА)
# ==========================================

# Этого пользователя мы "засеем" в базу для тестирования ошибок дубликатов
EXISTING_USER = {
    "login": "duplicate_user",
    "email": "duplicate@mail.com",
    "password": "StrongPassword123!"
}


@pytest.fixture(scope="module", autouse=True)
def setup_existing_user():
    """
    Эта фикстура выполнится 1 раз перед запуском тестов в этом файле.
    Она регистрирует базового пользователя, об которого будут "спотыкаться"
    тесты на проверку уникальности email и логина.
    """
    response = requests.post(SIGNUP_ENDPOINT, json=EXISTING_USER)

    # Если мы запускаем тесты второй раз (без перезапуска докера),
    # юзер уже будет в базе (вернется 400 или 409). Это нормально.
    # Главное, что теперь мы на 100% уверены, что он там есть.
    assert response.status_code in [200, 201, 400, 409]


# ==========================================
# 2. ТЕСТЫ (TEST CASES)
# ==========================================

def test_signup_success():
    """Позитивный тест: Успешная регистрация с новыми данными"""

    # Генерируем уникальные данные, чтобы тест проходил всегда,
    # даже если запускать его 100 раз подряд
    unique_suffix = str(uuid.uuid4())[:8]  # Выдаст что-то вроде '1a2b3c4d'

    payload = {
        "login": f"new_user_{unique_suffix}",
        "email": f"user_{unique_suffix}@mail.com",
        "password": "ValidPassword123!"
    }

    response = requests.post(SIGNUP_ENDPOINT, json=payload)

    # Успешное создание ресурса - это обычно 200 OK или 201 Created
    assert response.status_code in [200, 201], f"Ошибка: {response.text}"


def test_signup_duplicate_both():
    """Негативный тест: Совпадает и логин, и email"""

    # Пытаемся зарегистрировать юзера, который уже создан нашей фикстурой
    response = requests.post(SIGNUP_ENDPOINT, json=EXISTING_USER)

    # Конфликт данных - это 409 Conflict или 400 Bad Request
    assert response.status_code in [400, 409]

    # Проверяем текст ошибки (приводим к нижнему регистру для надежности)
    error_text = response.text.lower()
    assert "already exists" in error_text
    assert "login" in error_text
    assert "email" in error_text


def test_signup_duplicate_email_only():
    """Негативный тест: Уникальный логин, но email уже занят"""

    unique_suffix = str(uuid.uuid4())[:4]

    payload = {
        "login": f"unique_login_{unique_suffix}",
        "email": EXISTING_USER["email"],  # Берем занятый email
        "password": "ValidPassword123!"
    }

    response = requests.post(SIGNUP_ENDPOINT, json=payload)

    assert response.status_code in [400, 409]

    error_text = response.text.lower()
    assert "already exists" in error_text
    assert "email" in error_text


def test_signup_duplicate_login_only():
    """Негативный тест: Уникальный email, но логин уже занят"""

    unique_suffix = str(uuid.uuid4())[:4]

    payload = {
        "login": EXISTING_USER["login"],  # Берем занятый логин
        "email": f"unique_{unique_suffix}@mail.com",
        "password": "ValidPassword123!"
    }

    response = requests.post(SIGNUP_ENDPOINT, json=payload)

    assert response.status_code in [400, 409]

    error_text = response.text.lower()
    assert "already exists" in error_text
    assert "login" in error_text


@pytest.mark.parametrize("missing_field", ["login", "email", "password"])
def test_signup_missing_required_fields(missing_field):
    """
    Негативный тест: Отправка JSON без обязательных полей.
    Благодаря декоратору @pytest.mark.parametrize, этот тест
    запустится 3 раза (по одному разу удаляя каждое поле).
    """
    payload = {
        "login": "some_user_123",
        "email": "some_email@mail.com",
        "password": "Password123!"
    }

    # Удаляем одно из полей из словаря
    del payload[missing_field]

    response = requests.post(SIGNUP_ENDPOINT, json=payload)

    # Ошибка валидации структуры (отсутствие обязательного поля) - это строго 400 Bad Request
    assert response.status_code == 400