const express = require("express");
const os = require("os");

const app = express ();
const PORT = process.env.PORT || 3000

app.get("/", (req, res) => {
    res.json({
        message: "TerraForge application is running🚀",
        hostname: os.hostname,
        uptime: process.uptime(),
        timestamp: new Date().toISOString()
    });

});

app.get("/health", (req, res) => {
    res.status(200).send("OK");
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
    console.log(`Access the app at: http://localhost:${PORT}/`);
});