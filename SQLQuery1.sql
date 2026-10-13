
USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'HotelProDB')
BEGIN
    ALTER DATABASE HotelProDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HotelProDB;
END
GO


CREATE DATABASE HotelProDB;
GO

USE HotelProDB;
GO


CREATE TABLE Musteriler (
    MusteriID INT IDENTITY(1,1) PRIMARY KEY,
    AdSoyad NVARCHAR(100) NOT NULL,
    TCNo NVARCHAR(11),
    Telefon NVARCHAR(20),
    Eposta NVARCHAR(100),
    Adres NVARCHAR(250)
);
GO


CREATE TABLE Odalar (
    OdaID INT IDENTITY(1,1) PRIMARY KEY,
    OdaNo INT UNIQUE NOT NULL,
    OdaTipi NVARCHAR(50) NOT NULL,
    Kapasite INT NOT NULL,
    GunlukFiyat DECIMAL(10,2) NOT NULL,
    Durum NVARCHAR(30) NOT NULL
);
GO


CREATE TABLE Rezervasyonlar (
    RezervasyonID INT IDENTITY(1,1) PRIMARY KEY,
    MusteriID INT NOT NULL FOREIGN KEY REFERENCES Musteriler(MusteriID),
    OdaID INT NOT NULL FOREIGN KEY REFERENCES Odalar(OdaID),
    GirisTarihi DATE NOT NULL,
    CikisTarihi DATE NOT NULL,
    KisiSayisi INT NOT NULL,
    ToplamUcret DECIMAL(10,2) NOT NULL,
    Durum NVARCHAR(30) NOT NULL
);
GO


CREATE TABLE Odemeler (
    OdemeID INT IDENTITY(1,1) PRIMARY KEY,
    RezervasyonID INT NOT NULL FOREIGN KEY REFERENCES Rezervasyonlar(RezervasyonID),
    OdemeTarihi DATETIME NOT NULL,
    Tutar DECIMAL(10,2) NOT NULL,
    OdemeTipi NVARCHAR(30) NOT NULL
);
GO


CREATE TABLE Konaklamalar (
    KonaklamaID INT IDENTITY(1,1) PRIMARY KEY,
    RezervasyonID INT NOT NULL FOREIGN KEY REFERENCES Rezervasyonlar(RezervasyonID),
    GercekGirisTarihi DATETIME,
    GercekCikisTarihi DATETIME,
    Notlar NVARCHAR(500)
);
GO

SELECT * FROM Musteriler;
SELECT * FROM Odalar;
SELECT * FROM Rezervasyonlar;
SELECT * FROM Odemeler;
SELECT * FROM Konaklamalar;