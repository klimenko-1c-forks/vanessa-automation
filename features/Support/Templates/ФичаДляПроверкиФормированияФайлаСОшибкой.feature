﻿# language: ru

@IgnoreOnCIMainBuild

Функциональность: ФичаДляПроверкиФормированияФайлаСОшибкой
 

 
Сценарий: Для ФичаДляПроверкиФормированияФайлаСОшибкой
	Дано Я закрыл все окна клиентского приложения
	И    я закрываю сеанс TESTCLIENT
	
	
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	
	И В командном интерфейсе я выбираю 'Основная' 'Выполнить произвольное выражение'
	Тогда открылось окно 'Выполнить произвольное выражение'
	И в поле 'Текст выражения' я ввожу текст '1/0'
	И я нажимаю на кнопку 'Выполнить выражение'
	И Я закрываю окно 'Выполнить произвольное выражение'

