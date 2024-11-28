const express = require("express");
const cors = require("cors");
const app = express();
const port = 3000;

// CORS 미들웨어 적용 (플러터 앱 연결)
app.use(cors());

// db.json 데이터 불러오기
const data = require("./db.json");

// 엔드포인트 설정
app.get("/leagues", (req, res) => {
  res.json(data.leagues);
});

app.get("/teams", (req, res) => {
  res.json(data.teams);
});

app.get("/players", (req, res) => {
  res.json(data.players);
});

// 서버 시작
app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
