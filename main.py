"""
Главная точка входа в десктопное приложение 'Магазин обуви' (ShoeShop)
Демонстрационный экзамен по специальности 09.02.07 Информационные системы и программирование
Торговая компания 'Чудо Обувь'
"""
import sys
import os

# Добавление путей для модулей приложения
current_dir = os.path.dirname(os.path.abspath(__file__))
app_dir = os.path.join(current_dir, 'app')
if app_dir not in sys.path:
    sys.path.insert(0, app_dir)

from catalog import main

if __name__ == "__main__":
    main()
