# SBUS_GUI
## Программа для проверки и отладки SBUS (Processing)
* Связанные проекты: https://github.com/Penguin096/PWM_to_SBUS_-AnalogRSSI-digitalRSSI_A7105

* ![image](https://user-images.githubusercontent.com/65414023/115803704-1d0d0780-a3ea-11eb-9030-4e3dfaae206b.png)


Для отладки вышеуказанных проектов, раскомментировать строку
//Serial.write(millis()-sbusTime);  //Отладка
,а в программе нажать кнопку Debug. Будет отображаться задержка между принятыми пакетами SBUS.
