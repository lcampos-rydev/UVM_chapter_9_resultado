# UVM_chapter_9_resultado

## Ambiente de pruebas para GPIO

[Ambiente en EDA](https://www.edaplayground.com/x/7eE2)

---

## Tests

wb_wr_test: 
> Configura el GPIO en all outputs y escribe datos en el registro OUT para observarlos en la salidas del GPIO. 
wb_rw_test: 
> Configura el GPIO en all inputs y escribe datos en el las entradas del GPIO para luego leer el registro IN.

---
## Correr los tests

Para correr estos test, debe irse al **link de EDA**. Luego, el Tools and **simulators/Run options**, debe utilizar el comando **+UVM_TESTNAME=...**
para indicar que test desea probar.
