# PWM_to_SBUS_GUI
## Программа для проверки и отладки SBUS
* Связанные проекты: https://github.com/Penguin096/PWM_to_SBUS_-AnalogRSSI-digitalRSSI_A7105 https://github.com/Penguin096/PWM_to_SBUS

* ![image](https://user-images.githubusercontent.com/65414023/115794962-ae26b300-a3d7-11eb-9574-31e879491fdd.png)


Для отладки вышеуказанных проектов, раскомментировать строку
//Serial.write(millis()-sbusTime);  //Отладка
,а в программе нажать кнопку Debug. Будет отображаться задержка между принятыми пакетами SBUS.

P.S. Внимание, наблюдается запаздывание работы программы из-за высокой скорости поступлния пакетов.
