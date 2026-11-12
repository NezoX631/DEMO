# -*- coding: utf-8 -*-
"""
Модуль для надежного определения путей к ресурсам и внешней конфигурации
в режимах исходного кода и упакованного приложения PyInstaller (sys.frozen).
"""
import sys
import os
from pathlib import Path

def is_frozen() -> bool:
    """Проверка, запущено ли приложение в виде скомпилированного пакета PyInstaller."""
    return getattr(sys, "frozen", False)

def get_base_dir() -> Path:
    """Базовый каталог приложения: каталог исполняемого файла в frozen-режиме, или корень проекта."""
    if is_frozen():
        return Path(sys.executable).resolve().parent
    return Path(__file__).resolve().parent.parent

def get_bundle_dir() -> Path:
    """Каталог упакованных ресурсов PyInstaller (sys._MEIPASS или каталог сборки)."""
    if is_frozen():
        meipass = getattr(sys, "_MEIPASS", None)
        if meipass:
            return Path(meipass).resolve()
        return Path(sys.executable).resolve().parent
    return Path(__file__).resolve().parent.parent

def get_config_path() -> str:
    """Путь к внешнему файлу config.ini.
    В скомпилированном режиме ищется рядом с исполняемым файлом (ShoeStore.exe).
    В режиме разработки - в корне проекта или в текущем рабочем каталоге.
    """
    if is_frozen():
        primary = Path(sys.executable).resolve().parent / "config.ini"
        if primary.exists():
            return str(primary)
        cwd_cand = Path.cwd() / "config.ini"
        if cwd_cand.exists():
            return str(cwd_cand)
        return str(primary)
    
    root_cand = Path(__file__).resolve().parent.parent / "config.ini"
    if root_cand.exists():
        return str(root_cand)
    cwd_cand = Path.cwd() / "config.ini"
    if cwd_cand.exists():
        return str(cwd_cand)
    return str(root_cand)

def get_resource_path(relative_path: str) -> str:
    """Находит абсолютный путь к упакованному или локальному файлу ресурсов.
    Проверяет папки sys._MEIPASS, base_dir, base_dir/_internal, base_dir/resources, base_dir/import.
    """
    rel = Path(relative_path)
    if rel.is_absolute() and rel.exists():
        return str(rel)

    candidates = []
    bundle = get_bundle_dir()
    base = get_base_dir()

    candidates.append(bundle / rel)
    candidates.append(bundle / "_internal" / rel)
    candidates.append(bundle / "resources" / rel)
    candidates.append(bundle / "import" / rel)

    candidates.append(base / rel)
    candidates.append(base / "_internal" / rel)
    candidates.append(base / "resources" / rel)
    candidates.append(base / "import" / rel)

    candidates.append(Path.cwd() / rel)

    for cand in candidates:
        if cand.exists():
            return str(cand.resolve())

    return str((bundle / rel).resolve())
