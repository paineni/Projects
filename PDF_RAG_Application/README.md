# 📄 PDF Q&A System with LangChain, FAISS & HuggingFace Embeddings 🤖🔍  
**Retrieval-Augmented Generation (RAG) Application**

![Python](https://img.shields.io/badge/Python-3.8%2B-blue)
![RAG](https://img.shields.io/badge/RAG-Retrieval%20Augmented%20Generation-blueviolet)
![LLMs](https://img.shields.io/badge/LLMs-Large%20Language%20Models-critical)
![GenAI](https://img.shields.io/badge/AI-Type%20-%20Generative%20AI-lightgrey)
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
- 📄 **PDF Loader**: Automatically scans and ingests all PDFs from a directory.
- 🧩 **Chunking & Embedding**: Splits large documents into manageable segments and embeds them using HuggingFace’s `all-MiniLM-L6-v2` model.
- ⚡ **Vector Store with FAISS**: Efficient semantic similarity search over embedded chunks.
- 🧠 **Context-Aware LLM Responses**: LLaMA3 generates answers strictly based on the retrieved document context using LangChain’s `stuff` document chain.
- 🖥️ **Streamlit Frontend**: Intuitive UI for embedding documents and querying in real time.
- 📎 **Document Traceability**: View the exact document chunks that contributed to the final response.

---

## 🔧 Installation Steps

### 1. Clone the Repository
```bash
git clone https://github.com/paineni/Projects.git
cd Projects/pdf_rag_app
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
GROQ_API=your_groq_api_key
HF_TOKEN=your_huggingface_token
```

### 5. Add Your PDFs
Place all PDF files inside the `research_papers/` folder.

---

## 🧑‍💻 Usage

### 🚀 Launch the App
```bash
streamlit run app.py
```

### 📥 Embed PDFs
Click the **"Document Embedding"** button in the UI to create the FAISS vector store.

### ❓ Ask Questions
1. Type a query.
2. The app will:
   - Retrieve relevant document chunks
   - Pass them to the LLM
   - Generate a grounded answer

### 📂 View Source Chunks
Expand the “Documents Similarity Search” section to inspect supporting document text.

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

