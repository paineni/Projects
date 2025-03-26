# 🚀 PDF + Web Search Assistant with LangChain, FAISS & GROQ  
**Conversational RAG + Web-Search Agent with PDF Uploads, LLaMA3 / DeepSeek, and Chat Memory**

![Python](https://img.shields.io/badge/Python-3.8%2B-blue)
![RAG](https://img.shields.io/badge/RAG-Retrieval%20Augmented%20Generation-blueviolet)
![LLMs](https://img.shields.io/badge/LLMs-Large%20Language%20Models-critical)
![GROQ](https://img.shields.io/badge/LLM%20Provider-GROQ-orange)
![Model](https://img.shields.io/badge/Model-LLaMA3%20%7C%20DeepSeek-red)
![Generative AI](https://img.shields.io/badge/AI-Generative%20AI-lightgrey)
![FAISS](https://img.shields.io/badge/Vector%20DB-FAISS-blue)
![HuggingFace](https://img.shields.io/badge/Embeddings-HuggingFace-yellow)
![LangChain](https://img.shields.io/badge/Framework-LangChain-9cf)
![Agent](https://img.shields.io/badge/Agent-ZeroShot%20ReAct-informational)
![Reasoning](https://img.shields.io/badge/Reasoning-Tool--Based%20Planning-lightgrey)
![Search](https://img.shields.io/badge/Search-Wikipedia%20%7C%20DuckDuckGo-lightgrey)
![Memory](https://img.shields.io/badge/Memory-Optional%20Conversational%20Memory-blue)
![Streamlit](https://img.shields.io/badge/UI-Streamlit-brightgreen)
![Deploy](https://img.shields.io/badge/Deployment-Streamlit%20Cloud%20%7C%20Spaces-success)
![License](https://img.shields.io/badge/License-MIT-green)
![Open Source Love](https://img.shields.io/badge/%E2%9D%A4%EF%B8%8F-Open%20Source-pink)

---

## 📚 Key Features

- 🧠 **Zero-Shot ReAct Agent**: Uses LangChain’s `ZeroShotAgent` with ReAct (Reason + Act) logic to dynamically select tools and solve complex questions.
- 🧩 **Tool-Based Reasoning**: PDF retrieval, web search, and Wikipedia lookup are exposed as LangChain `Tools`, allowing the LLM to orchestrate multi-step answers.
- 📄 **PDF Upload + Indexing**: Upload one or more PDF files and index them into FAISS using HuggingFace's `all-MiniLM-L6-v2` embeddings.
- ⚡ **Semantic Chunking + Vector Search**: Splits PDFs into meaningful text chunks, embeds them, and searches via FAISS for relevance.
- 🌐 **Web Search Tools**: Access general knowledge using DuckDuckGo, Wikipedia, and Arxiv tools.
- 🤖 **LLM Model Switcher**: Select between `LLaMA3-8b` and `DeepSeek-R1-Distill-70B` (powered by GROQ) from the sidebar.
- 💬 **Streamlit Chat UI**: Modern ChatGPT-style interface using `st.chat_input()` and `st.chat_message()` for real-time multi-turn chat.
- 🔁 **Reset + Restart Button**: Easily restart conversations using a one-click sidebar button.
- 🧠 **Optional Conversational RAG Mode**: Toggle in a memory-enabled RAG chain that tracks chat history across sessions.
- 🧱 **Modular Codebase**: Clean `core/` architecture with plug-and-play modules for retrievers, chains, tools, and memory.

---

## 🔧 Installation Steps

### 1. Clone the Repository
```bash
git clone https://github.com/paineni/Projects.git
cd Projects/PDF_RAG_Application
```

### 2. Create and Activate a Virtual Environment
```bash
# Create virtual environment
python -m venv venv

# Activate (choose your OS)
# Windows
venv\Scripts\activate

# macOS/Linux
source venv/bin/activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Set Up Environment Variables
Create a `.env` file and add your credentials:
```ini
HF_TOKEN=your_huggingface_token
```

### 5. 💾 Chat Memory & Persistence
- Chat history is maintained per session
- Saved automatically to /chat_history/
- Reloading the app with the same session ID will restore previous conversations
---

## 🧑‍💻 Usage

### 🚀 Launch the App
```bash
streamlit run app.py
```

---
### ❓ Ask Questions
1. Type your question in the ChatGPT-style input.
2. The agent will: 
    - Reformulate the question (if needed)
    - Select the best tool (PDF RAG, Wikipedia, Arxiv, DuckDuckGo)
    - Return a grounded, AI-generated answer

### 🗃️ Project Structure
```bash
pdf_rag_app/
├── app.py                     # Streamlit UI
├── core/
│   ├── llm.py                 # Load LLaMA3 from Groq
│   ├── embeddings.py          # Load HuggingFace Embeddings
│   ├── retriever.py           # FAISS + contextual retriever setup
│   ├── qa_chain.py            # Prompt template + RAG chain
|   ├── tools.py               # search tools + RAG chain 
│   └── memory.py              # Chat history management + persistence
├── utils/
│   └── pdf_loader.py          # PDF parsing and text extraction
├── chat_history/              # (Auto-created) Stores saved JSON chat logs
├── requirements.txt
└── .env
```
---

## 🔍 Example Use Cases

- 📚 Research Paper Assistant  
- 📄 Resume Q&A Bot  
- ⚖️ Legal Document Helper  
- 🌐 Hybrid Assistant – Ask general questions and let the agent search the web automatically
- 🏢 Enterprise Knowledge Search – Ask questions across internal whitepapers or policy documents

---

## 🤝 Contributing

PRs and suggestions are welcome!  
Let’s improve this together!!

---
## 📜 License
This project is licensed under the MIT License.
