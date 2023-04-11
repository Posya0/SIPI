#Область ОбработчикиЭлементовТабличнойЧастиТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	РассчитатьСумму();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	РассчитатьСумму();
КонецПроцедуры    

&НаКлиенте
Процедура ТоварыНоменклатураПриИзменении(Элемент)
	ТекДанные = Элементы.Товары.ТекущиеДанные;
	ТекДанные.Цена = ПолучитьЦену(ТекДанные.Номенклатура, объект.Дата)  * (1 + Наценка/100);  
	РассчитатьСумму();
КонецПроцедуры   

#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСумму()
	ТекДанные = Элементы.Товары.ТекущиеДанные;
	ТекДанные.Сумма = ТекДанные.Цена * ТекДанные.Количество;
КонецПроцедуры  

&НаСервереБезКонтекста
Функция ПолучитьЦену(Товар, Дата)
	Возврат РегистрыСведений.Цены.ПолучитьПоследнее(Дата, Новый Структура("Товар",Товар )).цена 
КонецФункции

&НаСервереБезКонтекста
Функция КонтрагентПриИзмененииНаСервере(Контрагент)
	Возврат Контрагент.ЧерныйСписок
КонецФункции

&НаКлиенте
Процедура КонтрагентПриИзменении(Элемент)
	Если КонтрагентПриИзмененииНаСервере(Объект.Контрагент) тогда
		Сообщить(СтрШаблон("Поставщик %1 находится в черном списке!", Объект.Контрагент));
		Объект.Контрагент = Неопределено;   
	Иначе 
		объект.ИНН = ПолучитьИНН(Объект.Контрагент);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура НаценкаПриИзменении(Элемент)
	Если Наценка <> 0  тогда
		для каждого Строка из объект.Товары цикл   
			Строка.Цена =  Строка.Цена* (1 + Наценка/100);
			Строка.Сумма = Строка.Цена * Строка.Количество ;  
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры 

#КонецОбласти    

&НаСервереБезКонтекста
Функция ПолучитьИНН(Контрагент)
	Возврат Контрагент.ИНН
КонецФункции 




