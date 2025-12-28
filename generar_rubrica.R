
library(dplyr)
library(tidyr)
library(knitr)
library(kableExtra)
library(rmarkdown)

# ===============================
# DATOS DE ENTRADA (MODIFICA AQUÍ)
# ===============================

notas <- tibble(
  criterio = c(
    "Diseño",
    "Programación",
    "Esfuerzo o implicación",
    "Documentación / Claridad",
    "Funcionalidad"
  ),
  puntuacion = c(4.5, 7.8, 9.2, 6.0, 8.5)
)

# ===============================
# FUNCIÓN PARA MARCAR CASILLAS
# ===============================

marcar_casilla <- function(puntos, min, max) {
  if (puntos >= min && puntos <= max) {
    paste0("\\textbf{", puntos, "}")
  } else {
    ""
  }
}

# ===============================
# CONSTRUIR TABLA DE RÚBRICA
# ===============================

rubrica <- notas %>%
  rowwise() %>%
  mutate(
    Deficiente = marcar_casilla(puntuacion, 0, 4),
    Insuficiente = marcar_casilla(puntuacion, 4, 5),
    Aceptable = marcar_casilla(puntuacion, 5, 7),
    Bueno = marcar_casilla(puntuacion, 7, 9),
    Excelente = marcar_casilla(puntuacion, 9, 10)
  ) %>%
  ungroup() %>%
  select(-puntuacion)

saveRDS(rubrica, "rubrica.rds")
saveRDS(sum(notas$puntuacion), "total.rds")

render(
  input = "rubrica.Rmd",
  output_file = "rubrica_evaluada.pdf",
  quiet = TRUE
)
