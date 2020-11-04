-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-10-2020 a las 21:56:08
-- Versión del servidor: 10.1.34-MariaDB
-- Versión de PHP: 7.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `yaauttouringdb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `idCliente` mediumint(9) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apellidoPaterno` varchar(40) NOT NULL,
  `apellidoMaterno` varchar(40) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correoElectronico` varchar(35) NOT NULL,
  `estado` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE `eventos` (
  `idEvento` mediumint(9) NOT NULL,
  `nombreEvento` varchar(40) NOT NULL,
  `fechaInicio` time NOT NULL,
  `horaInicio` time NOT NULL,
  `fechaFinal` date NOT NULL,
  `horaFinal` date NOT NULL,
  `lugar` varchar(50) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `banner` varchar(40) NOT NULL,
  `status` varchar(40) NOT NULL,
  `fechaUltimoPago` date NOT NULL,
  `idTransporte` mediumint(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experiencias`
--

CREATE TABLE `experiencias` (
  `idExperiencia` mediumint(9) NOT NULL,
  `idEvento` mediumint(9) NOT NULL,
  `idFase` mediumint(9) NOT NULL,
  `idCliente` mediumint(9) NOT NULL,
  `descuento` float NOT NULL,
  `pagado` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fases`
--

CREATE TABLE `fases` (
  `idFase` mediumint(9) NOT NULL,
  `numeroFase` char(1) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `precio` float NOT NULL,
  `fechaFinal` date NOT NULL,
  `idEvento` mediumint(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `idPago` mediumint(9) NOT NULL,
  `monto` float NOT NULL,
  `método` varchar(10) NOT NULL,
  `fechaPago` date NOT NULL,
  `idExperiencia` mediumint(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transportes`
--

CREATE TABLE `transportes` (
  `idTransporte` mediumint(9) NOT NULL,
  `nombreTranporte` varchar(40) NOT NULL,
  `tipo` varchar(10) NOT NULL,
  `capacidad` tinyint(4) NOT NULL,
  `nombreEmpresa` varchar(40) NOT NULL,
  `inicioPrestamo` date NOT NULL,
  `finPrestamo` date NOT NULL,
  `costo` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idCliente`);

--
-- Indices de la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`idEvento`),
  ADD KEY `idTransporte` (`idTransporte`);

--
-- Indices de la tabla `experiencias`
--
ALTER TABLE `experiencias`
  ADD PRIMARY KEY (`idExperiencia`),
  ADD KEY `idEvento` (`idEvento`),
  ADD KEY `idFase` (`idFase`),
  ADD KEY `idCliente` (`idCliente`);

--
-- Indices de la tabla `fases`
--
ALTER TABLE `fases`
  ADD PRIMARY KEY (`idFase`),
  ADD KEY `idEvento` (`idEvento`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`idPago`),
  ADD KEY `idExperiencia` (`idExperiencia`);

--
-- Indices de la tabla `transportes`
--
ALTER TABLE `transportes`
  ADD PRIMARY KEY (`idTransporte`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `idEvento` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `experiencias`
--
ALTER TABLE `experiencias`
  MODIFY `idExperiencia` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `fases`
--
ALTER TABLE `fases`
  MODIFY `idFase` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `idPago` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `transportes`
--
ALTER TABLE `transportes`
  MODIFY `idTransporte` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `eventos_ibfk_1` FOREIGN KEY (`idTransporte`) REFERENCES `transportes` (`idTransporte`);

--
-- Filtros para la tabla `experiencias`
--
ALTER TABLE `experiencias`
  ADD CONSTRAINT `experiencias_ibfk_1` FOREIGN KEY (`idEvento`) REFERENCES `eventos` (`idEvento`),
  ADD CONSTRAINT `experiencias_ibfk_2` FOREIGN KEY (`idFase`) REFERENCES `fases` (`idFase`),
  ADD CONSTRAINT `experiencias_ibfk_3` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`);

--
-- Filtros para la tabla `fases`
--
ALTER TABLE `fases`
  ADD CONSTRAINT `fases_ibfk_1` FOREIGN KEY (`idEvento`) REFERENCES `eventos` (`idEvento`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`idExperiencia`) REFERENCES `experiencias` (`idExperiencia`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
