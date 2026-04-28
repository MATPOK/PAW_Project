const express = require('express');
const cors = require('cors');
const db = require('./database'); // Importujemy naszą bazę z poprzedniego kroku

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(express.json()); // Pozwala serwerowi czytać format JSON

// Testowy endpoint API
app.get('/', (req, res) => {
    res.json({ message: 'Serwer PILL4U działa poprawnie!' });
});

// Start serwera
app.listen(PORT, () => {
    console.log(`Serwer wystartował na porcie: http://localhost:${PORT}`);
});