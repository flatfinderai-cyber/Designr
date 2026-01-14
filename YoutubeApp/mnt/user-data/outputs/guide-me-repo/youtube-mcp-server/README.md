# YouTube MCP Server

MCP server for extracting YouTube video metadata and transcripts. Designed for educational content conversion apps.

## Tools

| Tool | Description | API Key Required |
|------|-------------|------------------|
| `youtube_get_video_details` | Get video metadata (title, duration, stats, thumbnails) | Yes |
| `youtube_get_transcript` | Extract video transcript with timestamps | No |
| `youtube_list_transcript_languages` | List available caption languages | No |

## Setup

### 1. Install Dependencies

```bash
npm install
```

### 2. Set Environment Variables

```bash
# Required for youtube_get_video_details
export YOUTUBE_API_KEY="your-api-key-here"

# Optional: Use HTTP transport instead of stdio
export TRANSPORT="http"
export PORT="3000"
```

Get your API key: https://console.cloud.google.com/apis/credentials

### 3. Build

```bash
npm run build
```

### 4. Run

```bash
# stdio mode (default)
npm start

# HTTP mode
TRANSPORT=http npm start
```

## Usage Examples

### Get Video Details

```json
{
  "tool": "youtube_get_video_details",
  "params": {
    "video_id": "dQw4w9WgXcQ",
    "response_format": "json"
  }
}
```

### Get Transcript

```json
{
  "tool": "youtube_get_transcript",
  "params": {
    "video_id": "https://youtube.com/watch?v=dQw4w9WgXcQ",
    "language": "en",
    "include_timestamps": true
  }
}
```

### List Available Languages

```json
{
  "tool": "youtube_list_transcript_languages",
  "params": {
    "video_id": "dQw4w9WgXcQ"
  }
}
```

## MCP Client Configuration

Add to your MCP client config:

```json
{
  "mcpServers": {
    "youtube": {
      "command": "node",
      "args": ["/path/to/youtube-mcp-server/dist/index.js"],
      "env": {
        "YOUTUBE_API_KEY": "your-api-key"
      }
    }
  }
}
```

## Response Formats

Both `markdown` (default) and `json` formats are supported. Use JSON for programmatic processing, Markdown for human readability.

## Error Handling

- Invalid video ID: Check format (11 characters) or URL validity
- No captions: Video may not have subtitles enabled
- API key errors: Verify YOUTUBE_API_KEY is set correctly
- Rate limits: YouTube API has daily quotas

## License

MIT - © 2024-2025 Lila Inglis Abegunrin
