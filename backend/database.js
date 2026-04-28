const sqlite3 = require('sqlite3').verbose();

// Podłączenie do bazy danych (utworzy plik pill4u.db, jeśli nie istnieje)
const db = new sqlite3.Database('./pill4u.db', (err) => {
    if (err) {
        console.error('Błąd połączenia z bazą SQLite:', err.message);
    } else {
        console.log('Połączono z bazą danych SQLite.');
        db.run('PRAGMA foreign_keys = ON'); // Włączenie obsługi relacji między tabelami
    }
});

// Tworzenie tabel
db.serialize(() => {
    // Tabela Użytkowników
    db.run(`CREATE TABLE IF NOT EXISTS Users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )`);

    // Tabela Leków (przypisana do użytkownika)
    db.run(`CREATE TABLE IF NOT EXISTS Medications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        dosage TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE
    )`);

    // Tabela Harmonogramu (kiedy brać dany lek)
    db.run(`CREATE TABLE IF NOT EXISTS Schedules (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        medication_id INTEGER NOT NULL,
        take_time TEXT NOT NULL,
        FOREIGN KEY (medication_id) REFERENCES Medications (id) ON DELETE CASCADE
    )`);
});

module.exports = db;