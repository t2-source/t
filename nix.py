import asyncio
import threading
import mimetypes
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from playwright.async_api import async_playwright

def start_server(port=8000):
    mimetypes.add_type("application/javascript", ".js")

    class Handler(SimpleHTTPRequestHandler):
        def log_message(self, format, *args):
            print(f"[httpd] {self.address_string()} - {format % args}")

    httpd = ThreadingHTTPServer(("0.0.0.0", port), Handler)
    thread = threading.Thread(target=httpd.serve_forever, daemon=True)
    thread.start()
    print(f"[*] Serving indexnix.html di http://localhost:{port}")
    return httpd

async def run_playwright():
    url = "http://localhost:8000/indexnix.html"

    async with async_playwright() as p:
        browser = await p.chromium.launch(
            headless=True,
            args=["--no-sandbox", "--disable-web-security"]
        )
        page = await browser.new_page()

        # log listener
        page.on("console", lambda msg: print("[console]", msg.type, msg.text))
        page.on("pageerror", lambda err: print("[pageerror]", err))
        page.on("crash", lambda: print("[crash] Page crashed"))

        print(f"[*] Membuka {url}")
        try:
            await page.goto(url, wait_until="domcontentloaded", timeout=30000)
        except Exception as e:
            print("[goto error]", e)

        # biar tidak langsung close
        while True:
            await asyncio.sleep(1)

if __name__ == "__main__":
    start_server(8000)
    asyncio.run(run_playwright())
