const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Tudo certo!');
});

// Esta é a linha mágica que mantém o container vivo
app.listen(3000, '0.0.0.0', () => {
  console.log('App rodando na porta 3000!');
});
