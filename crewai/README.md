# 📝 Multi-Agent Blog Generator from YouTube Videos  

A multi-agent system powered by **crewAI** and **Ollama LLaMA3** that automatically researches YouTube videos and generates engaging blog posts.  

This project demonstrates how **collaborating AI agents** can transform raw video content into structured, publication-ready blog articles.  

## 🧑‍💻 Tech Stack & Keywords  
**Python**, **crewAI**, **LLMs (LLaMA3 / Ollama)**, **YouTube Channel Search Tool**, **LangChain Agents**, **Markdown Generation**, **Content Automation**, **Agent Collaboration**  

## 📚 Key Features  
- 🧠 **Senior Blog Researcher Agent** → Extracts detailed insights from YouTube videos.  
- ✍️ **Blog Writer Agent** → Crafts compelling, structured blog articles with headings and emojis.  
- 🔍 **YouTube Channel Search Integration** → Retrieves video details using the `YoutubeChannelSearchTool`.  
- ⚡ **Sequential Multi-Agent Workflow** → Orchestrated with **crewAI** for smooth collaboration.  
- 📄 **Markdown Output** → Blog post is automatically saved as `new_blog.md`.  
- 🧩 **Memory & Delegation** → Agents share context and reasoning across tasks.  

## 🔧 Installation  

```bash
# Clone the repository
git clone https://github.com/yourusername/multi-agent-blog-generator.git
cd multi-agent-blog-generator

# Create and activate a virtual environment
python -m venv venv
source venv/bin/activate   # macOS/Linux
venv\Scripts\activate      # Windows

# Install dependencies
pip install -r requirements.txt
```

(Optional) Add API keys or configs in `.env`.

## 🚀 Usage  

```python
from crew import crew

# Run the multi-agent pipeline on a YouTube video
results = crew.kickoff(inputs={"topic":"https://www.youtube.com/watch?v=E76CUtSHMrU"})
```

📄 Output: The generated blog post will be saved as **`new_blog.md`**.  

## 🗂 Project Structure  

```
multi-agent-blog-generator/
├── agents.py      # Defines researcher & writer agents
├── crew.py        # Orchestrates agents + tasks
├── tasks.py       # Research and writing tasks
├── tools.py       # YouTube search tool (mkbhd_tool)
├── new_blog.md    # Auto-generated blog output
├── requirements.txt
└── README.md      # Project documentation
```

## 🔍 Example Use Cases  
- 📰 **Tech Blogs** → Summarize smartphone review videos into blog posts.  
- 📚 **Educational Content** → Turn lectures/tutorials into readable study notes.  
- 📊 **Business Intelligence** → Convert webinars into concise executive summaries.  
- 🌐 **Content Automation** → Generate SEO-ready blogs from video sources.  

## 🤝 Contributing  
Pull requests, issues, and feature suggestions are welcome!  

## 📜 License  
This project is licensed under the **MIT License**.  
