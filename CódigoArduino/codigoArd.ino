#include "DHT.h"
#define dht_type DHT11
//define qual o tipo de sensor DHTxx que se está utilizando

/*Configurações iniciais sobre os sensores DHT11, LM35, LDR5 e TCRT5000*/

//int dht_pin = A0;
//DHT dht_1 = DHT(dht_pin, dht_type);
//pode-se configurar diversos sensores DHTxx

//int lm35_pin = A2, leitura_lm35 = 0;
//float temperatura;

int ldr_pin = A0, leitura_ldr = A0;

//int switch_pin = 7;

void setup() {
  Serial.begin(9600);
 // dht_1.begin();
//  pinMode(switch_pin, INPUT);
}

void loop() {
  /*Bloco do DHT11*/
  /*float umidade = dht_1.readHumidity();
  float temperatura = dht_1.readTemperature();
  if (isnan(temperatura) or isnan(umidade)) {
    Serial.println("Erro ao ler o DHT");
  } else {
    Serial.print(umidade);
    Serial.print(";");
    Serial.print(temperatura);
    Serial.print(";");
  }

  /*Bloco do LM35*/
  /*leitura_lm35 = analogRead(lm35_pin);
  temperatura = leitura_lm35 * (5.0 / 1023) * 100;
  Serial.print(temperatura);
  Serial.print(";");

  /*Bloco do LDR5*/
  leitura_ldr = analogRead(ldr_pin);

  int luminosidade = leitura_ldr * 0.48 + 182;

  int luminosidade10Menos = luminosidade * 0.9;
  int luminosidade10Mais = luminosidade * 1.1;
  int luminosidade20Menos = luminosidade * 0.8;
  int luminosidade20Mais = luminosidade * 1.2;

  Serial.print(luminosidade);
  Serial.print("; ");
  Serial.print(luminosidade10Menos);
  Serial.print("; ");
  Serial.print(luminosidade10Mais);
  Serial.print("; ");
  Serial.print(luminosidade20Menos);
  Serial.print("; ");
  Serial.print(luminosidade20Mais);
  Serial.println("");

  /*Bloco do TCRT5000*/
//  if (digitalRead(switch_pin) == LOW) {
  //  Serial.println(1);
  //} else {
   // Serial.println(0);
  //}
  delay(1000);
}