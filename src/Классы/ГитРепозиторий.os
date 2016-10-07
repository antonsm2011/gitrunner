#Использовать asserts
#Использовать logos

Перем Лог;

Перем ВыводКоманды;
Перем ИмяФайлаИнформации;
Перем РабочийКаталог;
Перем ПутьКГит;

Перем ЭтоWindows;

/////////////////////////////////////////////////////////////////////////
// Программный интерфейс

/////////////////////////////////////////////////////////////////////////
// Процедуры-обертки над git

Процедура Инициализировать() Экспорт
    
    ПараметрыЗапуска = Новый Массив;
    ПараметрыЗапуска.Добавить("init");
    
    ВыполнитьКоманду(ПараметрыЗапуска);
    
КонецПроцедуры

Функция Статус() Экспорт
    
    ПараметрыЗапуска = Новый Массив;
    ПараметрыЗапуска.Добавить("status");
    
    ВыполнитьКоманду(ПараметрыЗапуска);

    Возврат ПолучитьВыводКоманды();

КонецФункции

Процедура ДобавитьФайлВИндекс(Знач ПутьКДобавляемомуФайлу) Экспорт

    ПараметрыЗапуска = Новый Массив;
    ПараметрыЗапуска.Добавить("add");
    ПараметрыЗапуска.Добавить(ПутьКДобавляемомуФайлу);
    
    ВыполнитьКоманду(ПараметрыЗапуска);

КонецПроцедуры

Процедура Закоммитить(Знач ТекстСообщения, Знач ПроиндексироватьОтслеживаемыеФайлы = Ложь) Экспорт

    ПараметрыЗапуска = Новый Массив;
	ПараметрыЗапуска.Добавить("commit");

	Если ПроиндексироватьОтслеживаемыеФайлы Тогда
        ПараметрыЗапуска.Добавить("-a");
    КонецЕсли;

    ПараметрыЗапуска.Добавить("-m");
    ПараметрыЗапуска.Добавить(ОбернутьВКавычки(ТекстСообщения));
    
    ВыполнитьКоманду(ПараметрыЗапуска);

КонецПроцедуры

Процедура ВывестиИсторию() Экспорт

    ПараметрыЗапуска = Новый Массив;
    ПараметрыЗапуска.Добавить("log");

	ВыполнитьКоманду(ПараметрыЗапуска);

КонецПроцедуры

Процедура Получить(Знач ИмяРепозитория = "", Знач ИмяВетки = "") Экспорт

    ПараметрыЗапуска = Новый Массив;
    ПараметрыЗапуска.Добавить("pull");

    Если ЗначениеЗаполнено(ИмяРепозитория) Тогда
        ПараметрыЗапуска.Добавить(ИмяРепозитория);
    КонецЕсли;

    Если ЗначениеЗаполнено(ИмяВетки) Тогда
        ПараметрыЗапуска.Добавить(ИмяВетки);
    КонецЕсли;
    
    ВыполнитьКоманду(ПараметрыЗапуска);

КонецПроцедуры

Процедура Отправить(Знач ИмяРепозитория = "", Знач ИмяВетки = "") Экспорт

    ПараметрыЗапуска = Новый Массив;
    ПараметрыЗапуска.Добавить("push");

    Если ЗначениеЗаполнено(ИмяРепозитория) Тогда
        ПараметрыЗапуска.Добавить(ИмяРепозитория);
    КонецЕсли;

    Если ЗначениеЗаполнено(ИмяВетки) Тогда
        ПараметрыЗапуска.Добавить(ИмяВетки);
    КонецЕсли;
    
    ВыполнитьКоманду(ПараметрыЗапуска);
    
КонецПроцедуры

// TODO: Потенциально bad-design. По-хорошему это не относится к объекту ГитРепозиторий, это что-то вроде ГитМенеджер.
//
Процедура КлонироватьРепозиторий(Знач ПутьУдаленномуРепозиторию, Знач КаталогКлонирования = "") Экспорт
    
    ПараметрыЗапуска = Новый Массив;
    ПараметрыЗапуска.Добавить("clone");
    ПараметрыЗапуска.Добавить(ПутьУдаленномуРепозиторию);
    
    Если ЗначениеЗаполнено(КаталогКлонирования) Тогда
        ПараметрыЗапуска.Добавить(ОбернутьВКавычки(КаталогКлонирования));
    КонецЕсли;
    
    ВыполнитьКоманду(ПараметрыЗапуска);
    
КонецПроцедуры

// @unstable
//
Процедура ПерейтиВВетку(Знач ИмяВетки, Знач СоздатьНовую = Ложь) Экспорт
    
    ПараметрыЗапуска = Новый Массив;
    ПараметрыЗапуска.Добавить("checkout");
    
    Если СоздатьНовую Тогда
        ПараметрыЗапуска.Добавить("-b");
    КонецЕсли;
    
    ПараметрыЗапуска.Добавить(ИмяВетки);
    
    ВыполнитьКоманду(ПараметрыЗапуска);
    
КонецПроцедуры

Процедура ДобавитьВнешнийРепозиторий(Знач ИмяРепозитория, Знач ПутьКРепозиторию) Экспорт

    ПараметрыЗапуска = Новый Массив;
    ПараметрыЗапуска.Добавить("remote");
    ПараметрыЗапуска.Добавить("add");
    
    ПараметрыЗапуска.Добавить(ИмяРепозитория);
    ПараметрыЗапуска.Добавить(ПутьКРепозиторию);
    
    ВыполнитьКоманду(ПараметрыЗапуска);

КонецПроцедуры

