
const express = require('express');
const axios = require('axios');
const app = express();

app.use(express.json());

const OPENAI_API_KEY = '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';

app.post('/message', async (req, res) => {
    try {
        const userMessage = req.body.message;
        const response = await axios.post(
            'https://api.openai.com/v1/chat/completions',
            {
                model: "gpt-3.5-turbo",
                messages: [{
                    role: "system",
                    content: "You are a helpful assistant."
                },{
                    role: "user",
                    content: userMessage
                }]
            },
            {
                headers: {
                    'Authorization': `Bearer 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`,
                    'Content-Type': 'application/json'
                }
            }
        );

        res.json({ reply: response.data.choices[0].message.content });
    } catch (error) {
        console.error('Error calling OpenAI API:', error);
        res.status(500).send('Error processing your message');
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
