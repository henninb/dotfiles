const { createProxyMiddleware } = require("http-proxy-middleware");

module.exports = function (app) {

  app.use(
    "/feed/json/nhl-2021/minnesota-wild",
    createProxyMiddleware({
      target:
        "https://fixturedownload.com",
      // secure: true,
      // loglevel: 'debug',
      headers: {
        accept: "application/json",
        method: "GET",
      },
      changeOrigin: true,
      // router: {
      //   "/api/admin": "https://culture.seocho.go.kr:3000",
      // },
    })
  );

  app.use(
    "/feed/json/nba-2021/minnesota-timberwolves",
    createProxyMiddleware({
      target:
        "https://fixturedownload.com",
      // secure: true,
      // loglevel: 'debug',
      headers: {
        accept: "application/json",
        method: "GET",
      },
      changeOrigin: true,
      // router: {
      //   "/api/admin": "https://culture.seocho.go.kr:3000",
      // },
    })
  );

  app.use(
    "/api/v1/schedule",
    createProxyMiddleware({
      target:
        "https://statsapi.mlb.com/api/v1/schedule?startDate=1/01/2022&endDate=12/31/2022&gameTypes=R&sportId=1&teamId=142&hydrate=decisions",
      // secure: true,
      // loglevel: 'debug',
      headers: {
        accept: "application/json",
        method: "GET",
      },
      changeOrigin: true,
      // router: {
      //   "/api/admin": "https://culture.seocho.go.kr:3000",
      // },
    })
  );

  app.use(
    "/v2/pws/observations/current",
    createProxyMiddleware({
      target:
        'https://api.weather.com',
        // 'https://api.weather.com/v2/pws/observations/current?apiKey=e1f10a1e78da46f5b10a1e78da96f525&units=e&stationId=KMNCOONR65&format=json',
      // secure: true,
      // loglevel: 'debug',
      headers: {
        accept: "application/json",
        method: "GET",
      },
      changeOrigin: true,
      // router: {
      //   "/api/admin": "https://culture.seocho.go.kr:3000",
      // },
    })
  );

  //app.listen(3001);
};