// @unstable
//
Процедура ОбновитьПодмодуль(Знач Инициализировать = Ложь, Знач Рекурсивно = Ложь) Экспорт

	ПараметрыЗапуска = Новый Массив;
    ПараметрыЗапуска.Добавить("submodule");
    ПараметрыЗапуска.Добавить("update");
    
    Если Инициализировать Тогда
        ПараметрыЗапуска.Добавить("--init");
    КонецЕсли;
    
	Если Рекурсивно Тогда
        ПараметрыЗапуска.Добавить("--recursive");
    КонецЕсли;
    
    ВыполнитьКоманду(ПараметрыЗапуска);

КонецПроцедуры

Процедура ВыполнитьКоманду(Знач Параметры) Экспорт
    
    //NOTICE: https://github.com/oscript-library/v8runner 
    //Apache 2.0 
    
    ПроверитьВозможностьВыполненияКоманды();
        
    КодВозврата = ЗапуститьИПодождать(Параметры);
    Если КодВозврата <> 0 Тогда
        Лог.Ошибка("Получен ненулевой код возврата "+КодВозврата+". Выполнение скрипта остановлено!");
        ВызватьИсключение ПолучитьВыводКоманды();
    Иначе
        Лог.Отладка("Код возврата равен 0");
    КонецЕсли;
    
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////
// Работа со свойствами класса

Функция ПолучитьРабочийКаталог() Экспорт
    Возврат РабочийКаталог;
КонецФункции

Процедура УстановитьРабочийКаталог(Знач ПутьРабочийКаталог) Экспорт
    
    Файл_РабочийКаталог = Новый Файл(ПутьРабочийКаталог);
    Ожидаем.Что(Файл_РабочийКаталог.Существует(), СтрШаблон("Рабочий каталог <%1> не существует.", ПутьРабочийКаталог)).ЭтоИстина();
    
    РабочийКаталог = Файл_РабочийКаталог.ПолноеИмя;
    
КонецПроцедуры

Функция ПолучитьПутьКГит() Экспорт
    Возврат ПутьКГит;
КонецФункции

Процедура УстановитьПутьКГит(Знач Путь) Экспорт
    ПутьКГит = Путь;
КонецПроцедуры

Функция ПолучитьВыводКоманды() Экспорт
    Возврат ВыводКоманды;
КонецФункции

Процедура УстановитьВывод(Знач Сообщение)
    ВыводКоманды = Сообщение;
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////
// Служебные процедуры и функции

Процедура ПроверитьВозможностьВыполненияКоманды()
    
    Ожидаем.Что(ПолучитьРабочийКаталог(), "Рабочий каталог не установлен.").Заполнено();
    
    Лог.Отладка("РабочийКаталог: " + ПолучитьРабочийКаталог());
    
КонецПроцедуры

Функция ЗапуститьИПодождать(Знач Параметры)
    
    //NOTICE: https://github.com/oscript-library/v8runner 
    //Apache 2.0
    // ЗапуститьПриложение переделано на СоздатьПроцесс и чтение данных вывода 
    
    СтрокаЗапуска = "";
    СтрокаДляЛога = "";
    Для Каждого Параметр Из Параметры Цикл
        
        СтрокаЗапуска = СтрокаЗапуска + " " + Параметр;
        
        Если Лев(Параметр,2) <> "/P" и Лев(Параметр,25) <> "/ConfigurationRepositoryP" Тогда
            СтрокаДляЛога = СтрокаДляЛога + " " + Параметр;
        КонецЕсли;
        
    КонецЦикла;
        
    Приложение = ОбернутьВКавычки(ПолучитьПутьКГит());
    Лог.Отладка(Приложение + СтрокаДляЛога);
    
    Если ЭтоWindows = Ложь Тогда 
        СтрокаЗапуска = "sh -c '" + Приложение + СтрокаЗапуска + "'";
    Иначе
        СтрокаЗапуска = Приложение + СтрокаЗапуска;
    КонецЕсли;
    
	ЗаписьXML = Новый ЗаписьXML();
	ЗаписьXML.УстановитьСтроку();
	
    Процесс = СоздатьПроцесс(СтрокаЗапуска, РабочийКаталог, Истина, , КодировкаТекста.UTF8);
	Процесс.Запустить();
	
	Процесс.ОжидатьЗавершения();

	Пока НЕ Процесс.Завершен ИЛИ Процесс.ПотокВывода.ЕстьДанные Цикл
		СтрокаВывода = Процесс.ПотокВывода.ПрочитатьСтроку();
        ЗаписьXML.ЗаписатьБезОбработки(СтрокаВывода);
	КонецЦикла;
	
	Если Процесс.КодВозврата <> 0 Тогда
		Лог.Ошибка("Код возврата: " + Процесс.КодВозврата);
		ТекстВывода = Процесс.ПотокОшибок.Прочитать();
        УстановитьВывод(ТекстВывода);
		ВызватьИсключение ТекстВывода;
	КонецЕсли;

	РезультатРаботыПроцесса = ЗаписьXML.Закрыть();
	УстановитьВывод(РезультатРаботыПроцесса);

    Возврат Процесс.КодВозврата;
    
КонецФункции

Функция ОбернутьВКавычки(Знач Строка)
    
    //NOTICE: https://github.com/oscript-library/v8runner 
    //Apache 2.0 
    
    Если Лев(Строка, 1) = """" и Прав(Строка, 1) = """" Тогда
        Возврат Строка;
    Иначе
        Возврат """" + Строка + """";
    КонецЕсли;
    
КонецФункции

Процедура Инициализация()
    
    Лог = Логирование.ПолучитьЛог("oscript.lib.gitrunner");
    
    СистемнаяИнформация = Новый СистемнаяИнформация;
    ЭтоWindows = Найти(НРег(СистемнаяИнформация.ВерсияОС), "windows") > 0;
    
    УстановитьПутьКГит("git");
    
КонецПроцедуры

Инициализация();
