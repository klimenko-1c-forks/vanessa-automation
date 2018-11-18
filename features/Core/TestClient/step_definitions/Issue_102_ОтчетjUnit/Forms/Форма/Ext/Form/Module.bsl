﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВПолеКаталогОтчетаJUnitЯУказываюПутьКОтносительномуКаталогу(Парам01)","ВПолеКаталогОтчетаJUnitЯУказываюПутьКОтносительномуКаталогу","И     в поле каталог отчета jUnit я указываю путь к относительному каталогу ""tools\jUnit""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВКаталогеJUnitПоявилсяФайлXml(Парам01)","ВКаталогеJUnitПоявилсяФайлXml","И в каталоге jUnit появился 1 файл xml");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И     в поле каталог отчета jUnit я указываю путь к относительному каталогу "tools\jUnit"
//@ВПолеКаталогОтчетаJUnitЯУказываюПутьКОтносительномуКаталогу(Парам01)
Процедура ВПолеКаталогОтчетаJUnitЯУказываюПутьКОтносительномуКаталогу(ЧастьПути) Экспорт
	Каталог = Ванесса.Объект.КаталогИнструментов + "\" + ЧастьПути;
	Контекст.Вставить("КаталогjUnit",Каталог);
	
	Если НЕ Ванесса.ФайлСуществуетКомандаСистемы(Каталог) Тогда
		Ванесса.СоздатьКаталогКомандаСистемы(Каталог);
	Иначе
		Ванесса.УдалитьКаталогКомандаСистемы(Каталог);
		Ванесса.Sleep(1);
		Ванесса.СоздатьКаталогКомандаСистемы(Каталог);
	КонецЕсли;	 
	
	Поле = Ванесса.НайтиРеквизитОткрытойФормыПоЗаголовку("КаталогOutputjUnit",Истина);
	Поле.ВвестиТекст(Каталог);

	//Ванесса.Шаг("И В открытой форме в поле с именем ""КаталогOutputjUnit"" я ввожу текст """ + Каталог + """");
КонецПроцедуры

&НаКлиенте
//И в каталоге jUnit появился 1 файл xml
//@ВКаталогеJUnitПоявилсяФайлXml(Парам01)
Процедура ВКаталогеJUnitПоявилсяФайлXml(ДолжноБытьФайлов) Экспорт
	ЛогФайл = ПолучитьИмяВременногоФайла("txt");
	Команда = "DIR " + Контекст.КаталогjUnit + " > """ + ЛогФайл + """";
	
	КомандаСистемы(Команда);
	
	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ЛогФайл,"Windows-1251");
	
	КолФайлов = 0;
	
	БылФайлjUnit = Ложь;
	Пока Истина Цикл
		Стр = Текст.ПрочитатьСтроку();
		Если Стр = Неопределено Тогда
			Прервать;
		КонецЕсли;
		
		Если Найти(Стр,".xml") > 0 Тогда
			БылФайлjUnit = Истина;
			КолФайлов = КолФайлов + 1;
		КонецЕсли;	 
	КонецЦикла;	
	
	Текст.Закрыть();
	
	Если Не БылФайлjUnit Тогда
		ТекстСообщения = "В каталоге %1 не найдено ни одного файла xml.";
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Контекст.КаталогjUnit);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	
	
	Если КолФайлов <> ДолжноБытьФайлов Тогда
		ТекстСообщения = "Найдено %1, а должно быть %2 файлов";
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",КолФайлов);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",ДолжноБытьФайлов);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
КонецПроцедуры

//окончание текста модуля
