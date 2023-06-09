
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)    
	Запрос = Новый запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТоварыОстатки.Товар КАК Товар
		|ИЗ
		|	РегистрНакопления.Товары.Остатки(, ) КАК ТоварыОстатки
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК Номенклатура
		|		ПО ТоварыОстатки.Товар = Номенклатура.Ссылка
		|ГДЕ
		|	ТоварыОстатки.КоличествоОстаток > 0";
	
	РезультатЗапроса = Запрос.Выполнить();
		
	Выборка = РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Товар");

	
	Настройки = Список.УсловноеОформление.Элементы.Добавить();
	ЭлементОтбора = Настройки.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Ссылка");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеВСписке;
	ЭлементОтбора.ПравоеЗначение = Выборка;
	
	Цвет = Настройки.Оформление.Элементы.Найти("ЦветФона");
	Цвет.Использование = Истина;
	Цвет.Значение = WebЦвета.Красный;
КонецПроцедуры
