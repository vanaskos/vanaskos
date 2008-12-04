local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_WarnFrame", "enUS", true);

if L then
	L["Content"] = true;
	L["What to show in it"] = true;
	L["Design"] = true;
	L["How the content is shown"] = true;

	L["Show Target Level When Possible"] = true;
	L["Show KoS Targets"] = true;
	L["Show Hostile Targets"] = true;
	L["Show Friendly Targets"] = true;

	L["Default Background Color"] = true;
	L["Sets the default Background Color and Opacity"] = true;

	L["More Hostiles than Allied Background Color"] = true;
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = true;

	L["More Allied than Hostiles Background Color"] = true;
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = true;

	L["Grow list upwards"] = true;
	L["Grow list from the bottom of the WarnFrame"] = true;

	L["Reset Background Colors"] = true;
	L["Resets all Background Colors to default Settings"] = true;
	L["Show additional Information on Mouse Over"] = true;
	L["Toggles the display of additional Information on Mouse Over"] = true;

	L["Configuration"] = true;
	L["KoS/Enemy/Friendly Warning Window"] = true;
	L["Hide if inactive"] = true;
	L["Enabled"] = true;
	L["Locked"] = true;
	L["Reset Position"] = true;

	L["Level"] = true;
	L["No Information Available"] = true;

	L["Show class icons"] = true;
	L["Toggles the display of Class icons in the Warnframe"] = true;
	
	L["Number of lines"] = true;
	L["Sets the number of entries to display in the Warnframe"] = true;

	L["Font Size"] = true;
	L["Sets the size of the font in the Warnframe"] = true;

	L["Show border"] = true;
end
	
L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_WarnFrame", "deDE", false);
if L then
	L["Content"] = "Inhalt";
	L["What to show in it"] = "Was angezeigt wird";
	L["Design"] = "Aussehen";
	L["How the content is shown"] = "Aussehen der anzeigten Daten";

	L["Show Target Level When Possible"] = "Level von Zielen anzeigen (wenn möglich)";
	L["Show KoS Targets"] = "KoS-Ziele anzeigen";
	L["Show Hostile Targets"] = "Feindliche Ziele anzeigen";
	L["Show Friendly Targets"] = "Freundliche Ziele anzeigen";

	L["Default Background Color"] = "Standard Hintergrundfarbe";
	L["Sets the default Background Color and Opacity"] = "Setzt die standardmaessige Hintergrundfarbe und Transparenz";

	L["More Hostiles than Allied Background Color"] = "Mehr Feinde als Verbuendete Hintergrundfarbe";
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = "Setzt die Hintergrundfarbe und Transparenz wenn mehr Feinde als Verbuendete da sind";

	L["More Allied than Hostiles Background Color"] = "Mehr Verbuendete als Feinde Hintergrundfarbe";
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = "Setzt die Hintergrundfarbe und Transparenz wenn mehr Verbuendete als Feinde da sind";

	L["Grow list upwards"] = "Wachst die aufwärts Liste";
	L["Grow list from the bottom of the WarnFrame"] = "Wachst Liste der Unterseite des WarnFrame";

	L["Reset Background Colors"] = "Hintergrundfarben zuruecksetzen";
	L["Resets all Background Colors to default Settings"] = "Alle Hintergrundfarben auf ihre Standardwerte zuruecksetzen";

	L["Show additional Information on Mouse Over"] = "Zusätzliche Informationen bei Maus überfahrt";
	L["Toggles the display of additional Information on Mouse Over"] = "Zusätzliche Informationen beim herüberfahren mit der Maus anzeigen";

	L["Configuration"] = "Konfiguration";
	L["KoS/Enemy/Friendly Warning Window"] = "KoS/Feind/Freund Warn-Fenster";
	L["Hide if inactive"] = "Verstecken wenn inaktiv";
	L["Enabled"] = "Aktiviert";
	L["Locked"] = "Sperren";
	L["Reset Position"] = "Position zurücksetzen";

	L["Level"] = "Level";
	L["No Information Available"] = "No Information Available";
	L["Show class icons"] = "Zeige Klassen Symbole";
	L["Toggles the display of Class icons in the Warnframe"] = "Schaltet die Anzeige ob Klassensymbole in dem Warnframe angezeigt werden an/aus";

	L["Number of lines"] = "Zeilenzahl";
	L["Sets the number of entries to display in the Warnframe"] = "Justiert die Zahl die Einträge im Warnframe";

	L["Font Size"] = "Schrifttypgroße";
	L["Sets the size of the font in the Warnframe"] = "Stellt Schrifttygroße in dem Warnframe";

	L["Show border"] = "Zeige den Rand";
