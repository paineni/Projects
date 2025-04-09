from crewai import Agent
from tools import mkbhd_tool
from crewai import LLM
from dotenv import load_dotenv
import os
load_dotenv()

llm = LLM(
    model="ollama/llama3",
    base_url="http://localhost:11434"
)


## Create a senior blog content researcher agent
blog_researcher = Agent(
    role="senior blog content researcher from youtube videos",
    goal="Gather the relevant video content from {topic} the Youtube video",
    verbose=True,
    memory=True,
    backstory="Expert in understanding videos regarding the technology of mobile phones and their features",
    tools=[mkbhd_tool],
    llm=llm,
    allow_delegation=True
    )

## Creating a Expert for blog writer agent with Youtube tool

blog_writer = Agent(
    role="Blog writer",
    goal="Narrate compelling tech stories about the {topic} from the Youtube video",
    verbose=True,
    memory=True,
    backstory="With a flair for storyteling, you simplify and craft complex tech concepts into engaging narratives that captivate and educate the audience",
    tools=[mkbhd_tool],
    llm=llm,
    allow_delegation=False
    )