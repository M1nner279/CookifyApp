from conftest import BASE_URL
import requests
import pytest
import uuid

SIGNUP_ENDPOINT = f"{BASE_URL}/api/sign-up"
LOGIN_ENDPOINT = f"{BASE_URL}/api/login"
REFRESH_ENDPOINT = f"{BASE_URL}/api/refresh"


# ==========================================
# 1. ФИКСТУРЫ (PRE-CONDITIONS)
# ==========================================

@pytest.fixture(scope="module")
def registered_user():
    """
    Создает уникального пользователя перед началом тестов в этом модуле.
    Возвращает словарь с логином и паролем.
    """
    unique_id = str(uuid.uuid4())[:8]
    user_data = {
        "login": f"auth_user_{unique_id}",
        "email": f"auth_{unique_id}@test.com",
        "password": "Password123!"
    }

    # Регистрируем пользователя
    response = requests.post(SIGNUP_ENDPOINT, json=user_data)
    assert response.status_code in [200, 201], f"Не удалось подготовить юзера: {response.text}"

    return user_data


# ==========================================
# 2. ТЕСТЫ ВХОДА (LOGIN)
# ==========================================

def test_login_success(registered_user):
    """Позитивный тест: Успешный вход и получение токенов"""
    payload = {
        "login": registered_user["login"],
        "password": registered_user["password"]
    }

    response = requests.post(LOGIN_ENDPOINT, json=payload)

    assert response.status_code == 200
    data = response.json()

    # Проверяем наличие токенов в ответе
    assert "access_token" in data
    assert "refresh_token" in data
    assert isinstance(data["access_token"], str)
    assert isinstance(data["refresh_token"], str)


def test_login_wrong_password(registered_user):
    """Негативный тест: Неверный пароль"""
    payload = {
        "login": registered_user["login"],
        "password": "WrongPassword_123"
    }

    response = requests.post(LOGIN_ENDPOINT, json=payload)

    # Обычно 401 Unauthorized
    assert response.status_code == 401


def test_login_non_existent_user():
    """Негативный тест: Вход несуществующим пользователем"""
    payload = {
        "login": f"ghost_user_{uuid.uuid4()}",
        "password": "SomePassword123"
    }

    response = requests.post(LOGIN_ENDPOINT, json=payload)

    assert response.status_code == 401


# ==========================================
# 3. ТЕСТЫ ОБНОВЛЕНИЯ ТОКЕНОВ (REFRESH)
# ==========================================

def test_refresh_tokens_success(registered_user):
    """Позитивный тест: Успешное обновление пары токенов"""

    # 1. Сначала входим, чтобы получить актуальный refresh_token
    login_payload = {
        "login": registered_user["login"],
        "password": registered_user["password"]
    }
    login_res = requests.post(LOGIN_ENDPOINT, json=login_payload).json()
    old_access_token = login_res["access_token"]
    old_refresh_token = login_res["refresh_token"]

    # 2. Отправляем refresh_token на обновление
    refresh_payload = {
        "refresh_token": old_refresh_token
    }
    response = requests.post(REFRESH_ENDPOINT, json=refresh_payload)

    assert response.status_code == 200
    new_data = response.json()

    assert "access_token" in new_data
    assert "refresh_token" in new_data

    # Проверяем, что новый access_token отличается от старого
    assert new_data["access_token"] != old_access_token


def test_refresh_with_invalid_token():
    """Негативный тест: Обновление с поддельным токеном"""
    payload = {
        "refresh_token": "this.is.not.a.valid.token"
    }

    response = requests.post(REFRESH_ENDPOINT, json=payload)

    # Ожидаем 401 Unauthorized или 400 Bad Request
    assert response.status_code in [400, 401]


@pytest.mark.parametrize("payload", [
    {},  # Пустое тело
    {"token": "some_token"},  # Неверное имя поля (вместо refresh_token)
])
def test_refresh_invalid_payload(payload):
    """Негативный тест: Некорректная структура JSON"""
    response = requests.post(REFRESH_ENDPOINT, json=payload)

    assert response.status_code == 400