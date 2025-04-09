from crewai import Task
from tools import mkbhd_tool
from agents import blog_researcher,blog_writer

## Research Task
research_task = Task(
    description="Identify the video {topic}. Get detailed information about the video ",
    expected_output="A comprehensive 3-4 paragraphs long report based on the topic, including key points, insights, and any relevant details that would be useful for writing a blog post.",
    tools=[mkbhd_tool],
    agent=blog_researcher,
)

## Writing Task
write_task = Task(
    description=(
        "Based on the topic: {topic}, generate a concise, well-formatted summary of the corresponding YouTube video. "
        "Use information retrieved from the channel to highlight key messages, main takeaways, and insights. "
        "Structure the content clearly using appropriate headings and include emojis where suitable to enhance readability and engagement."
    ),
    expected_output=(
        "A clear and engaging summary suitable for a 2-minute read. "
        "The output should include:\n"
        "- A brief introduction\n"
        "- Key highlights and insights (with headings)\n"
        "- Any relevant opinions or commentary\n"
        "- Emojis where appropriate to match the tone and enhance flow\n\n"
        "The final output should be suitable for blog publication and saved as a markdown file."
    ),
    tools=[mkbhd_tool],
    async_execution=False,
    agent=blog_writer,
    output_file="new_blog.md"
)
