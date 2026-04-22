import time
import pytest
import requests


BASE_URL = "http://localhost:5022"


@pytest.fixture(scope="session", autouse=True)
def wait_for_api():
    """
    Эта функция создана, чтобы тесты не падали пока запускаются докеры.
    В теории можно запускать docker-compose и сразу тесты и это не упадет
    """
    timeout = 120  # 2 минуты на запуск докеров
    start_time = time.time()
    url = f"{BASE_URL}/api/Recipes"

    print("\n[Ждем запуск API в Docker...]")
    while time.time() - start_time < timeout:
        try:
            response = requests.get(url)
            # Если статус 200, 404, 401 и т.д. — API живо и отвечает.
            if response.status_code < 500:
                print("API успешно запущено!")
                return
        except requests.ConnectionError:
            # Контейнер еще не поднял порт
            pass

        time.sleep(2)  # Ждем 2 секунды перед следующим пингом

    pytest.fail(f"API не поднимается по адресу {BASE_URL} за {timeout} секунд")