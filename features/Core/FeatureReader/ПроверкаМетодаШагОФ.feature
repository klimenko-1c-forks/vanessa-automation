﻿# language: ru

@IgnoreOnUFBuilds

Функционал: Cлужебная фича для проверки метода шаг
	Как Разработчик
	Я Хочу чтобы если я вызываю метод шаг
	Чтобы снипеты фичи, которая вызывается в методе шаг корректно подгрузила контекст обработки
 

Сценарий: Сценарий с передачей таблицы

	Когда этот шаг принимает на вход таблицу:
	   | Колонка1  | Колонка2  |
	   | Значение1 | Значение2 |
	


 
Сценарий: Рабочий сценарий для проверки метода шаг ОФ

	Когда в своём методе я вызову служебный шаг с вызовом таблицы
	

