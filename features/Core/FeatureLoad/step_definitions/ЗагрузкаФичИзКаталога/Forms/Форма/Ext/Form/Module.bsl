﻿//начало текста модуля
&НаКлиенте
Перем Ванесса;

&НаКлиенте
Функция ДобавитьШагВМассивТестов(МассивТестов,Снипет,ИмяПроцедуры,ПредставлениеТеста = Неопределено,Транзакция = Неопределено,Параметр = Неопределено)
	Структура = Новый Структура;
	Структура.Вставить("Снипет",Снипет);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ПредставлениеТеста",ПредставлениеТеста);
	Структура.Вставить("Транзакция",Транзакция);
	Структура.Вставить("Параметр",Параметр);
	МассивТестов.Добавить(Структура);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСоздалСлужебныйФайлВОтноситекльномКаталогеСИменем(Парам01,Парам02)","ЯСоздалСлужебныйФайлВОтноситекльномКаталогеСИменем","И я создал служебный файл в относитекльном каталоге ""features\Core"" с именем ""TestFile""","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагрузилФичиИзОтносительногоКаталога(Парам01)","ЯЗагрузилФичиИзОтносительногоКаталога","И я загрузил фичи из относительного каталога ""features\Core\ExpectedSomething""","","");

	Возврат ВсеТесты;
КонецФункции

&НаКлиенте
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
Процедура ПередОкончаниемСценария() Экспорт
	Попытка
		Если Контекст.Свойство("ОткрытаяФормаVanessaBehavoir") Тогда
			ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
			ОткрытаяФормаVanessaBehavoir.Закрыть();
		КонецЕсли;	 
	Исключение
		
	КонецПопытки;
	
КонецПроцедуры


&НаКлиенте
Процедура ЗаписатьСлужебныйФайл()
	ЗТ = Новый ЗаписьТекста(Контекст.ИмяСлужебногоФайла,"UTF-8",,Истина); 
	ЗТ.ЗаписатьСтроку(""); 
	ЗТ.Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьУдалениеФайлов(ДополнительныеПараметры) Экспорт
	Ванесса.ПродолжитьВыполнениеШагов();
КонецПроцедуры

&НаКлиенте
//я создал служебный файл в относитекльном каталоге "features\Core" с именем "TestFile"
//@ЯСоздалСлужебныйФайлВОтноситекльномКаталогеСИменем(Парам01,Парам02)
Процедура ЯСоздалСлужебныйФайлВОтноситекльномКаталогеСИменем(ОтносительныйКаталог,ИмяФайла) Экспорт
	ИмяСлужебногоФайла = Ванесса.Объект.КаталогИнструментов + "\" + ОтносительныйКаталог + "\" + ИмяФайла;
	Контекст.Вставить("ИмяСлужебногоФайла",ИмяСлужебногоФайла);
	
	Если НЕ Ванесса.ЕстьПоддержкаАсинхронныхВызовов Тогда
		УдалитьФайлы(ИмяСлужебногоФайла);
		ЗаписатьСлужебныйФайл();
	Иначе
		ХостФорма = Ванесса;
		ХостФорма.ЗапретитьВыполнениеШагов();
		ОписаниеОповещения = Вычислить("Новый ОписаниеОповещения(""ОбработатьУдалениеФайлов"", ЭтаФорма)");
		Выполнить("НачатьУдалениеФайлов(ОписаниеОповещения,ИмяСлужебногоФайла)");
	КонецЕсли;	 
	
КонецПроцедуры

&НаКлиенте
Процедура ЯЗагрузилФичиИзОтносительногоКаталогаТаймер()
	КолСекундТаймер = КолСекундТаймер + 1;
	Если КолСекундТаймер > МаскКолСекундТаймер Тогда
		ОтключитьОбработчикОжидания("ЯЗагрузилФичиИзОтносительногоКаталогаТаймер");
		Ванесса.ПродолжитьВыполнениеШагов(Истина,"Не получилось дождаться загрузки сценариев в Vanessa Automation.");
		Возврат;
	КонецЕсли;	 
	
	Если Контекст.ОткрытаяФормаVanessaBehavoir.ФлагСценарииЗагружены Тогда
		ОтключитьОбработчикОжидания("ЯЗагрузилФичиИзОтносительногоКаталогаТаймер");
		ЯЗагрузилФичиИзОтносительногоКаталогаПродолжение();
		Возврат;
	КонецЕсли;	 
КонецПроцедуры 

&НаКлиенте
Процедура ЯЗагрузилФичиИзОтносительногоКаталогаПродолжение()
	ИмяСлужебногоФайла = Контекст.ИмяСлужебногоФайла;
	ОписаниеОповещения = Вычислить("Новый ОписаниеОповещения(""ОбработатьУдалениеФайлов"", ЭтаФорма)");
	Выполнить("НачатьУдалениеФайлов(ОписаниеОповещения,ИмяСлужебногоФайла)");
КонецПроцедуры

&НаКлиенте
//я загрузил фичи из относительного каталога "features\Core"
//@ЯЗагрузилФичиИзОтносительногоКаталога(Парам01)
Процедура ЯЗагрузилФичиИзОтносительногоКаталога(ОтносительныйКаталог) Экспорт
	Ванесса.ЗапретитьВыполнениеШагов();
	
	Контекст.ОткрытаяФормаVanessaBehavoir.Объект.КаталогФич = Ванесса.Объект.КаталогИнструментов + "\" + ОтносительныйКаталог;
	Контекст.ОткрытаяФормаVanessaBehavoir.ЗагрузитьФичи();
	МаскКолСекундТаймер = 30;
	КолСекундТаймер = 0;
	ПодключитьОбработчикОжидания("ЯЗагрузилФичиИзОтносительногоКаталогаТаймер",1,Ложь);
КонецПроцедуры


//окончание текста модуля
