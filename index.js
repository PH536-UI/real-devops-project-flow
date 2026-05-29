const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.send("App rodando no ECS LocalStack!");
});

app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

app.listen(3000, "0.0.0.0", () => {
  console.log("App rodando na porta 3000!");
});
