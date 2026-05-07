from conftest import BASE_URL
import requests
import pytest
import uuid
import io

# Эндпоинты
SIGNUP_ENDPOINT = f"{BASE_URL}/api/sign-up"
LOGIN_ENDPOINT = f"{BASE_URL}/api/login"
ME_ENDPOINT = f"{BASE_URL}/api/users/me"
AVATAR_ENDPOINT = f"{BASE_URL}/api/users/me/avatar"


# ==========================================
# 1. ФИКСТУРЫ (PRE-CONDITIONS)
# ==========================================

@pytest.fixture(scope="module")
def auth_headers():
    """
    Регистрирует нового пользователя и выполняет вход,
    чтобы получить токен авторизации.
    """
    unique_id = str(uuid.uuid4())[:8]
    user_data = {
        "login": f"user_{unique_id}",
        "email": f"{unique_id}@test.com",
        "password": "Password123!"
    }

    # 1. Регистрация
    requests.post(SIGNUP_ENDPOINT, json=user_data)

    # 2. Вход (предполагаем, что логин возвращает access_token)
    login_res = requests.post(LOGIN_ENDPOINT, json={
        "login": user_data["login"],
        "password": user_data["password"]
    })

    token = login_res.json().get("access_token")
    return {"Authorization": f"Bearer {token}"}


# ==========================================
# 2. ТЕСТЫ ПОЛУЧЕНИЯ ПРОФИЛЯ (GET /me)
# ==========================================

def test_get_me_success(auth_headers):
    """Позитивный тест: Успешное получение данных своего профиля"""
    response = requests.get(ME_ENDPOINT, headers=auth_headers)

    assert response.status_code == 200
    data = response.json()

    # Проверка структуры ответа
    assert "id" in data
    assert "login" in data
    assert "email" in data
    assert "createdAt" in data
    assert "avatarUrl" in data  # Может быть None/null, но ключ должен быть

    # Проверка вложенной статистики
    stats = data.get("statistic")
    assert stats is not None
    assert "favoriteRecipesCount" in stats
    assert "createdRecipesCount" in stats
    assert "publishedRecipesCount" in stats


def test_get_me_unauthorized():
    """Негативный тест: Попытка получить профиль без токена"""
    response = requests.get(ME_ENDPOINT)

    # Ожидаем 401 Unauthorized
    assert response.status_code == 401
