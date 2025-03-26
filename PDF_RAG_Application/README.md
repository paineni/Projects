# 📄 PDF Q&A System with LangChain, FAISS & HuggingFace Embeddings 🤖🔍  
**Retrieval-Augmented Generation (RAG) Application with Conversational Memory**

![Python](https://img.shields.io/badge/Python-3.8%2B-blue)
![RAG](https://img.shields.io/badge/RAG-Retrieval%20Augmented%20Generation-blueviolet)
![LLMs](https://img.shields.io/badge/LLMs-Large%20Language%20Models-critical)
![Generative AI](https://img.shields.io/badge/AI-Generative%20AI-lightgrey)
![FAISS](https://img.shields.io/badge/Vector%20DB-FAISS-blue)
![GROQ](https://img.shields.io/badge/LLM%20Provider-GROQ-orange)
![LLaMA3](https://img.shields.io/badge/Model-LLaMA3-red)
![HuggingFace](https://img.shields.io/badge/Embeddings-HuggingFace-yellow)
![LangChain](https://img.shields.io/badge/Framework-LangChain-9cf)
![Streamlit](https://img.shields.io/badge/UI-Streamlit-brightgreen)
![Deploy](https://img.shields.io/badge/Deployment-Streamlit%20Cloud%20or%20Spaces-success)
![License](https://img.shields.io/badge/License-MIT-green)
![Open Source Love](https://img.shields.io/badge/%E2%9D%A4%EF%B8%8F-Open%20Source-pink)
---

## 📚 Key Features

- 🔍 **RAG Architecture**: Combines document retrieval (FAISS + HuggingFace embeddings) with LLM-based generation (LLaMA3) to provide grounded answers.
- 📄 **PDF Upload**: Upload one or more PDFs via the Streamlit interface.
- 🧩 **Text Chunking & Embedding**: Splits documents into semantic chunks and embeds them using HuggingFace’s `all-MiniLM-L6-v2`.
- ⚡ **FAISS Vector Search**: Performs high-speed similarity search on embedded chunks.
- 🧠 **Conversational Memory**: Maintains per-session multi-turn chat history with contextualized question reformulation.
- 💾 **Persistent Chat History**: Chat history is saved to disk per session and automatically reloaded.
- 🖥️ **Streamlit UI**: Clean interface for uploading files, entering queries, and viewing context.
- 📎 **Document Traceability**: Inspect source chunks used to generate each answer.
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
### 📥 Embed PDFs
Click the **"Document Embedding"** button in the UI to create the FAISS vector store.
---
### ❓ Ask Questions
1. Type a query.
2. The app will:
   - Retrieve relevant document chunks
   - Pass them to the LLM
   - Generate a grounded answer

### 🗃️ Project Structure
```bash
pdf_rag_app/
├── app.py                     # Streamlit UI
├── core/
│   ├── llm.py                 # Load LLaMA3 from Groq
│   ├── embeddings.py          # Load HuggingFace Embeddings
│   ├── retriever.py           # FAISS + contextual retriever setup
│   ├── qa_chain.py            # Prompt template + RAG chain
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
- 🏢 Company Knowledge Base Search  

---

## 🤝 Contributing

PRs and suggestions are welcome!  
Let’s improve this together!!

---
## 📜 License
This project is licensed under the MIT License.
