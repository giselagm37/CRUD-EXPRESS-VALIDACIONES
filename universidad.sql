-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-08-2024 a las 01:01:01
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `universidad`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(64) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `profesor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id`, `nombre`, `descripcion`, `profesor_id`) VALUES
(7, 'Programacion avanzada', 'Python', 4),
(8, 'Programacion web', 'html, javascript', 5),
(9, 'Programacion avanzada', 'Python', 4),
(10, 'Programacion web', 'html,css y javascript', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos_estudiantes`
--

CREATE TABLE `cursos_estudiantes` (
  `curso_id` int(11) NOT NULL,
  `estudiante_id` int(11) NOT NULL,
  `nota` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cursos_estudiantes`
--

INSERT INTO `cursos_estudiantes` (`curso_id`, `estudiante_id`, `nota`) VALUES
(7, 1, 9),
(9, 4, 8),
(9, 7, NULL),
(10, 4, NULL),
(10, 6, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

CREATE TABLE `estudiantes` (
  `id` int(11) NOT NULL,
  `dni` varchar(15) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `apellido` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiantes`
--

INSERT INTO `estudiantes` (`id`, `dni`, `nombre`, `apellido`, `email`) VALUES
(1, '25879865', 'Jose', 'Martinez', 'gjose@gmail.com'),
(2, '38876565', 'Calipto', 'Martinez', 'caliptojose@gmail.com'),
(4, '36632544', 'Pablo', 'Cabral', 'pablocabral@hotmial'),
(5, '3152145', 'Marcela', 'Ramirez', 'Ramirez@gmial'),
(6, '36785421', 'Claudia', 'Maldonado', 'claudia@gmail.com'),
(7, '36785421', 'sofia', 'Maldonado', 'claudia@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesores`
--

CREATE TABLE `profesores` (
  `id` int(11) NOT NULL,
  `dni` varchar(15) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `apellido` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `profesion` varchar(30) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesores`
--

INSERT INTO `profesores` (`id`, `dni`, `nombre`, `apellido`, `email`, `profesion`, `telefono`) VALUES
(4, '3136987', 'Catalina', 'Saucedo', 'saucedo@hotmial', 'docente', '11225588'),
(5, '25364125', 'Romina', 'Suarez', 'romina@yahoo.com', 'docente', '1165987458'),
(6, '3136987', 'Catalina', 'Saucedo', 'saucedo@hotmial', 'docente', '11225588'),
(7, '25364125', 'Soledad', 'Suarez', 'romina@yahoo.com', 'docente', '1165987458'),
(8, '25364125', 'Daniel', 'Bednarek', 'Daniel@yahoo.com', 'docente', '1165987458'),
(9, '25364125', 'Gustavo', 'saez', 'Gustavo@yahoo.com', 'docente', '1165987458');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profesor_id` (`profesor_id`);

--
-- Indices de la tabla `cursos_estudiantes`
--
ALTER TABLE `cursos_estudiantes`
  ADD PRIMARY KEY (`curso_id`,`estudiante_id`),
  ADD KEY `estudiante_id` (`estudiante_id`);

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `profesores`
--
ALTER TABLE `profesores`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `profesores`
--
ALTER TABLE `profesores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `cursos_ibfk_1` FOREIGN KEY (`profesor_id`) REFERENCES `profesores` (`id`);

--
-- Filtros para la tabla `cursos_estudiantes`
--
ALTER TABLE `cursos_estudiantes`
  ADD CONSTRAINT `cursos_estudiantes_ibfk_1` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`),
  ADD CONSTRAINT `cursos_estudiantes_ibfk_2` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
