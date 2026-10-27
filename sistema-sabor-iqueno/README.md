# Sistema de Gestion para Restaurante "El Sabor Iqueño"

Proyecto de Arquitectura de Software desarrollado bajo estandares académicos de la Universidad Tecnológica del Perú (UTP).

## Descripción General del Proyecto
El software automatiza la gestión operativa integral del restaurante "El Sabor Iqueño", optimizando los flujos de atención en salón, control de comandas en cocina mediante KDS en tiempo real, facturación electrónica con validación de RUC y control automatizado de inventarios y kardex.

## Arquitectura de Software Aplicada
El sistema implementa una **Arquitectura Multicapa (Layered Architecture)** combinada con el patrón **MVC (Model-View-Controller)** y principios **SOLID**, garantizando la desacoplación de componentes:

1. **Capa de Presentación (Frontend):**
   - Desarrollada con HTML5, CSS3 moderno (Flexbox/Grid) y JavaScript Vanilla con arquitectura modular por vistas de rol (Administrador, Mesero, Cocina y Cajero).
   - Ubicación: Carpeta `frontend/index.html`.

2. **Capa de Lógica de Negocio y Servicios (Backend):**
   - Desarrollada bajo el ecosistema **Java 17** utilizando **Spring Boot** y gestión de dependencias mediante **Maven**. Expone servicios RESTful orientados a la persistencia transaccional.
   - Ubicación: Carpeta `backend/`.

3. **Capa de Persistencia y Base de Datos (Database):**
   - Diseñada en **PostgreSQL**, estructurada mediante un modelo relacional normalizado con llaves primarias, foráneas, restricciones de integridad (`CHECK`) y control de stock transaccional.
   - Ubicación: Carpeta `database/schema.sql`.

## Requisitos de Entorno y Ejecución
- **Entorno de Ejecución Java:** JDK 17 o superior.
- **Gestor de Dependencias:** Apache Maven 3.8+.
- **Motor de Base de Datos:** PostgreSQL 14 o superior.
- **Navegador Web Recomendado:** Google Chrome / Microsoft Edge (última versión).

---
*Desarrollado para fines académicos - Ingeniería de Sistemas e Informática (UTP).*