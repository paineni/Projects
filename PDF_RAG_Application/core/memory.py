import json
import os
from langchain_community.chat_message_histories import ChatMessageHistory
from langchain_core.chat_history import BaseChatMessageHistory
from langchain_core.runnables.history import RunnableWithMessageHistory

HISTORY_DIR = "chat_history"

if not os.path.exists(HISTORY_DIR):
    os.makedirs(HISTORY_DIR)

def get_session_history(session_id: str, store: dict) -> BaseChatMessageHistory:
    file_path = os.path.join(HISTORY_DIR, f"{session_id}.json")

    # Load from file if exists
    if session_id not in store:
        history = ChatMessageHistory()
        if os.path.exists(file_path):
            with open(file_path, "r", encoding="utf-8") as f:
                messages = json.load(f)
                for msg in messages:
                    if msg["type"] == "human":
                        history.add_user_message(msg["content"])
                    elif msg["type"] == "ai":
                        history.add_ai_message(msg["content"])
        store[session_id] = history

    return store[session_id]

def wrap_chain_with_memory(chain, store: dict) -> RunnableWithMessageHistory:
    """
    Wraps a LangChain Runnable with message history support for multi-turn conversation.
    """
    return RunnableWithMessageHistory(
        chain,
        lambda session_id: get_session_history(session_id, store),
        input_messages_key="input",
        history_messages_key="chat_history",
        output_messages_key="answer"
    )

def save_session_history(session_id: str, history: BaseChatMessageHistory):
    file_path = os.path.join(HISTORY_DIR, f"{session_id}.json")
    messages = [{"type": msg.type, "content": msg.content} for msg in history.messages]
    with open(file_path, "w", encoding="utf-8") as f:
        json.dump(messages, f, indent=2)
