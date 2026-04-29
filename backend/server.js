const express = require('express');
const cors = require('cors');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('./database');

const app = express();
const PORT = 3000;
const SECRET_KEY = "klucz123"; // W przyszłości przenieś to do .env

app.use(cors());
app.use(express.json());

// --- ENDPOINT REJESTRACJI ---
app.post('/register', async (req, res) => {
    const { email, password } = req.body;

    // 1. Walidacja danych
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email || !emailRegex.test(email)) {
        return res.status(400).json({ error: "Niepoprawny format adresu email." });
    }
    if (!password || password.length < 8) {
        return res.status(400).json({ error: "Hasło musi mieć co najmniej 8 znaków." });
    }

    try {
        // 2. Hashowanie hasła (10 salt rounds)
        const hashedPassword = await bcrypt.hash(password, 10);

        // 3. Zapis do bazy
        const query = `INSERT INTO Users (email, password) VALUES (?, ?)`;
        db.run(query, [email, hashedPassword], function(err) {
            if (err) {
                if (err.message.includes("UNIQUE constraint failed")) {
                    return res.status(409).json({ error: "Ten email jest już zarejestrowany." });
                }
                return res.status(500).json({ error: "Błąd bazy danych." });
            }
            res.status(201).json({ message: "Użytkownik zarejestrowany pomyślnie!", userId: this.lastID });
        });
    } catch (error) {
        res.status(500).json({ error: "Błąd serwera podczas rejestracji." });
    }
});

// --- ENDPOINT LOGOWANIA ---
app.post('/login', (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ error: "Email i hasło są wymagane." });
    }

    // 1. Szukanie użytkownika
    const query = `SELECT * FROM Users WHERE email = ?`;
    db.get(query, [email], async (err, user) => {
        if (err) return res.status(500).json({ error: "Błąd bazy danych." });
        if (!user) return res.status(401).json({ error: "Błędny email lub hasło." });

        // 2. Porównanie hasła z hashem
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(401).json({ error: "Błędny email lub hasło." });

        // 3. Generowanie tokena JWT
        const token = jwt.sign(
            { id: user.id, email: user.email },
            SECRET_KEY,
            { expiresIn: '7d' } // Token ważny przez 7 dni
        );

        res.json({
            message: "Zalogowano pomyślnie!",
            token: token,
            user: { id: user.id, email: user.email }
        });
    });
});

// Middleware do autoryzacji tokena JWT
const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Format: "Bearer TOKEN"

    if (!token) return res.status(401).json({ error: "Dostęp zabroniony. Brak tokena." });

    jwt.verify(token, SECRET_KEY, (err, user) => {
        if (err) return res.status(403).json({ error: "Token jest nieprawidłowy lub wygasł." });
        req.user = user;
        next();
    });
};

// --- ENDPOINT POBIERANIA LEKÓW UŻYTKOWNIKA ---
app.get('/medications', authenticateToken, (req, res) => {
    const userId = req.user.id;
    const query = `SELECT * FROM Medications WHERE user_id = ?`;

    db.all(query, [userId], (err, rows) => {
        if (err) return res.status(500).json({ error: "Błąd bazy danych podczas pobierania leków." });
        res.json(rows);
    });
});

// --- ENDPOINT DODAWANIA NOWEGO LEKU ---
app.post('/medications', authenticateToken, (req, res) => {
    const { name, dosage } = req.body;
    const userId = req.user.id;

    if (!name || !dosage) {
        return res.status(400).json({ error: "Nazwa leku i dawkowanie są wymagane." });
    }

    const query = `INSERT INTO Medications (user_id, name, dosage) VALUES (?, ?, ?)`;
    db.run(query, [userId, name, dosage], function(err) {
        if (err) return res.status(500).json({ error: "Błąd bazy danych podczas dodawania leku." });
        res.status(201).json({
            message: "Lek dodany pomyślnie!",
            medicationId: this.lastID
        });
    });
});

app.get('/', (req, res) => {
    res.json({ message: 'Serwer PILL4U działa poprawnie!' });
});

app.listen(PORT, () => {
    console.log(`Serwer wystartował na porcie: http://localhost:${PORT}`);
});