end


L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_WarnFrame", "frFR", false);
if L then
	L["Content"] = "Contenu";
	L["What to show in it"] = "Ce que vous voulez afficher";
	L["Design"] = "Apparence";
	L["How the content is shown"] = "Comment l'apparence est affich\195\169";

	L["Show Target Level When Possible"] = "Afficher le level des cibles quand c'est possible";
	L["Show KoS Targets"] = "Afficher cibles KoS";
	L["Show Hostile Targets"] = "Afficher cibles hostiles";
	L["Show Friendly Targets"] = "Afficher cibles amis";

	L["Default Background Color"] = "Couleur de fond";
	L["Sets the default Background Color and Opacity"] = "Choisir la couleur et l'opacit\195\169";

	L["More Hostiles than Allied Background Color"] = "Couleur de fond pour cible hostile";
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = "Choisir la couleur de fond pour cible hostile";

	L["More Allied than Hostiles Background Color"] = "Couleur de fond pour cible amical";
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = "Choisir la couleur de fond pour cible amical";

	L["Grow list upwards"] = "Accroissez la liste ascendante";
	L["Grow list from the bottom of the WarnFrame"] = "Accroissez la liste du bas du WarnFrame";

	L["Reset Background Colors"] = "Remettre par d\195\169faut";
	L["Resets all Background Colors to default Settings"] = "Remet par d\195\169faut la couleur de fond et l'opacit\195\169";

	L["Show additional Information on Mouse Over"] = "Montrer les informations additionnelles";
	L["Toggles the display of additional Information on Mouse Over"] = "Afficher/cacher les informations additionnelles quand vous passez la souris sur un nom";

	L["Configuration"] = "Configuration";
	L["KoS/Enemy/Friendly Warning Window"] = "Fen\195\170tre d'avertissement KoS/Ennemi/Amis";
	L["Hide if inactive"] = "Cacher si inactif";
	L["Enabled"] = "Actif";
	L["Locked"] = "Verrouill\195\169";
	L["Reset Position"] = "Remettre à zéro la position";

	L["Level"] = "Level";
	L["No Information Available"] = "No Information Available";
	L["Show class icons"] = "Montrez les graphismes de classe";
	L["Toggles the display of Class icons in the Warnframe"] = "Afficher/cacher les graphismes de classe dans WarnFrame";

	L["Number of lines"] = "Nombre de lignes";
	L["Sets the number of entries to display in the Warnframe"] = "Ajustez le nombre de lignes dans WarnFrame";

	L["Font Size"] = "Taille de fonte";
	L["Sets the size of the font in the Warnframe"] = "Ajustez la taille de fonte dans le WarnFrame";

	L["Show border"] = "Montrez le cadre";
end


