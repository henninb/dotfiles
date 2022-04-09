const { Miniflare } = require("miniflare");
const mf = new Miniflare();
const makeRequest = async () => {
  const res = await mf.dispatchFetch("http://localhost:8787/");

  return res.text();
};
const testNamespace = async () => {
  const counterNamespace = await mf.getKVNamespace("COUNTER_NAMESPACE");
  const count = await counterNamespace.get("/");

  console.log("KV:", count);

  return count;
};
const testRequests = async (times) => {
  for (let i = 0; i < times; i++) {
    console.log("Response:", await makeRequest());
  }
};
const test = async () => {
  await testRequests(3);
  await testNamespace();
};

test();
