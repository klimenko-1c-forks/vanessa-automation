﻿# language: ru

@IgnoreOnCIMainBuild
@tree

Функциональность: Проверка работы F11 для условия тест ошибки

Сценарий: Проверка работы F11 для условия тест ошибки
		Если Это специальное условие "Парам" для ПроверкаРаботыF11ДляУсловияТестОшибки Тогда
				| 'Регистрация' |
				| 'Да'          |
				И я закрываю текущее окно
				И     в таблице "Список" я перехожу к строке:
				| 'ИмяКолонки'    |
				| "Значение" |