L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_WarnFrame", "koKR", false);
if L then
	L["Content"] = "내용";
	L["What to show in it"] = "표시 내용";
	L["Design"] = "디자인";
	L["How the content is shown"] = "표시 방법";

	L["Show Target Level When Possible"] = "대상의 레벨 표시";
	L["Show KoS Targets"] = "KoS 대상 표시";
	L["Show Hostile Targets"] = "적대적 대상 표시";
	L["Show Friendly Targets"] = "우호적 대상 표시";

	L["Default Background Color"] = "기본 배경 색상";
	L["Sets the default Background Color and Opacity"] = "기본 배경의 색상과 투명도를 설정합니다.";

	L["More Hostiles than Allied Background Color"] = "적대적 배경 색상";
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = "적대적 배경 색상과 투명도를 설정합니다.";

	L["More Allied than Hostiles Background Color"] = "우호적 배경 색상";
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = "우호적 배경 색상과 투명도를 설정합니다.";

	L["Grow list upwards"] = "상승 명부를 성장하십시오";
	L["Grow list from the bottom of the WarnFrame"] = "경고 창의 바닥에서 명부를 위로 성장하십시오";

	L["Reset Background Colors"] = "배경 색상 초기화";
	L["Resets all Background Colors to default Settings"] = "모든 배경 색상을 기본 설정으로 초기화합니다.";

	L["Show additional Information on Mouse Over"] = "마우스 오버 시 추가 정보 표시";
	L["Toggles the display of additional Information on Mouse Over"] = "마우스 오버 시 추가 정보 표시를 전환합니다.";

	L["Configuration"] = "환경설정";
	L["KoS/Enemy/Friendly Warning Window"] = "KoS/적대적/우호적 알림창";
	L["Hide if inactive"] = "사용하지 않으면 숨김";
	L["Enabled"] = "사용";
	L["Locked"] = "고정";
	L["Reset Position"] = "위치 초기화";

	L["Level"] = "레벨";
	L["No Information Available"] = "이용가능한 정보가 없습니다.";
	L["Show class icons"] = "직업 아이콘 표시";
	L["Toggles the display of Class icons in the Warnframe"] = "경고창에 직업 아이콘을 표시합니다.";

	L["Number of lines"] = "행수";
	L["Sets the number of entries to display in the Warnframe"] = "경고 창에 있는 전시에 입장의 수를 놓는다";

	L["Font Size"] = "폰트 사이즈";
	L["Sets the size of the font in the Warnframe"] = "경고 창에 있는 글꼴의 크기를 놓는다";

	L["Show border"] = "쇼 국경";
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_WarnFrame", "esES", false);
if L then
	L["Content"] = "Contenido";
	L["What to show in it"] = "Qué mostrar en él";
	L["Design"] = "Diseño";
	L["How the content is shown"] = "Cómo se muestra el contenido";

	L["Show Target Level When Possible"] = "Mostrar el nivel del objetivo cuando sea posible";
	L["Show KoS Targets"] = "Mostrar objetivos KoS";
	L["Show Hostile Targets"] = "Mostrar objetivos hostiles";
	L["Show Friendly Targets"] = "Mostrar objetivos amistosos";

	L["Default Background Color"] = "Color de fondo por defecto";
	L["Sets the default Background Color and Opacity"] = "Establece el color de fondo y la opacidad por defecto";

	L["More Hostiles than Allied Background Color"] = "Color de fondo de más hostiles que aliados";
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = "Establece el color de fondo y la opacidad de más hostiles que aliados";

	L["More Allied than Hostiles Background Color"] = "Color de fondo de más aliados que hostiles";
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = "Establece el color de fondo y la opacidad de más aliados que hostiles";

	L["Grow list upwards"] = "Crezca la lista ascendente";
	L["Grow list from the bottom of the WarnFrame"] = "Crezca la lista de la parte inferior del WarnFrame";

	L["Reset Background Colors"] = "Reestablecer Colores de Fondo";
	L["Resets all Background Colors to default Settings"] = "Reestablece todos los colores de fondo a los ajustes por defecto";

	L["Show additional Information on Mouse Over"] = "Demuestre la información adicional encendido mouse-sobre";
	L["Toggles the display of additional Information on Mouse Over"] = "Acciona la palanca de la exhibición de la información adicional encendido mouse-sobre";

	L["Configuration"] = "Configuración";
	L["KoS/Enemy/Friendly Warning Window"] = "Ventana de Aviso de KoS/Enemigo/Amistoso";
	L["Hide if inactive"] = "Ocultar si inactivo";
	L["Enabled"] = "Activado";
	L["Locked"] = "Bloqueado";
	L["Reset Position"] = "Reestablecer Posición";

	L["Level"] = "Nivel";
	L["No Information Available"] = "Ninguna información disponible";
	L["Show class icons"] = "Demuestre los iconos de la clase";
	L["Toggles the display of Class icons in the Warnframe"] = "Acciona la palanca de la exhibición de los iconos de la clase en el Warnframe";

	L["Number of lines"] = "Número de líneas";
	L["Sets the number of entries to display in the Warnframe"] = "Fije la cantidad de líneas en el WarnFrame";

	L["Font Size"] = "Talla de fuente";
	L["Sets the size of the font in the Warnframe"] = "Ajuste la talla de fuente en el Warnframe";

	L["Show border"] = "Muestre la frontera";
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_WarnFrame", "ruRU", false);
if L then
	L["Content"] = "Содержимое";
	L["What to show in it"] = "Что показывать";
	L["Design"] = "Дизайн";
	L["How the content is shown"] = "Как показывать";

	L["Show Target Level When Possible"] = "Показывать уровень цели когда это возможно";
	L["Show KoS Targets"] = "Показывать цели KoS";
	L["Show Hostile Targets"] = "Показывать, враждебные цели";
	L["Show Friendly Targets"] = "Показывать дружественные цели";

	L["Default Background Color"] = "Цвет фона по умолчанию";
	L["Sets the default Background Color and Opacity"] = "Задает цвет фона и прозрачность";

	L["More Hostiles than Allied Background Color"] = "Цвет фона для \"Больше враждебных, чем дружественных\"";
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = "Задает цвет и прозрачность фона для \"Больше враждебных, чем дружественных\"";

	L["More Allied than Hostiles Background Color"] = "Цвет фона для \"Больше дружественных, чем враждебных\"";
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = "Задает цвет и прозрачность фона для \"Больше дружественных, чем враждебных\"";

	L["Grow list upwards"] = "Вырастите список верхний";
	L["Grow list from the bottom of the WarnFrame"] = "Вырастите список от дна WarnFrame";

	L["Reset Background Colors"] = "Сбросить Цвета Фона";
	L["Resets all Background Colors to default Settings"] = "Сбросить все цвета к значениям по умолчанию";
	L["Show additional Information on Mouse Over"] = "Показывать дополнительную информацию при наводе мышки";
	L["Toggles the display of additional Information on Mouse Over"] = "Вкл-выкл отображение дополнительной информации при наведении мышки";

	L["Configuration"] = "Настройка";
	L["KoS/Enemy/Friendly Warning Window"] = "Окно предупреждений о KoS/Враге/Друге";
	L["Hide if inactive"] = "Скрывать, если не активно";
	L["Enabled"] = "Включено";
	L["Locked"] = "Зафиксировано";
	L["Reset Position"] = "Сбросить расположение";

	L["Level"] = "Уровень";
	L["No Information Available"] = "Нет доступной информации";

	L["Show class icons"] = "Показывать иконки класса";
	L["Toggles the display of Class icons in the Warnframe"] = "Показывать или нет классовые иконки в окне предупреждений";

	L["Number of lines"] = "Количество линий";
	L["Sets the number of entries to display in the Warnframe"] = "Отрегулируйте количество линий в окне предупреждений";

	L["Font Size"] = "Размер шрифта";
	L["Sets the size of the font in the Warnframe"] = "Отрегулируйте размер шрифта в окно предупреждений";

	L["Show border"] = "Показывать границу";
end
