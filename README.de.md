# Korry Taster

Dies ist eine Bibliothek von Pereperien für den Flugsimulator


## Dimensions

The dimensions were copied from the Korry datasheet and converted to metric units.

## Pins

Every button has a connection with 4 pins: GND, Signal, LED1, and LED2.

## Lenses

The buttons have backlit lenses, on which text becomes visible based on an LED.



# Actuators

- Korry Button 389 -> (button, on_off_led, fault_led)

- Small Korry Button -> (button, on_off_led, illumination?)

- Push and Pull Knob-> (switch, impulse_a, impulse_b)

- Knob -> (reserved -> impulse_a, impulse_b)

- Stage-knob -> (tbd) -> Mobi flight implementation?

- bistable_switch -> (position_a, position_b, nc)

- tristable_switch -> (postiton_a, postition_b, position_c)

- 