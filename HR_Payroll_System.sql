-- ==========================================================
-- PROJEKT: Personal- & Gehaltsverwaltungssystem (HR)
-- ZIEL: Verwaltung von Mitarbeiterdaten und Finanzberechnungen
-- ==========================================================

-- 1. Tabellen erstellen
CREATE TABLE Mitarbeiter (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Abteilung VARCHAR(50),
    Position VARCHAR(50),
    Eintrittsdatum DATE,
    Grundgehalt DECIMAL(10, 2)
);

CREATE TABLE Gehaltsabrechnung (
    AbrechnungsID INT PRIMARY KEY,
    EmpID INT,
    Zahlungsdatum DATE,
    Bonus DECIMAL(10, 2),
    Abzuege DECIMAL(10, 2), -- Steuern und Sozialabgaben
    FOREIGN KEY (EmpID) REFERENCES Mitarbeiter(EmpID)
);

-- 2. Beispieldaten einfügen
INSERT INTO Mitarbeiter VALUES 
(1, 'Thomas Müller', 'IT', 'Software Entwickler', '2022-01-10', 5500.00),
(2, 'Sabine Schneider', 'HR', 'HR Managerin', '2021-03-15', 4800.00),
(3, 'Stefan Wagner', 'Logistik', 'Lagerleiter', '2023-06-01', 3900.00);

INSERT INTO Gehaltsabrechnung VALUES 
(101, 1, '2024-01-31', 250.00, 1100.00),
(102, 2, '2024-01-31', 0.00, 950.00),
(103, 3, '2024-01-31', 150.00, 750.00);

-- 3. Analyse-Abfrage: Nettogehalt-Berechnung
-- Diese Abfrage berechnet das tatsächliche Auszahlungsgehalt
SELECT 
    m.Name, 
    m.Abteilung,
    m.Grundgehalt,
    (m.Grundgehalt + g.Bonus - g.Abzuege) AS Netto_Auszahlung,
    m.Eintrittsdatum
FROM Mitarbeiter m
JOIN Gehaltsabrechnung g ON m.EmpID = g.EmpID
WHERE m.Abteilung != 'Marketing' -- Beispiel für Filterung
ORDER BY Netto_Auszahlung DESC;