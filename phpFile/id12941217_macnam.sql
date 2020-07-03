-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : ven. 03 juil. 2020 à 22:22
-- Version du serveur :  10.3.16-MariaDB
-- Version de PHP : 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `id12941217_macnam`
--

-- --------------------------------------------------------

--
-- Structure de la table `d_dossier`
--

CREATE TABLE `d_dossier` (
  `id` int(11) NOT NULL,
  `numCin` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `INAM` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `fkidEtatDossier` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `fkidRecu` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `d_dossier`
--

INSERT INTO `d_dossier` (`id`, `numCin`, `INAM`, `fkidEtatDossier`, `fkidRecu`) VALUES
(1, '2404070602', 'c22381838', '1', 'c13424'),
(2, '2404070603', 'c49490490', '12', 'c13428'),
(3, '2404070601', 'c41051809', '2', 'c13425'),
(4, '2404070600', 'c47121461', '3', 'c13426'),
(5, '2404070605', 'c22361636', '', 'c13427');

-- --------------------------------------------------------

--
-- Structure de la table `d_immat_recu`
--

CREATE TABLE `d_immat_recu` (
  `idRecu` int(11) NOT NULL,
  `ncin` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `numRecu` varchar(15) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `d_immat_recu`
--

INSERT INTO `d_immat_recu` (`idRecu`, `ncin`, `numRecu`) VALUES
(1, 'c13424', 'c13424'),
(2, 'c12979', 'c12979'),
(4, 'c13425', 'c13425'),
(5, 'c13426', 'c13426'),
(6, 'c13427', 'c13427'),
(7, 'c13428', 'c13428'),
(8, 'c13430', 'c13430'),
(9, 'c13429', 'c13429');

-- --------------------------------------------------------

--
-- Structure de la table `d_remb_bord_lines`
--

CREATE TABLE `d_remb_bord_lines` (
  `numSinistre` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `mntRembourse` varchar(15) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `d_remb_bord_lines`
--

INSERT INTO `d_remb_bord_lines` (`numSinistre`, `mntRembourse`) VALUES
('1', ''),
('2', ''),
('7', '25000 UMR');

-- --------------------------------------------------------

--
-- Structure de la table `d_remb_recu`
--

CREATE TABLE `d_remb_recu` (
  `id` int(11) NOT NULL,
  `numRecu` varchar(15) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `d_remb_recu`
--

INSERT INTO `d_remb_recu` (`id`, `numRecu`) VALUES
(1, 'c13424'),
(2, 'c12979'),
(3, 'c13425'),
(4, 'c13426'),
(5, 'c13427'),
(6, 'c13428'),
(7, 'c13430');

-- --------------------------------------------------------

--
-- Structure de la table `d_remb_sinistre`
--

CREATE TABLE `d_remb_sinistre` (
  `numSinistre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `fkidRecu` int(11) NOT NULL,
  `fkidEtat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `d_remb_sinistre`
--

INSERT INTO `d_remb_sinistre` (`numSinistre`, `fkidRecu`, `fkidEtat`) VALUES
('1', 1, 2),
('2', 2, 1),
('3', 3, 4),
('4', 4, 3),
('7', 6, 7);

-- --------------------------------------------------------

--
-- Structure de la table `inquiry`
--

CREATE TABLE `inquiry` (
  `id` int(11) NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `recu` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `time` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `inquiry`
--

INSERT INTO `inquiry` (`id`, `body`, `recu`, `time`) VALUES
(1, 'سلام الله عليكم لماذا لم يكتمل ملفي حت الآن', 'c13424', 1591036894),
(2, 'السلام عليكم وف عنا ذا بلعجله ىةتتعتتعت نتعتعتعتعتت تتعوتعوغاغةغتعتوعتتعتتوعتعتعتع تعتعتعت نتعتعتعتعتعتعوعتعاتعتع تعتعت', 'c13424', 1591040998),
(3, 'ودو أنت ماعندك أكنام تتتننننننننننن زووووع ونتعتهتهتهتهت وهتهت', 'c12979', 1591045019),
(4, 'ودو ما عندك كنام كاع ودو ما عندك كنام كاع ودو ما عندك كنام كاعودو ما عندك كنام ودو ما عندك كنام كاعودو ما عندك كنام كاعكاع   ', 'c12979', 1591045789),
(5, 'ودو ما عندك كنام كاع ودو ما عندك كنام كاع ودو ما عندك كنام كاعودو ما عندك كنام ودو ما عندك كنام كاعودو ما عندك كنام كاعكاع   ', 'c12979', 1591046251),
(6, 'ودو ما عندك كنام كاع ودو ما عندك كنام كاع ودو ما عندك كنام كاعودو ما عندك كنام ودو ما عندك كنام كاعودو ما عندك كنام كاعكاع   ', 'c12979', 1591046844),
(7, 'ودو ما عندك كنام كاع ودو ما عندك كنام كاع ودو ما عندك كنام كاعودو ما عندك كنام ودو ما عندك كنام كاعودو ما عندك كنام كاعكاع   ', 'c12979', 1591046874),
(8, 'ودو ما عندك كنام كاع ودو ما عندك كنام كاع ودو ما عندك كنام كاعودو ما عندك كنام ودو ما عندك كنام كاعودو ما عندك كنام كاعكاع   ', 'c12979', 1591047064),
(9, 'ودو ما عندك كنام كاع ودو ما عندك كنام كاع ودو ما عندك كنام كاعودو ما عندك كنام ودو ما عندك كنام كاعودو ما عندك كنام كاعكاع   ', 'c12979', 1591047234),
(10, 'ودو ما عندك كنام كاع ودو ما عندك كنام كاع ودو ما عندك كنام كاعودو ما عندك كنام ودو ما عندك كنام كاعودو ما عندك كنام كاعكاع   ', 'c12979', 1591047482),
(11, 'تست تست', 'c12979', 1591047855),
(12, 'التىعل ناهاع تتتتت', 'c12979', 1591047912),
(13, 'اتتتهتهاه', 'c12979', 1591048033),
(14, 'غلبعلا هاهاهاه هاعاههاا', 'c12979', 1591048878),
(15, 'ااتاتنمنة', 'c12979', 1591049149),
(16, 'اااااااليب', 'c12979', 1591049258),
(17, 'gfgggg', 'c13424', 1591050335),
(18, 'تسكتنن', 'c13424', 1591050732),
(19, 'غوزغعزعز', 'c13424', 1591052156),
(20, 'ىاتلان', 'c13424', 1591052264),
(21, 'بلات', 'c13424', 1591052582),
(22, 'ةتل', 'c13424', 1591052646),
(23, 'ؤلاالسل', 'c13424', 1591052741),
(24, 'علللغعت نقطه خننت', 'c13424', 1591053006),
(25, 'الجمعه', 'c13424', 1591054053),
(26, 'السبت', 'c13424', 1591054251),
(27, 'lundi', 'c13424', 1591054395),
(28, 'tftftgh yhh', 'c13424', 1591054633),
(29, 'mardi', 'c13424', 1591054726),
(30, 'ابلبب', 'c13424', 1591299552),
(31, 'الحمد الله\nالحمد الله', 'c13424', 1591299700),
(32, 'مرحبا مرحبامرحبا مرحبامرحبا مرحبامرحبا مرحبامرحبا مرحبامرحبا ', 'c13424', 1592209199),
(33, 'ابتبعلبيخل', 'c13424', 1592214753),
(34, 'لبلايتنن ايت', 'c13424', 1592217296),
(35, 'ابالتلا ابغه', 'c13424', 1592217454),
(36, 'التلي تبتلات الت', 'c13424', 1592217881),
(37, 'ايابعبا نلغبعبل ', 'c13424', 1592218453),
(38, 'الالا اللت ', 'c13424', 1592218640),
(39, 'اللي تبيا الب', 'c13424', 1592219085),
(40, 'ليابغب ابغق', 'c13424', 1592226603),
(41, 'عبعبعلتا نلفعب', 'c13424', 1592226840),
(42, 'ابليل ابفعت', 'c13424', 1592227899);

-- --------------------------------------------------------

--
-- Structure de la table `loginTable`
--

CREATE TABLE `loginTable` (
  `id` int(11) NOT NULL,
  `recunni` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `loged` varchar(8) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `loginTable`
--

INSERT INTO `loginTable` (`id`, `recunni`, `loged`) VALUES
(20, 'c22381838', 'false'),
(21, 'c41051809', 'false'),
(22, 'c47121461', 'true');

-- --------------------------------------------------------

--
-- Structure de la table `ref_dossier_etat`
--

CREATE TABLE `ref_dossier_etat` (
  `id` int(11) NOT NULL,
  `libelle` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `ref_dossier_etat`
--

INSERT INTO `ref_dossier_etat` (`id`, `libelle`) VALUES
(1, 'saisie'),
(2, 'premier validation'),
(3, 'pret ranger generation'),
(12, 'deuxieme validation');

-- --------------------------------------------------------

--
-- Structure de la table `ref_remb_etat`
--

CREATE TABLE `ref_remb_etat` (
  `id` int(11) NOT NULL,
  `libelle` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `ref_remb_etat`
--

INSERT INTO `ref_remb_etat` (`id`, `libelle`) VALUES
(1, 'saisie'),
(2, 'premier validation'),
(3, 'deuxieme validation'),
(4, 'en attente de paiment'),
(7, 'en attente de validation bordereau');

-- --------------------------------------------------------

--
-- Structure de la table `table_lang`
--

CREATE TABLE `table_lang` (
  `id` int(11) NOT NULL,
  `frrembourser` text COLLATE utf8_unicode_ci NOT NULL,
  `arrembourser` text COLLATE utf8_unicode_ci NOT NULL,
  `araffiliation` text COLLATE utf8_unicode_ci NOT NULL,
  `fraffiliation` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `table_lang`
--

INSERT INTO `table_lang` (`id`, `frrembourser`, `arrembourser`, `araffiliation`, `fraffiliation`) VALUES
(1, 'En cours du traitement', ' ملفك قيد المعالجه', 'ملفك قيد المعالجه', 'En cours du traitement'),
(2, 'En cours du traitement', ' ملفك قيد المعالجه', 'ملفك قيد المعالجه', 'En cours du traitement'),
(3, 'En cours du traitement', ' ملفك قيد المعالجه', 'تهانينا لك بطاقتك جاهزة', 'félicitation votre carte est prete'),
(4, 'En cours du paiement', 'قيد الدفع', '', ''),
(7, 'En cours du paiement', 'قيد الدفع', '', ''),
(21, 'Votre dossier est en attente du traitement', 'ملفك في انتظار المعالجة', 'ملفك في انتظار المعالجة', 'Votre dossier est en attente du traitement'),
(12, '', '', 'ملفك قيد المعالجه', 'En cours du traitement');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `d_dossier`
--
ALTER TABLE `d_dossier`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `d_immat_recu`
--
ALTER TABLE `d_immat_recu`
  ADD PRIMARY KEY (`idRecu`);

--
-- Index pour la table `d_remb_recu`
--
ALTER TABLE `d_remb_recu`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `d_remb_sinistre`
--
ALTER TABLE `d_remb_sinistre`
  ADD PRIMARY KEY (`numSinistre`);

--
-- Index pour la table `inquiry`
--
ALTER TABLE `inquiry`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `loginTable`
--
ALTER TABLE `loginTable`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ref_dossier_etat`
--
ALTER TABLE `ref_dossier_etat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ref_remb_etat`
--
ALTER TABLE `ref_remb_etat`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `d_dossier`
--
ALTER TABLE `d_dossier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `d_immat_recu`
--
ALTER TABLE `d_immat_recu`
  MODIFY `idRecu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `d_remb_recu`
--
ALTER TABLE `d_remb_recu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `inquiry`
--
ALTER TABLE `inquiry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT pour la table `loginTable`
--
ALTER TABLE `loginTable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `ref_remb_etat`
--
ALTER TABLE `ref_remb_etat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
