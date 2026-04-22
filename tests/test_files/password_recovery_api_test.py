from conftest import BASE_URL
import requests
import pytest
import uuid

RESTORE_ENDPOINT = f"{BASE_URL}/api/restore"
CONFIRM_ENDPOINT = f"{BASE_URL}/api/otp/confirm"
RESEND_ENDPOINT = f"{BASE_URL}/api/otp/resend"
SIGNUP_ENDPOINT = f"{BASE_URL}/api/sign-up"

# в DEV-окружении нужно чтобы код восстановления был всегда таким
MASTER_CODE = "6767"


# ==========================================
# 1. ФИКСТУРЫ
# ==========================================

@pytest.fixture(scope="module")
def active_user():
    """Создает пользователя для тестов восстановления"""
    unique_id = str(uuid.uuid4())[:8]
    user_data = {
        "login": f"restore_user_{unique_id}",
        "email": f"restore_{unique_id}@test.com",
        "password": "InitialPassword67!"
    }
    requests.post(SIGNUP_ENDPOINT, json=user_data)
    return user_data


# ==========================================
# 2. ТЕСТЫ ВОССТАНОВЛЕНИЯ
# ==========================================

def test_restore_request_success(active_user):
    """Позитивный тест: Запрос кода по логину и по почте"""
    # Проверяем по логину
    res_login = requests.post(RESTORE_ENDPOINT, json={"login": active_user["login"]})
    assert res_login.status_code == 200

    # Проверяем по email
    res_email = requests.post(RESTORE_ENDPOINT, json={"login": active_user["email"]})
    assert res_email.status_code == 200


def test_restore_user_not_found():
    """Негативный тест: Запрос кода для несуществующего пользователя"""
    payload = {"login": "definitely_not_exists_676767"}
    response = requests.post(RESTORE_ENDPOINT, json=payload)

    # Ожидаем 404 Not Found
    assert response.status_code == 404


def test_confirm_otp_success(active_user):
    """Позитивный тест: Подтверждение верным кодом"""
    # 1. Запрашиваем код
    requests.post(RESTORE_ENDPOINT, json={"login": active_user["login"]})

    # 2. Подтверждаем мастер-кодом
    payload = {
        "login": active_user["login"],
        "code": MASTER_CODE
    }
    response = requests.post(CONFIRM_ENDPOINT, json=payload)

    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert "refresh_token" in data


def test_confirm_otp_wrong_code(active_user):
    """Негативный тест: Подтверждение неверным кодом"""
    requests.post(RESTORE_ENDPOINT, json={"login": active_user["login"]})

    payload = {
        "login": active_user["login"],
        "code": "0000"  # Заведомо неверный код
    }
    response = requests.post(CONFIRM_ENDPOINT, json=payload)

    # Ожидаем 400 Bad Request или 401
    assert response.status_code in [400, 401]


def test_resend_otp_success(active_user):
    """Позитивный тест: Повторная отправка кода"""
    payload = {"login": active_user["login"]}

    # Первый запрос
    requests.post(RESTORE_ENDPOINT, json=payload)

    # Повторный запрос
    response = requests.post(RESEND_ENDPOINT, json=payload)

    assert response.status_code == 200


@pytest.mark.parametrize("endpoint", [CONFIRM_ENDPOINT, RESTORE_ENDPOINT, RESEND_ENDPOINT])
def test_restore_endpoints_invalid_json(endpoint):
    """Негативный тест: Отправка пустого тела на все ручки восстановления"""
    response = requests.post(endpoint, json={})
    assert response.status_code == 400