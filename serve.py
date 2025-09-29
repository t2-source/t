from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
import mimetypes

# pastikan .js dianggap application/javascript
mimetypes.add_type("application/javascript", ".js")

class Handler(SimpleHTTPRequestHandler):
    pass

PORT = 8000
with ThreadingHTTPServer(("", PORT), Handler) as httpd:
    print(f"[*] Serving on http://localhost:{PORT}")
    httpd.serve_forever()
